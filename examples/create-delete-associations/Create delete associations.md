# Create Delete Associations

This example demonstrates how to manage associations between HubSpot CRM objects (deals and companies) using the HubSpot CRM Associations connector. The script creates default and labeled associations, reads existing associations, and then deletes both specific and all associations between the objects.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain OAuth2 credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your HubSpot OAuth2 credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   ```

3. **Object IDs**
   
   Before running this example, ensure you have valid HubSpot object IDs for the deal and company you want to associate. Update the following constants in `main.bal` with your actual object IDs:
   
   ```ballerina
   const string FROM_OBJECT_ID = "46989749974";  // Your Deal ID
   const string TO_OBJECT_ID = "43500581578";    // Your Company ID
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The script will perform the following operations in sequence:

1. Create a default association between a deal and a company
2. Create a labeled association (USER_DEFINED) between the same objects
3. Read all associations between the deal and company
4. Delete the specific labeled association
5. Read associations after the specific deletion
6. Delete all remaining associations between the objects
7. Read associations after deleting all associations