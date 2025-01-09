# Google Cloud Infrastructure Automation with Terraform

## General info 
The infrastructure is designed to support a simple web application with a focus on scalability, high availability, and security. It includes the following components:

* Web Server: Apache
* Database: PostgreSQL
* Web-Based Storage: Cloud Storage buckets Google Buckets

The entire infrastructure is defined and deployed using Terraform to enable consistent, repeatable, and automated provisioning.

### Version
terraform 1.7.3

### Terraform apply
*  Before proceeding, ensure that ~/.gcp/service-account-key.json is properly configured with the appropriate permissions to allow the user to deploy on GCP cloud.
* You need to provide two secret variables, either by setting them as environment variables or by passing them directly in the console:
 ``` -var="root_password=***" ``` 
 ``` -var="db_user_password=***" ```

### Helpful info:
* https://gcloud-compute.com/instances.html
* https://gcloud-compute.com/images.html
* https://cloud.google.com/sql/pricing