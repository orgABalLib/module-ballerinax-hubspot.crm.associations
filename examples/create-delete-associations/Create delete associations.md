# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default associations, creates associations with labels, reads associations, and deletes specific or all associations between objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/blob/main/ballerina/Package.md#setup-guide) to obtain OAuth2 credentials.

2. **Configuration**
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **HubSpot CRM Data**
   Ensure you have existing deals and companies in your HubSpot CRM account. Update the following constants in the code with valid object IDs from your HubSpot account:
   - `FROM_OBJECT_ID` - A valid deal ID
   - `TO_OBJECT_ID` - A valid company ID

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the results of creating, reading, and deleting associations.

```shell
bal run
```