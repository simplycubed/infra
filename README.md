# builder-infra

This project contains the Terraform configuration for GCP including an init script to enable GCP project APIs and create a Terraform service account.

## Usage

- Login to Terraform Cloud and link this Github repository
- Create a Terraform Cloud Workspace to manage the GCP project
- Install gcloud CLI and login to the GCP Project
- Login with gcloud `gcloud auth login`
- Dev - `gcloud config set project simplycubed-builder-dev`
- Prod - `gcloud config set project simplycubed-builder-prod`
- Execute the following init script


```bash
# DEV
# ./init.sh $PROJECT_NAME $ORGANIZATION_ID $BILLING_ACCOUNT_ID $CREATE_SERVICE_ACCOUNT_KEY $SUPPORT_EMAIL
./init.sh simplycubed-builder-dev 1013393027722 false true support@simplycubed.com
```

```bash
# PROD
# ./init.sh $PROJECT_NAME $ORGANIZATION_ID $BILLING_ACCOUNT_ID $CREATE_SERVICE_ACCOUNT_KEY $SUPPORT_EMAIL
./init.sh simplycubed-builder-prod 1013393027722 false true support@simplycubed.com
```

- Terraform service account will be generated with access *key.json*.
- Provide content of key.json to a terraform variable **credentials**
- Configure ./variables.tf values as Variables within the specific environment Workspace in Terraform Cloud.
- Add terraform service account email as an owner of support email user group in Google Workspace.
- Queue Plan in Terraform Cloud to confirm the project is configured correctly.

## OAuth Concent Screen

- App name: `OAUTH Tooling`
- User support email: `support@simplycubed.com`
- Authorized domains: 
  - `simplycubed.dev`
  - `simplycubed.com` - not required for PROD
- Developer Contact information: `support@simplycubed.com`

## Support Email Group for IAP

- Create an email group in [Google Workspace](https://groups.google.com)
- Set the Terraform service account created by the init script as the owner of the group
  - `terraform@${project_id}.iam.gserviceaccount.com`

## Grafana OAuth Credentials

- Go to [OAuth 2.0 Client IDs](https://console.developers.google.com/apis/credentials).
- Click Create Credentials, then click OAuth Client ID in the drop-down menu
- Enter the following:
- Application Type: `Web Application`
- Name: `Grafana`
- Authorized JavaScript Origins: `https://grafana.simplycubed.dev`
- Authorized Redirect URLs: `https://grafana.simplycubed.dev/login/google`
- Click Create
- Copy the Client ID and Client Secret from the `OAuth Client` modal
- Provide client Id value to variable *grafana_oauth_client_id* and Secret value to variable *grfana_oauth_secret*

## Argo-CD OAuth Credentials

- Go to [OAuth 2.0 Client IDs](https://console.developers.google.com/apis/credentials).
- Click Create Credentials, then click OAuth Client ID in the drop-down menu
- Enter the following:
- Application Type: `Web Application`
- Name: `Argocd`
- Authorized JavaScript Origins: `https://argo-cd.simplycubed.dev`
- Authorized Redirect URLs: `https://argo-cd.simplycubed.dev/api/dex/callback`
- Click Create
- Copy the Client ID and Client Secret from the `OAuth Client` modal
- Provide client Id value to variable *arogcd_oauth_client_id* and Secret value to variable *argocd_oauth_secret*

## GitHub Deploy Key Used by Argo CD

- Run following command to generate a public and private key pair
  ``` ssh-keygen -t rsa ```
- Add the [GitHub Deploy Key](https://github.com/simplycubed/builder-env/settings/keys/new) to the GitHub repo used by Argo CD to deploy services in the environment (i.e. env-dev, env-prod).
- Copy the public key content to the *key* field in GitHub.
  - Check Allow write access
- Copy the private key content to the *env_repo_ssh_key* variable in the Terraform Workspace.

## IAP Brand Name

- IAP brand name will ge generated in output of init script.
- The Brand Name ID is only displayed after the OAuth consent screen is configured. 
- The init script references the `OAUTH Tooling` name when searching for the Brand Name ID.

## DNS Configuration

Terraform manages DNS using Google Cloud DNS. After applying the Terraform Plan there is a required step to update the domain registrar with the provisioned nameservers. Any existing record sets associated with this domain should also be added to Terraform Configuration.

## Set Nameservers

Update the nameservers in Gandi.net with the nameservers in Cloud DNS.
 - Nameserver updates can take up to 24 hours.
 - [DNS Checker](https://dnschecker.org/ns-lookup.php)

```text
# replace * with custom value
ns-cloud-*.googledomains.com.
ns-cloud-*.googledomains.com.
ns-cloud-*.googledomains.com.
ns-cloud-*.googledomains.com.
```

## Terraform Setup

- When new providers are added it is important to run `terraform init` otherwise the plan and apply will fail.

## Terraform Cloud - Variables

| Key  | Value |
|---|---|
| project_id | simplycubed-builder-dev |
| region | asia-northeast1 |
| credentials | SENSITIVE |
| gke_cluster_name | default |
| gke_initial_node_count | 1 |
| gke_machine_type | e2-highmem-2 |
| gke_allowed_ip_ranges | 0.0.0.0/0 |
| base_domain | simplycubed.dev |
| grafana_oauth_client_id | SENSITIVE |
| grafana_oauth_client_secret | SENSITIVE |
| argocd_oauth_client_id | SENSITIVE |
| argocd_oauth_client_secret | SENSITIVE |
| env_repo_ssh_url | git@github.com:simplycubed/builder-env.git |
| env_repo_ssh_key | SENSITIVE |
| iap_brand_name | projects/${project_number}/brands/${brand_number} |
| db_machine_type | db-f1-micro |

## Push dependency images to GCR

The build process uses `yq` to parse the env-dev / env-prod projects deploymnet.yaml file to update the deployment image tag.

This requires pulling yq from Docker Hub, taging it with GCR repo, and pushing it to Google Cloud. 

- [pushing-and-pulling images](https://cloud.google.com/container-registry/docs/pushing-and-pulling)

```bash
docker pull mikefarah/yq 
docker tag mikefarah/yq asia.gcr.io/simplycubed-builder-dev/yq
docker push asia.gcr.io/simplycubed-builder-dev/yq
```

## Resources

- [GKE Standard Cluster Architecture](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture)
- [gcloud](https://cloud.google.com/sdk/gcloud#downloading_the_gcloud_command-line_tool)