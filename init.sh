#!/bin/bash

# Provide project,organization,billing account id, service account creation key boolean, support email for IAP, as argument to script in order
# Set $BILLING_ACCOUNT to false or ID, false when billing permissions are not granted
# Set $CREATE_SERVICE_ACCOUNT_KEY to true or false, false if not yet created
# ./init.sh $PROJECT_NAME $ORGANIZATION_ID $BILLING_ACCOUNT $CREATE_SERVICE_ACCOUNT_KEY $SUPPORT_EMAIL

# ./init.sh <project name> <organization id> <billing-account-id> <create-service-account-key> <support email>
#
# DEV: Uses smartpay.re as a base domain and smartpay.co for Google Workspace and email related
# PROD: Uses smartpay.co as a base domain and smartpay.co for Google Workspace and email related
#
# First Run:
# ./init.sh smartpay-dev 133660294007 false true support-internal@smartpay.co
#
# Subsequent Runs (i.e. to enable APIs, etc.):
# ./init.sh smartpay-dev 133660294007 false false support-internal@smartpay.co
#
# Fail fast when a command fails or a variable is undefined
set -eu

if [ $# -eq 0 ]
then
  echo "No arguments supplied"
  exit 1
fi

if [ -z $4 ]
then
   CREATE_SERVICE_ACCOUNT_KEY=false
else
  CREATE_SERVICE_ACCOUNT_KEY=$4
fi

PROJECT=$1
ORGANIZATION=$2
BILLING_ACCOUNT=$3
SUPPORT_EMAIL=$5
echo ""
echo "Preparing Terraform resources and service account with the following values:"
echo "==================================================="
echo "Project: $PROJECT"
echo "Organization: $ORGANIZATION"
echo "Billing Account: $BILLING_ACCOUNT"
echo "==================================================="
echo ""
echo "Continuing in 5 seconds. Ctrl+C to cancel"
sleep 5

echo "=> Creating project inside the organization ${ORGANIZATION}"
project_exists=`gcloud projects list --filter "$PROJECT" | grep "$PROJECT" | wc -l | tr -d ' '`
if [ "$project_exists" = "0" ];then 
  gcloud projects create "${PROJECT}" --organization $2
else
  echo "Project already exists. Skipping"
fi

project_id=`gcloud projects list --filter ${PROJECT} | grep ${PROJECT} | awk '{print $1}'`

if [ "$BILLING_ACCOUNT" != "false" ]
then
echo "=> Linking $BILLING_ACCOUNT Billing Account to your project"
gcloud beta billing projects link $project_id \
  --billing-account=$BILLING_ACCOUNT
fi

# Full list of services
# gcloud services list --available
echo "=> Enabling required APIs"
gcloud --project $project_id services enable bigquery.googleapis.com
gcloud --project $project_id services enable bigquerystorage.googleapis.com
gcloud --project $project_id services enable cloudbilling.googleapis.com
gcloud --project $project_id services enable cloudbuild.googleapis.com
gcloud --project $project_id services enable cloudresourcemanager.googleapis.com
gcloud --project $project_id services enable container.googleapis.com
gcloud --project $project_id services enable dns.googleapis.com
gcloud --project $project_id services enable iam.googleapis.com
gcloud --project $project_id services enable iap.googleapis.com
gcloud --project $project_id services enable oslogin.googleapis.com
gcloud --project $project_id services enable redis.googleapis.com
gcloud --project $project_id services enable secretmanager.googleapis.com
gcloud --project $project_id services enable servicenetworking.googleapis.com 
gcloud --project $project_id services enable sql-component.googleapis.com
gcloud --project $project_id services enable sqladmin.googleapis.com

echo ""
echo "Project resources created successfully"
echo ""

echo "=> Creating terraform service account"
service_account_exists=`gcloud iam service-accounts list --project $project_id --filter terraform | grep terraform | wc -l | tr -d ' '`
if [ "$service_account_exists" = "0" ];then 
  gcloud iam service-accounts create terraform \
  --display-name "Terraform admin account" \
  --project $project_id
else
   echo "Service Account already exist"
fi
gcloud projects add-iam-policy-binding $project_id \
  --member "serviceAccount:terraform@${project_id}.iam.gserviceaccount.com" \
  --role="roles/editor"
gcloud projects add-iam-policy-binding $project_id \
  --member "serviceAccount:terraform@${project_id}.iam.gserviceaccount.com" \
  --role="roles/iam.securityAdmin"
gcloud projects add-iam-policy-binding $project_id \
  --member "serviceAccount:terraform@${project_id}.iam.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"
gcloud projects add-iam-policy-binding $project_id \
  --member "serviceAccount:terraform@${project_id}.iam.gserviceaccount.com" \
  --role="roles/servicenetworking.networksAdmin"
gcloud projects add-iam-policy-binding $project_id \
  --member "serviceAccount:terraform@${project_id}.iam.gserviceaccount.com" \
  --role="roles/container.admin"
gcloud projects add-iam-policy-binding $project_id \
  --member "serviceAccount:terraform@${project_id}.iam.gserviceaccount.com" \
  --role="roles/iap.settingsAdmin"
gcloud projects add-iam-policy-binding $project_id \
  --member "serviceAccount:terraform@${project_id}.iam.gserviceaccount.com" \
  --role="roles/iam.roleAdmin"

if [ "$CREATE_SERVICE_ACCOUNT_KEY" = true ]
then
echo "=> Creating key for service account"
gcloud iam service-accounts keys create key.json \
  --iam-account "terraform@${project_id}.iam.gserviceaccount.com"
fi

gcloud alpha iap oauth-brands create --application_title="OAUTH Tooling" --support_email=$SUPPORT_EMAIL --project $project_id  2>/dev/null || true

IAP_BRAND_NAME=$(gcloud alpha iap oauth-brands list  --project $project_id | grep name | cut -f 2 -d ' ')

echo "OUTPUT"
echo "================================="
echo "IAP BRAND NAME: $IAP_BRAND_NAME"
echo "================================="

