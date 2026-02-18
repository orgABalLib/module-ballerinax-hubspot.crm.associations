// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new (9090);

http:Service mockService = service object {

    # Deletes all associations between two records
    #
    # + return - returns can be any of following types 
    # http:NoContent (Returns `http:Response` with status **204 No Content** on success, indicating successful deletion.)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function delete objects/[string objectType]/[string objectId]/associations/[string toObjectType]/[string toObjectId]() returns error? {
        return objectType == FROM_OBJECT_TYPE && objectId == FROM_OBJECT_ID && toObjectType == TO_OBJECT_TYPE && toObjectId == TO_OBJECT_ID 
            ? () : error("Unable to infer object type from: " + objectType);
    }

    # List Associations of an Object by Type
    #
    # + after - The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results.
    # + 'limit - The maximum number of results to display per page.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get objects/[string objectType]/[string objectId]/associations/[string toObjectType](string? after, int:Signed32 'limit = 500) returns CollectionResponseMultiAssociatedObjectWithLabelForwardPaging|error {
        if objectType == FROM_OBJECT_TYPE && objectId == FROM_OBJECT_ID && toObjectType == TO_OBJECT_TYPE {
            AssociationSpecWithLabel associationType1 = {
                category: "HUBSPOT_DEFINED",
                typeId: 5,
                label: "Primary"
            };
            AssociationSpecWithLabel associationType2 = {
                category: "HUBSPOT_DEFINED",
                typeId: 341,
                label: ()
            };
            AssociationSpecWithLabel associationType3 = {
                category: "USER_DEFINED",
                typeId: 9,
                label: "d->c"
            };
            AssociationSpecWithLabel associationType4 = {
                category: "HUBSPOT_DEFINED",
                typeId: 341,
                label: ()
            };
            MultiAssociatedObjectWithLabel multiObj1 = {
                toObjectId: "38056537805",
                associationTypes: [associationType1, associationType2]
            };
            MultiAssociatedObjectWithLabel multiObj2 = {
                toObjectId: "38056537829",
                associationTypes: [associationType3, associationType4]
            };
            CollectionResponseMultiAssociatedObjectWithLabelForwardPaging responsePayload = {
                results: [multiObj1, multiObj2]
            };
            return responsePayload;
        } else {
            return error("Unable to infer object type from: " + objectType);
        }
    }

    # Removes Links Between Objects
    #
    # + return - returns can be any of following types 
    # http:NoContent (Returns `http:Response` with status **204 No Content** on success, indicating successful deletion.)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post associations/[string fromObjectType]/[string toObjectType]/batch/archive(@http:Payload BatchInputPublicAssociationMultiArchive payload) returns error? {
        if fromObjectType == FROM_OBJECT_TYPE && toObjectType == TO_OBJECT_TYPE {
            return ();
        } else {
            return error("Unable to infer object type from: " + fromObjectType);
        }
    }

    # Creates a Default HubSpot-Defined Association
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post associations/[string fromObjectType]/[string toObjectType]/batch/associate/default(@http:Payload BatchInputPublicDefaultAssociationMultiPost payload) returns BatchResponsePublicDefaultAssociation|error {
        if fromObjectType == FROM_OBJECT_TYPE && toObjectType == TO_OBJECT_TYPE {
            PublicObjectId fromObj = {
                id: FROM_OBJECT_ID
            };
            PublicObjectId toObj = {
                id: TO_OBJECT_ID
            };
            AssociationSpec assocSpec = {
                associationCategory: "HUBSPOT_DEFINED",
                associationTypeId: 341
            };
            PublicDefaultAssociation defaultAssoc = {
                'from: fromObj,
                to: toObj,
                associationSpec: assocSpec
            };
            BatchResponsePublicDefaultAssociation responsePayload = {
                status: "COMPLETE",
                results: [defaultAssoc],
                startedAt: "2025-02-16T06:38:42.797Z",
                completedAt: "2025-02-16T06:38:42.890Z"
            };
            return responsePayload;
        } else {
            return error("Unable to infer object type from: " + fromObjectType);
        }
    }

    # Creates Custom Associations
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post associations/[string fromObjectType]/[string toObjectType]/batch/create(@http:Payload BatchInputPublicAssociationMultiPost payload) returns BatchResponseLabelsBetweenObjectPair|error {
        if fromObjectType == FROM_OBJECT_TYPE && toObjectType == TO_OBJECT_TYPE {
            LabelsBetweenObjectPair labelPair = {
                fromObjectTypeId: "0-3",
                fromObjectId: "46989749974",
                toObjectTypeId: "0-2",
                toObjectId: "43500581578",
                labels: ["test-deal->company-1"]
            };
            BatchResponseLabelsBetweenObjectPair responsePayload = {
                status: "COMPLETE",
                results: [labelPair],
                startedAt: "2025-02-18T08:53:51.080Z",
                completedAt: "2025-02-18T08:53:51.205Z"
            };
            return responsePayload;
        } else {
            return error("Unable to infer object type from: " + fromObjectType);
        }
    }

    # Delete Specific Labels
    #
    # + return - returns can be any of following types 
    # http:NoContent (Returns `http:Response` with status **204 No Content** on success, indicating successful deletion.)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post associations/[string fromObjectType]/[string toObjectType]/batch/labels/archive(@http:Payload BatchInputPublicAssociationMultiPost payload) returns error? {
        return fromObjectType == FROM_OBJECT_TYPE && toObjectType == TO_OBJECT_TYPE ? () : error("Unable to infer object type from: " + fromObjectType);
    }

    # Read Associations
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post associations/[string fromObjectType]/[string toObjectType]/batch/read(@http:Payload BatchInputPublicFetchAssociationsBatchRequest payload) returns BatchResponsePublicAssociationMultiWithLabel|error {
        AssociationSpecWithLabel assocType1 = {
            category: "HUBSPOT_DEFINED",
            typeId: 341,
            label: ()
        };
        AssociationSpecWithLabel assocType2 = {
            category: "HUBSPOT_DEFINED",
            typeId: 5,
            label: "Primary"
        };
        AssociationSpecWithLabel assocType3 = {
            category: "HUBSPOT_DEFINED",
            typeId: 341,
            label: ()
        };
        AssociationSpecWithLabel assocType4 = {
            category: "USER_DEFINED",
            typeId: 9,
            label: "d->c"
        };
        MultiAssociatedObjectWithLabel toObj1 = {
            toObjectId: "43500581578",
            associationTypes: [assocType1, assocType2]
        };
        MultiAssociatedObjectWithLabel toObj2 = {
            toObjectId: "38056537829",
            associationTypes: [assocType3, assocType4]
        };
        PublicObjectId fromObj = {
            id: "46989749974"
        };
        PublicAssociationMultiWithLabel assocMulti = {
            'from: fromObj,
            to: [toObj1, toObj2]
        };
        BatchResponsePublicAssociationMultiWithLabel responsePayload = {
            status: "COMPLETE",
            results: [assocMulti],
            startedAt: "2025-02-17T11:08:16.755Z",
            completedAt: "2025-02-17T11:08:16.767Z"
        };
        return responsePayload;
    }

    # Report
    #
    # + userId -
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post associations/usage/high\-usage\-report/[int:Signed32 userId]() returns record {|string enqueueTime; int:Signed32 userId; string userEmail;|}|error {
        record {|string enqueueTime; int:Signed32 userId; string userEmail;|} responsePayload = {
            enqueueTime: "2025-02-16T12:38:52.759Z",
            userId: userId,
            userEmail: "email@gmail.com"
        };
        return responsePayload;
    }

    # Create Default Association Between Two Object Types
    #
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function put objects/[string fromObjectType]/[string fromObjectId]/associations/default/[string toObjectType]/[string toObjectId]() returns BatchResponsePublicDefaultAssociation|error {
        PublicObjectId fromObj1 = {
            id: "46989749974"
        };
        PublicObjectId toObj1 = {
            id: "43500581578"
        };
        AssociationSpec assocSpec1 = {
            associationCategory: "HUBSPOT_DEFINED",
            associationTypeId: 341
        };
        PublicDefaultAssociation defaultAssoc1 = {
            'from: fromObj1,
            to: toObj1,
            associationSpec: assocSpec1
        };
        PublicObjectId fromObj2 = {
            id: "38056537829"
        };
        PublicObjectId toObj2 = {
            id: "41479955131"
        };
        AssociationSpec assocSpec2 = {
            associationCategory: "HUBSPOT_DEFINED",
            associationTypeId: 342
        };
        PublicDefaultAssociation defaultAssoc2 = {
            'from: fromObj2,
            to: toObj2,
            associationSpec: assocSpec2
        };
        BatchResponsePublicDefaultAssociation responsePayload = {
            status: "COMPLETE",
            results: [defaultAssoc1, defaultAssoc2],
            startedAt: "2025-02-17T12:01:32.039Z",
            completedAt: "2025-02-17T12:01:32.070Z"
        };
        return responsePayload;
    }

    # Create Association Labels Between Two Records
    #
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function put objects/[string objectType]/[string objectId]/associations/[string toObjectType]/[string toObjectId](@http:Payload AssociationSpec[] payload) returns LabelsBetweenObjectPair|error {
        LabelsBetweenObjectPair responsePayload = {
            fromObjectTypeId: "0-3",
            fromObjectId: "46989749974",
            toObjectTypeId: "0-2",
            toObjectId: "43500581578",
            labels: ["test-deal->company-1"]
        };
        return responsePayload;
    }
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skipping mock service initialization. Tests are configured to run against live server.");
        return;
    }
    log:printInfo("Tests are configured to run against mock server. Initializing mock service...");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}