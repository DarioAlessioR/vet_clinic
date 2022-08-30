-- Create a database based on a diagram
-- Create a file named schema_based_on_diagram.sql where you implement the database from the diagram.

CREATE DATABASE clinic;

CREATE TABLE patients(
   id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   name VARCHAR(50),
   date_of_birth DATE,	
);

CREATE TABLE medical_histories(
   id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   name VARCHAR(50),
   admitted_at TIMESTAMP,
   patient_id INT,
   status VARCHAR(50),
   CONSTRAINT fk_medical_histories_patients FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments(
   id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   type VARCHAR(50),
   name VARCHAR(100)
);

CREATE TABLE invoices(
   id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   total_amount DECIMAL,
   generated_at TIMESTAMP,
   payed_at TIMESTAMP,
   medical_histories_id INT,
   CONSTRAINT fk_invoices_medical_histories FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
   id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   unit_price DECIMAL,
   quantity INT NOT NULL,
   total_price DECIMAL,
   invoice_id INT NOT NULL,
   treatments_id INT,
   CONSTRAINT fk_invoices_items_invoices FOREIGN KEY(invoice_id) REFERENCES invoices(id),
   CONSTRAINT fk_invoices_items_treatments FOREIGN KEY(treatments_id) REFERENCES treatments(id)
);

-- Create an intermmediate table for medical_histories and treatments

CREATE TABLE medical_histories_and_treatments(
   medical_histories_id INT NOT NULL,
   treatments_id INT NOT NULL,
   CONSTRAINT fk_medical_histories FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
   CONSTRAINT fk_treatments FOREIGN KEY(treatments_id) REFERENCES treatments(id),
   PRIMARY KEY (medical_histories_id, treatments_id)
);

