connect to SE3DB3;

------------------------------------------------
--  DDL Statement for table Person
------------------------------------------------
CREATE TABLE  PERSON (
    personID        INT NOT NULL,
    age             INT,
    gender          VARCHAR(20),
    ethnicity       VARCHAR(20),
    phoneNO         VARCHAR(20),
    PRIMARY KEY (personID)
);

------------------------------------------------
--  DDL Statement for table Hospital
------------------------------------------------
CREATE TABLE  HOSPITAL (
    hName       VARCHAR(20) NOT NULL,
    hAddress    VARCHAR(20),
    PRIMARY KEY (hName)

);

------------------------------------------------
--  DDL Statement for table Department
------------------------------------------------
CREATE TABLE  DEPARTMENT (
    deptID      INT NOT NULL,
    deptName    VARCHAR(20),
    PRIMARY KEY (deptID)

);

------------------------------------------------
--  DDL Statement for table between HOSPITAL
--  and DEPARTMENT: HOSPITALDEPARTMENT
------------------------------------------------
CREATE TABLE  HOSPDEPT (
    hName       VARCHAR(20) NOT NULL,
    deptID      INT NOT NULL,
    capacity    INT,
    FOREIGN KEY (hName) REFERENCES HOSPITAL (hName),
    FOREIGN KEY (deptID) REFERENCES DEPARTMENT (deptID),
    PRIMARY KEY (hName, deptID)

);

------------------------------------------------
--  DDL Statement for table Employee
------------------------------------------------
CREATE TABLE  EMPLOYEE (
    personID        INT NOT NULL,
    role            VARCHAR(20),
    hName           VARCHAR(20),
    deptID          INT,
    FOREIGN KEY (hName) REFERENCES HOSPITAL (hName),
    FOREIGN KEY (deptID) REFERENCES DEPARTMENT (deptID),
    FOREIGN KEY (personID) REFERENCES PERSON (personID),
    PRIMARY KEY (personID)
);

------------------------------------------------
--  DDL Statement for table Patient
------------------------------------------------
CREATE TABLE  PATIENT (
    personID        INT NOT NULL,
    dateOfDeath     DATE,
    FOREIGN KEY (personID) REFERENCES PERSON (personID),
    PRIMARY KEY (personID)

);

------------------------------------------------
--  DDL Statement for table Disease
------------------------------------------------
CREATE TABLE  DISEASE (
    diseaseID       INT NOT NULL,
    category        VARCHAR(20),
    name            VARCHAR(20),
    PRIMARY KEY (diseaseID)

);

------------------------------------------------
--  DDL Statement for table between PATIENT
--  and DISEASE: PATIENTDIAGNOSIS
------------------------------------------------
CREATE TABLE  DIAGNOSIS (
    personID        INT NOT NULL,
    diseaseID       INT NOT NULL,
    diagData        CHAR(100),
    FOREIGN KEY (personID) REFERENCES PATIENT (personID),
    FOREIGN KEY (diseaseID) REFERENCES DISEASE (diseaseID),
    PRIMARY KEY (personID, diseaseID)

);

------------------------------------------------
--  DDL Statement for table Lab Record
------------------------------------------------
CREATE TABLE  LABRECORD (
    labID           INT NOT NULL,
    personID        INT,
    FOREIGN KEY (personID) REFERENCES PATIENT (personID),
    PRIMARY KEY (labID)

);

------------------------------------------------
--  DDL Statement for table Medical Test
------------------------------------------------
CREATE TABLE  MEDICALTEST (
    mtID        INT NOT NULL,
    mtName      VARCHAR(20),
    mtType      VARCHAR(20),
    PRIMARY KEY (mtID)

);

------------------------------------------------
--  DDL Statement for table between LabRecord 
--  and MedicalTest: PatientTest
------------------------------------------------
CREATE TABLE  PATIENTTEST (
    labID       INT NOT NULL,
    mtID        INT NOT NULL,
    dateOfTest  DATE,
    valOfTest   INT,
    outcome     VARCHAR(20),
    FOREIGN KEY (labID) REFERENCES LABRECORD (labID),
    FOREIGN KEY (mtID) REFERENCES MEDICALTEST (mtID),
    PRIMARY KEY (labID, mtID)

);

------------------------------------------------
--  DDL Statement for table Admission Record
------------------------------------------------
CREATE TABLE  ADMISSIONRECORD (
    aID         INT NOT NULL,
    aDate       DATE,
    dDate       DATE,
    personID    INT,
    hName       VARCHAR(20),
    FOREIGN KEY (personID) REFERENCES PATIENT (personID),
    FOREIGN KEY (hName) REFERENCES HOSPITAL (hName),
    PRIMARY KEY (aID)
);

------------------------------------------------
--  DDL Statement for table ICU
------------------------------------------------
CREATE TABLE  ICU (
    hName       VARCHAR(20) NOT NULL,
    icuName     VARCHAR(20) NOT NULL,
    icuCap      INT,
    FOREIGN KEY (hName) REFERENCES HOSPITAL (hName),
    PRIMARY KEY (hName, icuName)

);

------------------------------------------------
--  DDL Statement for table between 
--  ADMISSIONRECORD and ICU: ICUADMISSION
------------------------------------------------
CREATE TABLE  ICUADMISSION (
    aID         INT NOT NULL,
    hName       VARCHAR(20) NOT NULL,
    icuName     VARCHAR(20) NOT NULL,
    enterDate   DATE,
    leaveDate   DATE,
    FOREIGN KEY (aID) REFERENCES ADMISSIONRECORD (aID),
    FOREIGN KEY (hName, icuName) REFERENCES ICU (hName, icuName),
    PRIMARY KEY (aID, hName, icuName)

);


------------------------------------------------
--  DDL Statement for table Prescription
------------------------------------------------
CREATE TABLE  PRESCRIPTION (
    rxNO        INT NOT NULL,
    startDate   DATE,
    endDate     DATE,
    aID         INT,
    FOREIGN KEY (aID) REFERENCES ADMISSIONRECORD (aID),
    PRIMARY KEY (rxNO)

);

------------------------------------------------
--  DDL Statement for table Drug
------------------------------------------------
CREATE TABLE  DRUG (
    dID         INT NOT NULL,
    dName       VARCHAR(20),
    dType       VARCHAR(20),
    dManf       VARCHAR(20),
    PRIMARY KEY (dID)

);

------------------------------------------------
--  DDL Statement for table between PRESCRIPTION
--  and DRUG: PRESCRIBED
------------------------------------------------
CREATE TABLE  PRESCRIBED (
    rxNO        INT NOT NULL,
    dID         INT NOT NULL,
    dosage      INT,
    FOREIGN KEY (rxNO) REFERENCES PRESCRIPTION (rxNO),
    FOREIGN KEY (dID) REFERENCES DRUG (dID),
    PRIMARY KEY (rxNO, dID)      

);


connect reset;


