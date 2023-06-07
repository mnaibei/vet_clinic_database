/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Agumon', '03/02/2020', 0, true,10.23),
( 'Gabumon', '15/11/2018', 2, true,8),
('Pikachu', '07/01/2021', 1, false,15.04), 
('Devimon', '12/05/2017', 5, true,11),
('Charmander', '2020-02-08', 0, false,-11),
('Plantmom', '2021-11-15', 2, true,-5.7),
('Squirtle', '1993-04-02', 3, false, -12.3), 
('Angemon', '2005-06-12', 1, true, -45), 
('Boarmon', '2005-06-07', 7, true, 20.04),
('Blossom', '1998-10-13', 3, true, 17),
('Ditto', '2022-05-14', 4, true, 22);


-- Day 3 

-- INSERT OWNERS 
INSERT INTO owners (full_name, age) VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Insert data into species table
INSERT INTO species (name) VALUES
  ('Pokemon'),
  ('Digimon');

-- PET ID 
BEGIN;
UPDATE animals SET species_id = 'Digimon' WHERE name LIKE '%mon';
UPDATE animals SET species_id = 'Pokemon' WHERE species_id IS NULL;
COMMIT;
SELECT * FROM animals;

-- OWNER INFO 
BEGIN;
UPDATE animals SET owner_id = 1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');
COMMIT;
SELECT * FROM animals;