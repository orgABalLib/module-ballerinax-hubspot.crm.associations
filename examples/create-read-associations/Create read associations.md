# Create Read Associations

This example demonstrates how to create and read associations between HubSpot CRM objects using the HubSpot CRM Associations connector. The script creates both default and custom-labeled associations between deals and companies, then reads back the created associations.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain OAuth2 credentials.

2. **Create HubSpot Objects**
   > Before running this example, ensure you have existing deals and companies in your HubSpot account. Update the object IDs in the code (`FROM_OBJECT_ID_1`, `TO_OBJECT_ID_1`, `FROM_OBJECT_ID_2`, `TO_OBJECT_ID_2`) with valid IDs from your HubSpot account.

3. **Configuration**
   Create a `Config.toml` file in the project root directory with your OAuth2 credentials:

```toml
clientId = "<Your Client ID>"
clientSecret = "<Your Client Secret>"
refreshToken = "<Your Refresh Token>"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

Upon successful execution, you will see output showing:
- The response from creating default associations between deals and companies
- The response from creating custom-labeled associations
- The associations retrieved for each deal with companies