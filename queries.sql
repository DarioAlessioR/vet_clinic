/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT name, date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.40 AND weight_kg <= 17.30;

/*Queries and transactions for day 2*/

/* Inside a transaction update the animals table by setting the species column to
 unspecified. Verify that change was made. Then roll back the change and verify that
 the species columns went back to the state before the transaction  */
BEGIN TRANSACTION;

UPDATE animals
    SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

/* Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit. */

BEGIN TRANSACTION;

UPDATE animals
    SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals
   SET species = 'pokemon' WHERE species IS NULL;
   
SELECT * FROM animals; 

COMMIT;

SELECT * FROM animals; 

/* Inside a transaction delete all records
 in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists. 
*/

BEGIN TRANSACTION;

DELETE FROM animals;

SELECT * FROM animals; 

ROLLBACK;

SELECT * FROM animals; 

/* Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction */

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete2022;

SELECT * FROM animals; 

UPDATE animals
    SET weight_kg = weight_kg * -1;
	
SELECT * FROM animals; 

ROLLBACK TO delete2022;

UPDATE animals
   SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT;

/* Write queries to answer the following questions:*/

/* How many animals are there? */
SELECT COUNT(DISTINCT name) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT AVG(escape_attempts), neutered FROM animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT MIN(weight_kg), MAX(weight_kg), species FROM animals GROUP BY species; 

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT AVG(escape_attempts) AS AVERAGE_ESCAPES, species FROM animals
    WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Write queries (using JOIN) to answer the following questions: (day 3) */

/* What animals belong to Melody Pond? */
SELECT name, full_name FROM animals JOIN owners
    ON animals.owner_id = owners.id
    WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon).*/
SELECT animals.name FROM animals JOIN species
    ON animals.species_id = species.id
	WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal.*/
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals
    ON animals.owner_id = owners.id;

/* or : */
SELECT 
	owners.full_name, STRING_AGG (animals.name, ', ') as animals
    FROM owners
    LEFT JOIN animals ON owners.id = animals.owner_id
    GROUP BY owners.full_name;

/* How many animals are there per species?*/
SELECT COUNT(animals.name), species.name FROM animals
   JOIN species
   ON animals.species_id = species.id
   GROUP BY species.name;


/* List all Digimon owned by Jennifer Orwell.*/
SELECT animals.name, owners.full_name FROM animals
    JOIN owners ON animals.owner_id = owners.id
    JOIN species ON species.id = animals.species_id
	WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT animals.name, owners.full_name FROM animals
    JOIN owners ON animals.owner_id = owners.id
	WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

/* Who owns the most animals?*/
SELECT owners.full_name, COUNT(animals.id) FROM owners
    JOIN animals ON animals.owner_id = owners.id
	GROUP BY owners.full_name
	ORDER BY COUNT(animals.id) DESC
	LIMIT 1;

/* Write queries to answer the following (day 4): */

/* Who was the last animal seen by William Tatcher? */

SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits 
ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see?*/
SELECT animals.name, vets.name, FROM animals JOIN visits 
ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/* List all vets and their specialties, including vets with no specialties.*/
SELECT vets.name, species.name FROM vets LEFT JOIN specializations
ON vets.id = specializations.vets_id LEFT JOIN species
ON specializations.species_id = species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits 
ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit > '2020-04-01'
AND visits.date_of_visit <= '2020-08-30'
ORDER BY visits.date_of_visit DESC;

/* What animal has the most visits to vets?*/
SELECT animals.name, COUNT(visits.animals_id) FROM visits JOIN animals 
ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY COUNT(visits.animals_id) DESC
LIMIT 1;

/* Who was Maisy Smith's first visit?*/
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits 
ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit.*/
SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg,
species.name AS specie, owners.full_name AS owner, vets.name AS vet, vets.age AS vet_age,
vets.date_of_graduation AS vet_grad, visits.date_of_visit AS visit_date FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
JOIN vets ON visits.vets_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species?*/
SELECT COUNT(visits.animals_id) FROM visits JOIN animals 
ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE animals.species_id NOT IN (
    SELECT species_id FROM specializations 
    WHERE vets_id = vets.id
    );

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT species.name, COUNT(animals.species_id) FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(animals.species_id) DESC
LIMIT 1;
