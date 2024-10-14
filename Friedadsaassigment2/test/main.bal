import ballerina/http;



type ShipmentDetails record {
    string shipmentType;
    string pickupLocation;
    string deliveryLocation;
    string preferredTimeSlot;
    string firstName;
    string lastName;
    string contactNumber;
    string trackingNumber = "" ;
};

type ShipmentConfirmation record {
    string confirmationId;
    string shipmentType;
    string pickupLocation;
    string deliveryLocation;
    string estimatedDeliveryTime;
    string status;
};

type Customer record {
    int id;
    string firstName;
    string lastName;
    string contactNumber;
};

http:Client z_client = check new("http://localhost:9090/logistic");

public function main() returns error? {
    
    check postSend(z_client);
    
}

function postSend(http:Client httpClient) returns error?{
    ShipmentDetails req = {
        shipmentType: "standard-delivery",
        pickupLocation: "Japan",
        deliveryLocation: "Beijing",
        preferredTimeSlot: "2-3 days",
        firstName: "Rauna",
        lastName: "Dumeni",
        contactNumber: "123456729"
    };
    string _ = check httpClient->/sendPackage.post(req);
}
