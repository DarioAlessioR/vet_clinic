-- Create a database based on a diagram
-- Create a file named schema_based_on_diagram.sql where you implement the database from the diagram.

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
   status VARCHAR(50)
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
   medical_history_id INT
);

CREATE TABLE invoice_items(
   id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   unit_price DECIMAL,
   quantity INT NOT NULL,
   total_price DECIMAL,
   invoice_id INT NOT NULL,
   treatment_id INT 
);
