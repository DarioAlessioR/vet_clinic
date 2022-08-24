/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, TRUE, 11.00);

/* Add 7 new animals to table (day 2) */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
     ('Charmander', '2020-02-08', 0, FALSE, -11.00),
	 ('Plantmon', '2021-11-15', 2, TRUE, -5.70),
	 ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
	 ('Angemon', '2005-06-12', 1, TRUE, -45.00),
	 ('Boarmon', '2005-06-07', 7, TRUE, 20.40),
	 ('Blossom', '1998-10-13', 3, TRUE, 17.00),
	 ('Ditto', '2022-05-14', 4, TRUE, 22.00);

/* Insert the following data into the owners table (day 3) */

INSERT INTO owners (full_name, age)
    VALUES
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

/* Insert the following data into the species table (day 3) */
INSERT INTO species (name)
    VALUES
	('Pokemon'),
	('Digimon');

/* Modify your inserted animals so it includes the species_id value:
If the name ends in "mon" it will be Digimon
All other animals are Pokemon (day 3)*/

BEGIN TRANSACTION;

UPDATE animals
    SET species_id = (SELECT species.id FROM species WHERE species.name = 'Pokemon')  
	WHERE name NOT LIKE '%mon';

COMMIT;

BEGIN TRANSACTION;

UPDATE animals
    SET species_id = (SELECT sepecies.id FROM species WHERE species.name = 'Digimon')
	WHERE name LIKE '%mon';

COMMIT;

/* Modify your inserted animals to include owner information (owner_id):
Sam Smith owns Agumon.
Jennifer Orwell owns Gabumon and Pikachu.
Bob owns Devimon and Plantmon.
Melody Pond owns Charmander, Squirtle, and Blossom.
Dean Winchester owns Angemon and Boarmon. (day 3)*/

BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Sam Smith')
    WHERE name = 'Agumon';

COMMIT;

BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Jennifer Orwell')
    WHERE name = 'Gabumon' OR name = 'Pikachu';

COMMIT;

BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Bob')
    WHERE name IN ('Devimon', 'Plantmon');

COMMIT;

BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Melody Pond')
    WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

COMMIT;

BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Dean Winchester')
    WHERE name IN ('Angemon', 'Boarmon');

COMMIT;
