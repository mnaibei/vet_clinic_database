/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals; 
SELECT * FROM animals WHERE name LIKE '%mon'; 
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'; 
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;  
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu'); 
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5; 
SELECT * FROM animals WHERE neutered = TRUE; 
SELECT * FROM animals WHERE name <> 'Gabumon'; 
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3; 

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species from animals; -- verify that change was made
ROLLBACK;
SELECT species from animals;


BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species from animals;
COMMIT;
SELECT species from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT new_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO new_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- How many animals are there?
SELECT COUNT(*) FROM animals;
 count 
-------
    10
(1 row)

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
 count 
-------
     2
(1 row)

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
         avg         
---------------------
 15.5310000000000000
(1 row)

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escapes FROM animals 
GROUP BY neutered
ORDER BY total_escapes DESC;
 neutered | total_escapes 
----------+---------------
 t        |            20
 f        |             4
(2 rows)

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;
 species | min | max 
---------+-----+-----
 pokemon | 5.7 |  17
 digimon |   8 |  45
(2 rows)

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
 species |        avg         
---------+--------------------
 pokemon | 3.0000000000000000



--  MULTIPLE TABLES DAY 3 
-- What animals belong to Melody Pond?
SELECT name, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name  FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name, full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester with 0 escape attempts.
SELECT animals.name, full_name, escape_attempts FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name, COUNT(*) as most_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY full_name ORDER BY COUNT(*) DESC LIMIT 1;