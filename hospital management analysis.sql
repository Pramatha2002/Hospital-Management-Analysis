-- ============================================================
-- PROJECT: Hospital Management Data Analysis
-- PURPOSE: Analyze patients, doctors, appointments,
--          treatments, and billing data to identify
--          healthcare operational and business insights.
-- DATASET: Hospital Management Dataset
-- TABLES: Patients, Doctors, Appointments, Treatments, Billing
-- ============================================================

-- ============================================================
-- STEP 0: DATABASE AND TABLES
-- ============================================================

CREATE DATABASE HOSPITAL_MANAGEMENT;

USE HOSPITAL_MANAGEMENT;

-- View Patients table
SELECT * FROM patients;

-- View Doctors table
SELECT * FROM doctors;

-- View Appointments table
SELECT * FROM appointments;

-- View Treatments table
SELECT * FROM treatments;

-- View Billing table
SELECT * FROM billing;


-- =========================================
-- STEP 1: DATA QUALITY CHECKS
-- =========================================

-- 1. Are there any NULL values in the patients table?
SELECT 
SUM(patient_id IS NULL) AS Patient_id_nulls,
SUM(first_name IS NULL) AS first_name_nulls,
SUM(last_name IS NULL) AS last_name_nulls,
SUM(gender IS NULL) AS gender_nulls,
SUM(date_of_birth IS NULL) AS date_of_birth_nulls,
SUM(contact_number IS NULL) AS contact_number_nulls,
SUM(address IS NULL) AS address_nulls,
SUM(registration_date IS NULL) AS registration_date_nulls,
SUM(insurance_provider IS NULL) AS insurance_provider_nulls,
SUM(insurance_number IS NULL) AS insurance_number_nulls,
SUM(email IS NULL) AS email_nulls
FROM patients;

-- 2. Are there any NULL values in the doctors table?
SELECT
SUM(doctor_id IS NULL) AS doctor_id_nulls,
SUM(first_name IS NULL) AS first_name_nulls,
SUM(last_name IS NULL) AS last_name_nulls,
SUM(specialization IS NULL) AS specialization_nulls,
SUM(phone_number IS NULL) AS phone_number_nulls,
SUM(years_experience IS NULL) AS years_experience_nulls,
SUM(hospital_branch IS NULL) AS hospital_branch_nulls,
SUM(email IS NULL) AS email_nulls
FROM doctors;

-- 3. Are there any NULL values in the appointments table?
SELECT
SUM(appointment_id IS NULL) AS appointment_id_nulls,
SUM(patient_id IS NULL) AS patient_id_nulls,
SUM(doctor_id IS NULL) AS doctor_id_nulls,
SUM(appointment_date IS NULL) AS appointment_date_nulls,
SUM(appointment_time IS NULL) AS appointment_time_nulls,
SUM(reason_for_visit IS NULL) AS reason_for_visit_nulls,
SUM(status IS NULL) AS status_nulls
FROM appointments;

-- 4. Are there any NULL values in the treatments table?
SELECT
SUM(treatment_id IS NULL) AS treatment_id_nulls,
SUM(appointment_id IS NULL) AS appointment_id_nulls,
SUM(treatment_type IS NULL) AS treatment_type_nulls,
SUM(description IS NULL) AS description_nulls,
SUM(cost IS NULL) AS cost_nulls,
SUM(treatment_date IS NULL) AS treatment_date_nulls
FROM treatments;

-- 5. Are there any NULL values in the billing table?
SELECT
SUM(bill_id IS NULL) AS bill_id_nulls,
SUM(patient_id IS NULL) AS patient_id_nulls,
SUM(treatment_id IS NULL) AS treatment_id_nulls,
SUM(bill_date IS NULL) AS bill_date_nulls,
SUM(amount IS NULL) AS amount_nulls,
SUM(payment_method IS NULL) AS payment_method_nulls,
SUM(payment_status IS NULL) AS payment_status_nulls
FROM billing;

-- 6. Are there any duplicate patient IDs?
SELECT
patient_id,
COUNT(*) AS duplicate_count
FROM patients
GROUP BY patient_id
HAVING COUNT(*) > 1;

-- 7. Are there any duplicate doctor IDs?
SELECT
doctor_id,
COUNT(*) AS duplicate_count
FROM doctors
GROUP BY doctor_id
HAVING COUNT(*) > 1;

