-- Advanced Queries (CTE, Nested Queries, HAVING, Aggregations)

-- List patients who have visited more than one doctor
SELECT 
p.name,
COUNT(DISTINCT d.name) AS CountOfDoc
FROM hospital_db.patients AS p
LEFT JOIN  hospital_db.visits AS v ON v.patient_id = p.patient_id
LEFT JOIN hospital_db.doctors AS d on d.doctor_id = v.doctor_id
GROUP BY 1
HAVING CountOfDoc > 1;

-- Find doctors whose patients have a total billing over 3000
WITH Patients AS (
					SELECT 
					p.name,
                    p.patient_id,
					SUM(b.charges) AS Total_Bill
					FROM hospital_db.patients AS p
					LEFT JOIN hospital_db.visits AS v ON p.patient_id = v.patient_id
					LEFT JOIN hospital_db.billing AS b on v.visit_id = b.visit_id
					GROUP BY 2
                    HAVING Total_Bill > 3000
				   )
SELECT DISTINCT
d.name
FROM hospital_db.doctors AS d
LEFT JOIN hospital_db.visits AS v ON v.doctor_id = d.doctor_id
LEFT JOIN hospital_db.patients AS p ON v.patient_id = p.patient_ID
WHERE p.name IN (SELECT name FROM Patients);

-- Retrieve patients who have been prescribed more than 1 medicine
SELECT 
p.name,
COUNT(pr.prescription_id) AS Pres_Count
FROM hospital_db.patients AS p
LEFT JOIN hospital_db.visits AS v ON p.patient_id = v.patient_id
LEFT JOIN hospital_db.prescriptions AS pr ON v.visit_id = pr.visit_id
GROUP BY 1
HAVING Pres_Count > 1;

-- Find the top 3 most expensive visits (billing charges) and show patient name, doctor, and visit reason
SELECT
v.visit_id,
b.charges,
p.name AS patient_name,
d.name as doctor_name,
v.reason
FROM hospital_db.visits AS v
LEFT JOIN hospital_db.billing AS b on v.visit_id = b.visit_id
LEFT JOIN hospital_db.patients AS p ON v.patient_id = p.patient_ID
LEFT JOIN hospital_db.doctors AS d on d.doctor_id = v.doctor_id
ORDER BY 2 DESC
LIMIT 3;

-- Get a monthly report: number of visits, total charges, and total insurance coverage
SELECT
MONTHNAME(v.visit_date) AS 'Month',
COUNT(v.visit_ID) AS Number_Visits,
SUM(b.charges) AS Total_Charges,
SUM(b.insurance_coverage) AS Total_Coverages
FROM hospital_db.visits AS v
LEFT JOIN hospital_db.billing AS b on v.visit_id = b.visit_id
GROUP BY 1;