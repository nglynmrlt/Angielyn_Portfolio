-- Intermediate Queries (JOINs, GROUP BY, Aggregates)

-- List each patient along with the doctor they visited (include visit date)
SELECT 
p.name, 
v.visit_date, 
d.name, 
d.specialization, 
v.reason
FROM hospital_db.patients AS p
LEFT JOIN hospital_db.visits AS v ON v.patient_id = p.patient_id
LEFT JOIN hospital_db.doctors AS d ON d.doctor_id = v.doctor_id;

-- Count the number of visits per doctor and sort by the highest
SELECT
d.name,
d.specialization,
COUNT(v.visit_id) AS visits
FROM hospital_db.doctors AS d
LEFT JOIN hospital_db.visits AS v ON d.doctor_id = v.doctor_id
GROUP BY 1,2
ORDER BY 3 DESC;

-- Find the total charges billed for each patient
SELECT 
p.name,
SUM(b.charges) AS Total_Bill
FROM hospital_db.patients AS p
LEFT JOIN hospital_db.visits AS v ON p.patient_id = v.patient_id
LEFT JOIN hospital_db.billing AS b on v.visit_id = b.visit_id
GROUP BY 1
ORDER BY 2 DESC;
-- LIMIT 5

-- Get the average billing amount per doctor.
SELECT 
d.name,
ROUND(AVG(b.charges),2) AS Avg_Bill
FROM hospital_db.doctors AS d
LEFT JOIN hospital_db.visits AS v ON v.doctor_id = d.doctor_id
LEFT JOIN hospital_db.billing AS b on v.visit_id = b.visit_id
GROUP BY 1
ORDER BY 2 DESC;

-- Find the number of patients per country who have chronic conditions.
SELECT 
country,
COUNT(name) AS NumberOfPatients
FROM hospital_db.patients
WHERE NOT chronic_condition IS NULL
GROUP BY 1
ORDER BY 2 DESC;
