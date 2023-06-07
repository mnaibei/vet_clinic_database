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

-- ALTER TABLE animals ADD species_id INT REFERENCES species(id);
ALTER TABLE animals ADD species_id VARCHAR(255) REFERENCES species(name);

ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);