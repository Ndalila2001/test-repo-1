import ballerinax/kafka;
import ballerinax/mysql;
import ballerina/io;
import ballerinax/mysql.driver as _;


mysql:Client db = check new("localhost", "root", "password", "logistics_db",3306);

listener kafka:Listener expressConsumer = check new(kafka:DEFAULT_URL, {
    groupId: "express-delivery-group",  
    topics: "express-delivery"
});

kafka:Producer confirmationProducer = check new(kafka:DEFAULT_URL);

type ShipmentDetails record {
    string shipmentType;
    string pickupLocation;
    string deliveryLocation;
    string preferredTimeSlot;
    string firstName;
    string lastName;
    string contactNumber;
    string trackingNumber;
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

service on expressConsumer{
 remote function onConsumerRecord(ShipmentDetails[] req) returns error? {
        foreach ShipmentDetails request in req {
            string estimatedDelivery = calculateDeliveryTime(request.pickupLocation, request.deliveryLocation);
            
            ShipmentConfirmation confirmation = {
                confirmationId: request.trackingNumber,
                shipmentType: request.shipmentType,
                pickupLocation: request.pickupLocation,
                deliveryLocation: request.deliveryLocation,
                estimatedDeliveryTime: estimatedDelivery,
                status: "Confirmed"
            };
            
            check confirmationProducer->send({topic: "confirmationShipment", value: confirmation});
            io:println("shipment confirmation sent for" + request.trackingNumber);


        }
    }
    
    
}

function calculateDeliveryTime(string pickup_location, string delivery_location) returns string {
    string time = "2-3 days";
    return time;
}