-- 8. Are there any duplicate appointment IDs?
SELECT
appointment_id,
COUNT(*) AS duplicate_count
FROM appointments
GROUP BY appointment_id
HAVING COUNT(*) > 1;

-- 9. Are there any duplicate appointment IDs?
SELECT
appointment_id,
COUNT(*) AS duplicate_count
FROM appointments
GROUP BY appointment_id
HAVING COUNT(*) > 1;

-- 10. Are there any duplicate treatment IDs?
SELECT
treatment_id,
COUNT(*) AS duplicate_count
FROM treatments
GROUP BY treatment_id
HAVING COUNT(*) > 1;

-- 11. Are there any duplicate bill IDs?
SELECT
bill_id,
COUNT(*) AS duplicate_count
FROM billing
GROUP BY bill_id
HAVING COUNT(*) > 1;

-- 12. Are there any negative treatment costs?
SELECT
treatment_id,
cost
FROM treatments
WHERE cost < 0;

-- 13. Are there any negative billing amounts?
SELECT
bill_id,
amount
FROM billing
WHERE amount < 0;

-- 14. Check for appointments with invalid patient IDs
SELECT
appointments.appointment_id,
patients.patient_id
FROM appointments 
LEFT JOIN patients 
ON appointments.patient_id = patients.patient_id
WHERE patients.patient_id IS NULL;

-- 15. Check for appointments with invalid doctor IDs
SELECT
appointments.appointment_id,
doctors.doctor_id
FROM appointments 
LEFT JOIN doctors 
ON appointments.doctor_id = doctors.doctor_id
WHERE doctors.doctor_id IS NULL;

-- 16. Check for treatments with invalid appointment IDs
SELECT
treatments.treatment_id,
appointments.appointment_id
FROM treatments 
LEFT JOIN appointments
ON treatments.appointment_id = appointments.appointment_id
WHERE appointments.appointment_id IS NULL;

-- 17. Check for bills with invalid treatment IDs
SELECT
billing.bill_id,
treatments.treatment_id
FROM billing 
LEFT JOIN treatments 
ON billing.treatment_id = treatments.treatment_id
WHERE treatments.treatment_id IS NULL;

-- ============================================
-- STEP 2: EXPLORATORY DATA ANALYSIS (EDA)
-- ============================================

-- 1. Find the total number of patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- 2. Find the total number of doctors
SELECT COUNT(*) AS total_doctors
FROM doctors;

-- 3. Find the total number of appointments
SELECT COUNT(*) AS total_appointments
FROM appointments;

-- 4. Find the total number of treatments
SELECT COUNT(*) AS total_treatments
FROM treatments;

-- 5. Find the total number of bills
SELECT COUNT(*) AS total_bills
FROM billing;

-- 6. Find the total billing amount
SELECT ROUND(SUM(amount),2) AS total_billing
FROM billing;

-- 7. Find the average billing amount
SELECT ROUND(AVG(amount),2) AS average_billing
FROM billing;

-- 8. Find the highest billing amount
SELECT MAX(amount) AS highest_bill
FROM billing;

-- 9. Find the lowest billing amount
SELECT MIN(amount) AS lowest_bill
FROM billing;

-- 10. Find the number of appointments by status
SELECT
status,
COUNT(*) AS appointment_count
FROM appointments
GROUP BY status;

-- 11. Find the number of appointments by reason for visit
SELECT
reason_for_visit,
COUNT(*) AS appointment_count
FROM appointments
GROUP BY reason_for_visit
ORDER BY appointment_count DESC;

-- 12. Find the number of treatments by treatment type
SELECT
treatment_type,
COUNT(*) AS treatment_count
FROM treatments
GROUP BY treatment_type
ORDER BY treatment_count DESC;

-- 13. Find the average cost by treatment type
SELECT
treatment_type,
ROUND(AVG(cost),2) AS average_cost
FROM treatments
GROUP BY treatment_type
ORDER BY average_cost DESC;

-- 14. Find total billing amount by payment method
SELECT
payment_method,
ROUND(SUM(amount),2) AS total_amount
FROM billing
GROUP BY payment_method
ORDER BY total_amount DESC;

-- 15. Find the number of bills by payment status
SELECT
payment_status,
COUNT(*) AS bill_count
FROM billing
GROUP BY payment_status
ORDER BY bill_count DESC;

-- =========================================
-- STEP 3: BUSINESS ANALYSIS
-- =========================================

