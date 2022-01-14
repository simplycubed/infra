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
| base_domain | simplycubed.dev |
| builder_domain | devopsui.dev |
| registry_domain | devopsregistry.dev |
| iap_brand_name | projects/${project_number}/brands/${brand_number} |

## Resources

- [gcloud](https://cloud.google.com/sdk/gcloud#downloading_the_gcloud_command-line_tool)