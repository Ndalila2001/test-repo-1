import ballerina/http;
import ballerina/io;
import ballerina/time;

type Programme record {
    readonly int programme_code;
    string programme_name;
    int nqf_level;
    string faculty_name;
    string department_name;
    time:Date registration_date;
    time:Date review_date;
};

type Course record {
    readonly string course_code;
    string course_name;
    int nqf_level;
};

table<Programme> key(programme_code) programmeTable = table [];
table<Course> key(course_code) courseTable = table [];

service / on new http:Listener(5000) {

    resource function post addProgramme(Programme newProgramme) returns string|error {
        error? addProgrammeError = programmeTable.add(newProgramme);
        if addProgrammeError is error {
            return error("Failed to add programme!");
        }
        return newProgramme.programme_name + " added successfully!";
    }

    resource function put updateProgramme(http:Caller caller, http:Request req, int programme_code) returns error? {
        Programme? existingProgramme = programmeTable[programme_code];

        if existingProgramme is () {
            check caller->respond({message: "Programme not found"});
            return;
        }

        json requestBody = check req.getJsonPayload();
        Programme updatedProgramme = check requestBody.cloneWithType(Programme);

        if updatedProgramme.programme_code != programme_code {
            check caller->respond({message: "Programme code mismatch"});
            return;
        }

        programmeTable.add(updatedProgramme);
        check caller->respond({message: "Programme updated successfully"});
    }

    resource function delete deleteProgramme(int programme_code) returns string|error {
        Programme|error deletedProgramme = programmeTable.remove(programme_code);
        if deletedProgramme is error {
            return error("Failed to delete programme record!");
        }
        return deletedProgramme.programme_name + " deleted successfully!";
    }

    resource function get getAllProgrammes(http:Caller caller, http:Request req) returns error? {
        Programme[] programmeList = programmeTable.toArray();
        check caller->respond(programmeList);
    }

    resource function get getProgrammeByCode(http:Caller caller, http:Request req, int programme_code) returns error? {
        Programme? programme = programmeTable[programme_code];
        if programme is () {
            check caller->respond({message: "Programme not found"});
            return;
        }
        check caller->respond(programme);
    }

    resource function get getProgrammeByFaculty(http:Caller caller, http:Request req, string faculty_name) returns error? {
        Programme[] facultyProgrammes = from Programme programme in programmeTable.toArray()
            where programme.faculty_name.toLowerAscii() == faculty_name.toLowerAscii()
            select programme;
        if facultyProgrammes.length() == 0 {
            check caller->respond({message: "No programmes found in the specified faculty"});
            return;
        }
        check caller->respond(facultyProgrammes);
    }

    resource function get getProgrammesDueForReview(http:Caller caller, http:Request req) returns error? {
        time:Date currentDate = time:currentDate();

        Programme[] dueProgrammes = from Programme programme in programmeTable.toArray()
            where programme.review_date <= currentDate
            select programme;

        if dueProgrammes.length() == 0 {
            check caller->respond({message: "No programmes due for review"});
            return;
        }

        check caller->respond(dueProgrammes);
    }
}

