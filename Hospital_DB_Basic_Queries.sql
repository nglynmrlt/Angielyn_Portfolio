-- Basic Queries (SELECT, WHERE, ORDER BY)

-- Find all female patients who have a chronic condition.
SELECT * 
FROM hospital_db.patients
WHERE gender = 'F'
AND NOT chronic_condition IS NULL;

-- List all doctors who specialize in “Cardiology” or “Neurology”.
SELECT * 
FROM hospital_db.doctors
WHERE specialization IN ('Cardiology','Neurology');

-- Retrieve all visits that happened in February 2025.
SELECT * 
FROM hospital_db.visits
WHERE visit_date BETWEEN '2025-02-01' AND '2025-02-28'
ORDER BY visit_date;

-- Get all prescriptions for “Insulin”.
SELECT * 
FROM hospital_db.prescriptions
WHERE medicine = 'Insulin';