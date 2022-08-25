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

/* Day 4
Create a table named vets with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string
age: integer
date_of_graduation: date
*/ 

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY
	(START WITH 1 INCREMENT BY 1),
	name VARCHAR(100) NOT NULL,
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY (id)
);


/* Day 4
Create a "join table" called specializations
*/ 

CREATE TABLE specializations(
    vets_id INT,
	species_id INT,
	PRIMARY KEY(vets_id, species_id)
);

ALTER TABLE specializations
ADD FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE specializations
ADD FOREIGN KEY(vets_id) REFERENCES vets(id);

/* Day 4
Create a "join table" called visits
*/ 

CREATE TABLE visits(
    id SERIAL NOT NULL,
    vets_id INT,
	animals_id INT,
    date_of_visit DATE,
	PRIMARY KEY(id)
);

ALTER TABLE visits
ADD FOREIGN KEY(vets_id) REFERENCES vets(id);

ALTER TABLE visits
ADD FOREIGN KEY(animals_id) REFERENCES animals(id);
