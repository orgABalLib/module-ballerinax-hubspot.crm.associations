// Customer Relationship Mapping and Cleanup Workflow Example
// This example demonstrates how to audit and manage company-to-contact associations in HubSpot CRM

import ballerina/io;
import ballerinax/hubspot.crm.associations;

// Configurable variables for HubSpot API authentication
configurable string accessToken = ?;

// Sample company and contact IDs for demonstration
// In a real scenario, these would come from your CRM data
configurable string companyId = "12345678";
configurable string[] newStakeholderContactIds = ["98765432", "87654321"];
configurable string[] outdatedContactIds = ["11111111", "22222222"];

public function main() returns error? {
    // Initialize the HubSpot CRM Associations client
    io:println("=== Customer Relationship Mapping and Cleanup Workflow ===\n");
    
    associations:ConnectionConfig connectionConfig = {
        auth: {
            token: accessToken
        }
    };
    
    associations:Client hubspotClient = check new (connectionConfig);
    io:println("✓ HubSpot CRM Associations client initialized successfully\n");

    // Step 1: Retrieve all existing associations between the company and its contacts
    io:println("--- Step 1: Retrieving existing company-to-contact associations ---");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging existingAssociations = 
        check hubspotClient->/objects/["companies"]/[companyId]/associations/["contacts"];
    
    int existingResultsLength = existingAssociations.results.length();
    io:println(string `Found ${existingResultsLength} existing contact associations for company ID: ${companyId}`);
    
    // Display current association structure
    foreach associations:MultiAssociatedObjectWithLabel association in existingAssociations.results {
        string contactId = association.toObjectId;
        io:println(string `  - Contact ID: ${contactId}`);
        foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
            string? labelValue = assocType?.label;
            string labelInfo = labelValue ?: "No label";
            int typeIdValue = assocType.typeId;
            io:println(string `    Type ID: ${typeIdValue}, Label: ${labelInfo}, Category: ${assocType.category}`);
        }
    }
    io:println();

    // Step 2: Create new associations with proper labels for newly identified stakeholders
    io:println("--- Step 2: Creating new associations for stakeholders ---");
    
    // Prepare batch input for creating associations
    // Using HubSpot's predefined association type IDs for company-to-contact
    // Type ID 279: Primary contact (Decision Maker)
    // Type ID 280: Secondary contact (Technical Contact)
    associations:PublicAssociationMultiPost[] associationInputs = [];
    
    // Create association for Decision Maker
    if newStakeholderContactIds.length() > 0 {
        associations:PublicAssociationMultiPost decisionMakerAssociation = {
            'from: {
                id: companyId
            },
            to: {
                id: newStakeholderContactIds[0]
            },
            types: [
                {
                    associationCategory: "HUBSPOT_DEFINED",
                    associationTypeId: 279
                }
            ]
        };
        associationInputs.push(decisionMakerAssociation);
        string contactIdDM = newStakeholderContactIds[0];
        io:println(string `  Preparing association: Company ${companyId} -> Contact ${contactIdDM} (Decision Maker)`);
    }
    
    // Create association for Technical Contact
    if newStakeholderContactIds.length() > 1 {
        associations:PublicAssociationMultiPost technicalContactAssociation = {
            'from: {
                id: companyId
            },
            to: {
                id: newStakeholderContactIds[1]
            },
            types: [
                {
                    associationCategory: "HUBSPOT_DEFINED",
                    associationTypeId: 280
                }
            ]
        };
        associationInputs.push(technicalContactAssociation);
        string contactIdTC = newStakeholderContactIds[1];
        io:println(string `  Preparing association: Company ${companyId} -> Contact ${contactIdTC} (Technical Contact)`);
    }
    
    // Execute batch creation if there are associations to create
    if associationInputs.length() > 0 {
        associations:BatchInputPublicAssociationMultiPost batchPayload = {
            inputs: associationInputs
        };
        
        associations:BatchResponseLabelsBetweenObjectPair batchResponse = 
            check hubspotClient->/associations/["companies"]/["contacts"]/batch/create.post(payload = batchPayload);
        
        io:println("\n✓ Batch association creation completed");
        string batchStatus = batchResponse.status;
        io:println(string `  Status: ${batchStatus}`);
        int batchResultsLength = batchResponse.results.length();
        io:println(string `  Results created: ${batchResultsLength}`);
        
        // Display created associations
        foreach associations:LabelsBetweenObjectPair result in batchResponse.results {
            string fromId = result.fromObjectId;
            string toId = result.toObjectId;
            io:println(string `  - From Object ID: ${fromId} -> To Object ID: ${toId}`);
            if result.labels.length() > 0 {
                string labelsStr = result.labels.toString();
                io:println(string `    Labels: ${labelsStr}`);
            }
        }
        
        // Check for any errors in the batch operation
        int? numErrorsValue = <int?>batchResponse["numErrors"];
        if numErrorsValue is int && numErrorsValue > 0 {
            io:println(string `  ⚠ Errors encountered: ${numErrorsValue}`);
            associations:StandardError[]? errorsValue = <associations:StandardError[]?>batchResponse["errors"];
            if errorsValue is associations:StandardError[] {
                foreach associations:StandardError errorItem in errorsValue {
                    string errorMsg = errorItem.message;
                    io:println(string `    Error: ${errorMsg}`);
                }
            }
        }
    }
    io:println();

    // Step 3: Remove outdated associations for contacts no longer relevant
    io:println("--- Step 3: Removing outdated contact associations ---");
    
    foreach string outdatedContactId in outdatedContactIds {
        io:println(string `  Removing association: Company ${companyId} -> Contact ${outdatedContactId}`);
        
        // Delete the association between the company and the outdated contact
        check hubspotClient->/objects/["companies"]/[companyId]/associations/["contacts"]/[outdatedContactId].delete();
        
        io:println(string `  ✓ Successfully removed association for contact ID: ${outdatedContactId}`);
    }
    io:println();

    // Step 4: Verify the updated association structure
    io:println("--- Step 4: Verifying updated association structure ---");
    
    associations:CollectionResponseMultiAssociatedObjectWithLabelForwardPaging updatedAssociations = 
        check hubspotClient->/objects/["companies"]/[companyId]/associations/["contacts"];
    
    int updatedResultsLength = updatedAssociations.results.length();
    io:println(string `Updated association count: ${updatedResultsLength}`);
    
    foreach associations:MultiAssociatedObjectWithLabel association in updatedAssociations.results {
        string updatedContactId = association.toObjectId;
        io:println(string `  - Contact ID: ${updatedContactId}`);
        foreach associations:AssociationSpecWithLabel assocType in association.associationTypes {
            string? updatedLabelValue = assocType?.label;
            string labelInfo = updatedLabelValue ?: "No label";
            int typeIdValue = assocType.typeId;
            io:println(string `    Type ID: ${typeIdValue}, Label: ${labelInfo}, Category: ${assocType.category}`);
        }
    }
    
    int associationInputsLength = associationInputs.length();
    int outdatedContactIdsLength = outdatedContactIds.length();
    io:println("\n=== Workflow completed successfully ===");
    io:println("Summary:");
    io:println("  - Retrieved and reviewed existing associations");
    io:println(string `  - Created ${associationInputsLength} new stakeholder associations with labels`);
    io:println(string `  - Removed ${outdatedContactIdsLength} outdated associations`);
    io:println("  - CRM data is now accurate and actionable for the sales team");
}