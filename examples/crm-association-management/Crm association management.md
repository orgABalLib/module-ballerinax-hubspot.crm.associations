# CRM Association Management

This example demonstrates how to audit and manage company-to-contact associations in HubSpot CRM. The script retrieves existing associations, creates new labeled associations for stakeholders (Decision Maker, Technical Contact), removes outdated contact associations, and verifies the updated association structure.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.associations/tree/main/ballerina/Package.md) to obtain your access token.

2. **Configuration**
   Create a `Config.toml` file in the project root directory with your credentials and sample data:

   ```toml
   accessToken = "<Your HubSpot Access Token>"
   companyId = "<Your Company ID>"
   newStakeholderContactIds = ["<Contact ID 1>", "<Contact ID 2>"]
   outdatedContactIds = ["<Outdated Contact ID 1>", "<Outdated Contact ID 2>"]
   ```

   Replace the placeholder values with:
   - `accessToken`: Your HubSpot private app access token
   - `companyId`: The HubSpot company ID you want to manage associations for
   - `newStakeholderContactIds`: Array of contact IDs to associate as new stakeholders
   - `outdatedContactIds`: Array of contact IDs whose associations should be removed

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing each step of the association management workflow.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== Customer Relationship Mapping and Cleanup Workflow ===

✓ HubSpot CRM Associations client initialized successfully

--- Step 1: Retrieving existing company-to-contact associations ---
Found 3 existing contact associations for company ID: 12345678
...

--- Step 2: Creating new associations for stakeholders ---
...

--- Step 3: Removing outdated contact associations ---
...

--- Step 4: Verifying updated association structure ---
...

=== Workflow completed successfully ===
Summary:
  - Retrieved and reviewed existing associations
  - Created 2 new stakeholder associations with labels
  - Removed 2 outdated associations
  - CRM data is now accurate and actionable for the sales team
```