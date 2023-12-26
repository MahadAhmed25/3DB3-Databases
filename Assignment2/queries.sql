connect to se3db3;

--==============================================================================================
--  QUESTION: 1
--  List the ID and role of all employees in the Cardiology department of ‘Bellevue
--  General Hospital’ or ‘Grand Oak Hospital’
--==============================================================================================
SELECT e.Employee_ID, e.Role
FROM Employee e
WHERE e.Department_ID IN (SELECT d.Department_ID
                         FROM Department d
                         WHERE d.Department_Name = 'Cardiology') AND
      (e.Hospital = 'Bellevue General Hospital' OR
       e.Hospital = 'Grand Oak Hospital');


--==============================================================================================
--  QUESTION: 2
--  What is the average ‘Blood Glucose Test’ value among all patients?
--==============================================================================================
SELECT AVG(c.Value) AS "Blood Glucose Average"
FROM Contain c
WHERE c.Test_ID = (SELECT t.Test_ID
                   FROM Test t
                   WHERE t.Test_Name = 'Blood Glucose Test');


--==============================================================================================
--  QUESTION: 3
--  For each patient that was admitted at least three times since January 1, 2020, return
--  their patient ID, and the number of times they were admitted (rename this output value as
--  ‘AdmissionCount’).
--==============================================================================================
SELECT a.PatientID, COUNT(*) AS "AdmissionCount"
FROM AdmissionRecord a
WHERE a.AdmitDate >= '2020-01-01'
GROUP BY a.PatientID
HAVING COUNT(*) >= 3;


--==============================================================================================
--  QUESTION: 4
--  For the year 2020, how many ‘abnormal’ test results occurred in each test category?
--==============================================================================================
SELECT t.Type, COUNT(c.Result) AS "AbnormalTest Count"
FROM Contain c
JOIN Test t ON c.Test_ID = t.Test_ID
WHERE c.DATE BETWEEN '2020-01-01' and '2020-12-31' AND
      c.Result = 'Abnormal'
GROUP BY t.Type;


--==============================================================================================
--  QUESTION: 5
--  Find all patients with the longest ICU stay. Return the patient’s ID, age, and gender.
--==============================================================================================
SELECT a.PatientID, p.Age, p.Gender
FROM Person p, ICUStay i, AdmissionRecord a
WHERE p.PersonID = a.PatientID AND
      a.Adm_ID = i.Adm_ID AND
      i.DateOut - i.DateIn = (
            SELECT MAX(i2.DateOut - i2.DateIn)
            FROM ICUStay i2
      );



--==============================================================================================
--  QUESTION: 6
--  Find the average age of diagnosed patients for each disease category. Return the
--  disease category, and the corresponding average age as ‘avgAge’.
--==============================================================================================
SELECT dis.Category, AVG(p.age) AS avgAge
FROM Disease dis
JOIN Diagnosed AS dia ON dis.Disease_ID = dia.Disease_ID
JOIN Person AS p ON p.PersonID = dia.PatientID
GROUP BY dis.Category;



--==============================================================================================
--  QUESTION: 7
--  Find all employees who work in a department (i.e., where department ID is not
--  NULL), and are not diagnosed with a ‘Food Allergy’ or ’Flu’ or ’Conjunctivitis’. Return these
--  employees’ IDs.
--==============================================================================================
SELECT DISTINCT e.Employee_ID
FROM Employee e
JOIN Diagnosed d ON e.Employee_ID = d.PatientID
JOIN Disease di ON d.Disease_ID = di.Disease_ID
WHERE e.Department_ID IS NOT NULL AND
      di.Disease_Name NOT IN ('Food Allergy','Flu','Conjunctivitis');


--==============================================================================================
--  QUESTION: 8
--  Identify all patients who received an ‘Abnormal’ test result, and were also diagnosed
--  with a disease in the ‘Blood and Lymph’ category on the same date. For all these patients,
--  return the patient ID, and the date (of both the abnormal result and diagnosis).
--==============================================================================================
SELECT d.PatientID, c.Date AS DATE
FROM Diagnosed d
JOIN LabRecord lr ON d.PatientID = lr.PatientID
JOIN Contain c ON lr.Lab_ID = c.Lab_ID
WHERE c.Result = 'Abnormal' AND 
      c.Date = d.Date_of_Diagnosis AND
      d.Disease_ID IN (SELECT Disease_ID
                       FROM Disease
                       WHERE Category = 'Blood and Lymph');


--==============================================================================================
--  QUESTION: 9
--  Compute the number of prescriptions containing drugs not made by any of the fol-
--  lowing manufacturers: ‘Pfizer’, ‘Johnson & Johnson’, and ‘Bayer’. Return this count as Non-
--  BigThreeCount.
--==============================================================================================
SELECT  COUNT (DISTINCT p.RX_Num) AS NonBigThreeCount
FROM Prescription p
JOIN HasDrug hd ON p.RX_Num = hd.RX_Num
WHERE hd.Drug_ID IN (SELECT Drug_ID
                        FROM Drug
                        WHERE Manufacturer NOT IN 
                        ('Pfizer', 'Johnson & Johnson','Bayer'));

--==============================================================================================
--  QUESTION: 10
--  Determine which hospitals have all departments. Return the hospital name, depart-
--  ment name, and the patient capacity for each unique hospital-department pair
--==============================================================================================
SELECT h.Name, d.Department_Name, hd.PatientCapacity
FROM Hospital h
JOIN HasDept hd ON h.Name = hd.Hospital
JOIN Department d ON d.Department_ID = hd.Department_ID
WHERE NOT EXISTS (
      (SELECT Department_ID
      FROM Department)
      EXCEPT
      (SELECT HD.Department_ID
      FROM HasDept HD
      WHERE H.Name = HD.Hospital)
);

















