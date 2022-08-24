/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
   id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
   name VARCHAR(50),
   date_of_birth DATE,
   escape_attempts INT,
   neutered BOOLEAN,
   weight_kg DECIMAL	
);

/*
Update animal table with new column
*/ 

ALTER TABLE animals ADD COLUMN species VARCHAR(50);

/* Day 3
Create a table named owners with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
full_name: string
age: integer
*/ 

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY
	(START WITH 1 INCREMENT BY 1),
	full_name VARCHAR(100) NOT NULL,
	age INT,
	PRIMARY KEY (id)
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY
	(START WITH 1 INCREMENT BY 1),
	name VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT
	REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT
	REFERENCES owners(id);




