# infra

This project contains the Terraform configuration for GCP including an init script to enable GCP project APIs and create a Terraform service account.

## Usage

- Login to Terraform Cloud and link this Github repository
- Create a Terraform Cloud Workspace to manage the GCP project
- Install gcloud CLI and login to the GCP Project
- Login with gcloud `gcloud auth login`
- Project - `gcloud config set project $PROJECT_NAME`
- Execute the following init script

```bash
# ./init.sh $PROJECT_NAME $ORGANIZATION_ID $BILLING_ACCOUNT_ID $CREATE_SERVICE_ACCOUNT_KEY $SUPPORT_EMAIL
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
  - `simplycubed.com`
- Developer Contact information: `support@simplycubed.com`

## Support Email Group for IAP

- Create an email group in [Google Workspace](https://groups.google.com)
- Set the Terraform service account created by the init script as the owner of the group
  - `terraform@${project_id}.iam.gserviceaccount.com`

## IAP Brand Name

- IAP brand name will ge generated in output of init script.
- The Brand Name ID is only displayed after the OAuth consent screen is configured.
- The init script references the `OAUTH Tooling` name when searching for the Brand Name ID.

## DNS

- Cloud Run Domain Mapping requires adding the Terraform user to Google Domains to verify the domain and generate TLS certificates.

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

| Key         | Value           |
| ----------- | --------------- |
| project_id  | name-${ENV}     |
| region      | us-central1     |
| credentials | SENSITIVE       |
| base_domain | simplycubed.com |

## Resources

- [gcloud](https://cloud.google.com/sdk/gcloud#downloading_the_gcloud_command-line_tool)
