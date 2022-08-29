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

/* Insert the following data into the vets table (day 4) */

INSERT INTO vets (name, age, date_of_graduation)
    VALUES
	('William Tatcher', 45,'2000-04-23'),
	('Maisy Smith', 26, '2019-01-17'),
	('Stephanie Mendez', 64, '1981-05-04'),
	('Jack Harkness', 38, '2008-06-08');

/* Insert the following data into the specializations table (day 4)
Vet William Tatcher is specialized in Pokemon.
Vet Stephanie Mendez is specialized in Digimon and Pokemon.
Vet Jack Harkness is specialized in Digimon.
 */

INSERT INTO specializations (vets_id, species_id)
    VALUES
	((SELECT id FROM vets WHERE vets.name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon'));
    
INSERT INTO specializations (vets_id, species_id)
    VALUES	
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon'));
    
INSERT INTO specializations (vets_id, species_id)
    VALUES	
	((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon'));	
	
INSERT INTO specializations (vets_id, species_id)
    VALUES		
	((SELECT id FROM vets WHERE vets.name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

/* Insert the following data into the visits table (day 4) */

INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'),
 (SELECT id FROM animals WHERE name = 'Agumon'), 'May 24, 2020');

INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
 (SELECT id FROM animals WHERE name = 'Agumon'), 'Jul 22, 2020');

INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
 (SELECT id FROM animals WHERE name = 'Gabumon'), 'Feb 2, 2021');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Pikachu'), 'Jan 5, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Pikachu'), 'Mar 8, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Pikachu'), 'May 14, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
 (SELECT id FROM animals WHERE name = 'Devimon'), 'May 4, 2021');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
 (SELECT id FROM animals WHERE name = 'Charmander'), 'Feb 24, 2021');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Plantmon'), 'Dec 21, 2019');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'),
 (SELECT id FROM animals WHERE name = 'Plantmon'), 'Aug 10, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Plantmon'), 'Apr 7, 2021');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
 (SELECT id FROM animals WHERE name = 'Squirtle'), 'Sep 29, 2019');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
 (SELECT id FROM animals WHERE name = 'Angemon'), 'Oct 3, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'),
 (SELECT id FROM animals WHERE name = 'Angemon'), 'Nov 4, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Boarmon'), 'Jan 24, 2019');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Boarmon'), 'May 15, 2019');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Boarmon'), 'Feb 27, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'),
 (SELECT id FROM animals WHERE name = 'Boarmon'), 'Aug 3, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
 (SELECT id FROM animals WHERE name = 'Blossom'), 'May 24, 2020');


INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'),
 (SELECT id FROM animals WHERE name = 'Blossom'), 'Jan 11, 2021');


--Run the following statements to add data to your database (executing them might take a few minutes) (week 2, day 1):
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids,
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.) (day 1)
insert into owners (full_name, email)
select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';