-- 1. Doctors with the highest number of appointments
SELECT
doctors.doctor_id,
CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
COUNT(appointments.appointment_id) AS total_appointments
FROM doctors 
JOIN appointments 
ON doctors.doctor_id = appointments.doctor_id
GROUP BY
doctors.doctor_id,
doctors.first_name,
doctors.last_name
ORDER BY total_appointments DESC;

-- 2. Billed amount by treatment type
SELECT
treatments.treatment_type,
round(SUM(billing.amount),2) AS total_billed_amount
FROM treatments 
JOIN billing 
ON treatments.treatment_id = billing.treatment_id
GROUP BY treatments.treatment_type
ORDER BY total_billed_amount DESC;

-- 3. Patients with the highest total billed amount
SELECT
patients.patient_id,
CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
ROUND(SUM(billing.amount),2) AS total_billed_amount
FROM patients
JOIN billing
ON patients.patient_id = billing.patient_id
GROUP BY
patients.patient_id,
patients.first_name,
patients.last_name
ORDER BY total_billed_amount DESC;

-- 4. Appointment status distribution
SELECT
status,
COUNT(*) AS total_appointments,
ROUND(
	COUNT(*) * 100.0 /
	(SELECT COUNT(*) FROM appointments),
	2
) AS percentage
FROM appointments
GROUP BY status
ORDER BY total_appointments DESC;


-- 5. Doctors with the highest billed amount
SELECT
doctors.doctor_id,
CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
ROUND(SUM(billing.amount),2) AS total_billed_amount
FROM doctors
JOIN appointments
ON doctors.doctor_id = appointments.doctor_id
JOIN treatments 
ON appointments.appointment_id = treatments.appointment_id
JOIN billing 
ON treatments.treatment_id = billing.treatment_id
GROUP BY
doctors.doctor_id,
doctors.first_name,
doctors.last_name
ORDER BY total_billed_amount DESC;

-- 6. Monthly billing trend
SELECT
MONTH(bill_date) AS month,
ROUND(SUM(amount),2) AS total_billed_amount
FROM billing
GROUP BY
YEAR(bill_date),
MONTH(bill_date)
ORDER BY month,
total_billed_amount DESC;
    
-- 7. Monthly appointment trend
SELECT
MONTH(appointment_date) AS month,
COUNT(*) AS total_appointments
FROM appointments
GROUP BY
YEAR(appointment_date),
MONTH(appointment_date)
ORDER BY  month;
    
-- 8. Average treatment cost by treatment type
SELECT
treatment_type,
ROUND(AVG(cost), 2) AS average_treatment_cost
FROM treatments
GROUP BY treatment_type
ORDER BY average_treatment_cost DESC;

-- 9. Patients who received multiple treatments
SELECT
billing.patient_id,
CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
COUNT(billing.treatment_id) AS treatment_count
FROM billing 
JOIN patients 
ON billing.patient_id = patients.patient_id
GROUP BY
billing.patient_id,
patients.first_name,
patients.last_name
HAVING COUNT(billing.treatment_id) > 1
ORDER BY treatment_count DESC;

-- 10. Billing amount by payment method
SELECT
payment_method,
COUNT(*) AS number_of_bills,
ROUND(SUM(amount),2) AS total_billed_amount
FROM billing
GROUP BY payment_method
ORDER BY total_billed_amount DESC;

-- =========================================
-- FINAL SQL INSIGHTS
-- =========================================

-- 1. Doctor Workload
-- Doctor Sarah Taylor handled the highest number of appointments.

-- 2. Treatment Billing
-- Treatment Chemotherapy recorded the highest billed amount.

-- 3. Patient Billing
-- Patient Laura Davis had the highest total billed amount.

-- 4. Appointment Status
-- The largest share of appointments were in the No Show status.

-- 5. Doctor Billing
-- Doctor sarah Taylor was associated with the highest billed amount.

-- 6. Monthly Billing
-- The highest billing activity occurred in April month.

-- 7. Monthly Appointments
-- The highest appointment volume occurred in April month.

-- 8. Treatment Cost
-- Treatment MRI had the highest average treatment cost.

-- 9. Repeat Treatments
-- Several patients received multiple treatments,
-- indicating repeated treatment activity.

-- 10. Payment Methods
-- Credit Card payment method accounted for the highest billed amount.

-- ============================================================
-- END OF SQL ANALYSIS
-- ============================================================