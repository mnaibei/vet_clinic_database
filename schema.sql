/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY, 
  name VARCHAR(250),  
  date_of_birth DATE,  
  escape_attempts INT,  
  neutered BOOLEAN,  
  weight_kg DECIMAL 
  );


-- Day 3
CREATE TABLE owners(
  id SERIAL NOT NULL,
  full_name VARCHAR(200),
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species(
  id SERIAL NOT NULL,
  name VARCHAR(200),
  PRIMARY KEY(id)
);

ALTER TABLE animals DROP species;

ALTER TABLE species ADD CONSTRAINT species_name_unique UNIQUE (name);

ALTER TABLE animals ADD species_id VARCHAR(255) REFERENCES species(name);
ALTER TABLE animals ADD species_id INT REFERENCES species(id);

-- ALTER TABLE animals ADD species_id INT REFERENCES species(id);
ALTER TABLE animals ADD species_id VARCHAR(255) REFERENCES species(name);

ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);

-- DAY 4 

-- Create table vets

CREATE TABLE vets(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(100),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY (id)
);

-- Create table specializations

CREATE TABLE specializations(
  ID INT GENERATED BY DEFAULT AS IDENTITY,
  species_id INT REFERENCES species(id),
  vet_id INT REFERENCES vets(id),
  PRIMARY KEY(ID)
);


-- Create table visits

BEGIN;

ALTER TABLE animals ADD CONSTRAINT animals_id_unique UNIQUE (id);

COMMIT;

CREATE TABLE visits(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date DATE,
  PRIMARY KEY (id)
);