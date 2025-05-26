-- Active: 1747760487163@@localhost@5432@conservation_db
--DATABASE Created
CREATE DATABASE conservation_db;

-- All 3 table created
-----------------------
CREATE TABLE rangers(
ranger_id SERIAL PRIMARY KEY,
name VARCHAR(150) NOT NULL,
region VARCHAR(100) NOT NULL

);

CREATE TABLE species(
species_id SERIAL PRIMARY KEY,
common_name VARCHAR(50),
scientific_name TEXT NOT NULL,
discovery_date DATE NOT NULL,
conservation_status VARCHAR(20) NOT NULL
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL,
    location VARCHAR(50),
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT,
    
    FOREIGN KEY(ranger_id) REFERENCES rangers(ranger_id),
    FOREIGN KEY(species_id) REFERENCES species(species_id)

);

--Insert DATA to table
INSERT INTO rangers(name, region)
    VALUES
    ('Alice Green', 'Northern Hills'),
    ('Bob White', 'River Delta'),
    ('Carol King', 'Mountain Range');

INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status) 
    VALUES
    ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
    ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01','Endangered'),
    ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
    ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings(ranger_id, species_id, sighting_time, location, notes )
    VALUES

    (1, 1, '2024-05-10 07:45:00', 'Peak Ridge' ,'Camera trap image captured'),
    (2, 2, '2024-05-12 16:20:00', 'Bankwood Area' ,'Juvenile seen'),
    (3, 3, '2024-05-15 09:10:00', 'Bamboo Grove East' ,'Feeding observed'),
    (1, 2, '2024-05-18 18:30:00', 'Snowfall Pass', NULL);



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PROBLEMS (TOTAL - 09)

-- 01. Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'

INSERT INTO rangers(name, region)
    VALUES('Derek Fox', 'Coastal Plains');


-- 02. Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS  unique_species_count FROM sightings


-- 03. Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE "location" LIKE '%Pass%'  ;

-- 04. List each ranger's name and their total number of sightings.

SELECT rangers.name, COUNT(sightings.species_id) AS  total_sightings
FROM rangers
JOIN sightings
ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name;


select * FROM species;

