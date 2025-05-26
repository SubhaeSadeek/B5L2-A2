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

--Insert DATA to tables
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
    (2, 1, '2024-05-18 18:30:00', 'Snowfall Pass', NULL);



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PROBLEMS (TOTAL - 09)

-- Problem 01 ----------------------------------------------- 

INSERT INTO rangers(name, region)
    VALUES('Derek Fox', 'Coastal Plains');


-- Problem 02 -------------------------------------------------------
SELECT COUNT(DISTINCT species_id) AS  unique_species_count FROM sightings


-- Problem 03 ------------------------------------------------------
SELECT * FROM sightings WHERE "location" LIKE '%Pass%'  ;

-- Problem 04 ----------------------------------------------------

SELECT rangers.name, COUNT(sightings.species_id) AS  total_sightings
FROM rangers
JOIN sightings
ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name 
ORDER BY rangers.name ASC;

-- Problem 05 -----------------------------------------------------
SELECT species.common_name
FROM species
LEFT JOIN sightings
ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;

-- Problem 06 -----------------------------------------------------
SELECT  species.common_name, sightings.sighting_time, rangers.name 
FROM species
JOIN sightings ON species.species_id = sightings.species_id
JOIN rangers ON rangers.ranger_id = sightings.ranger_id
ORDER BY sightings.sighting_time DESC 
LIMIT 2;

-- Problem 07 ---------------------------------------
UPDATE species SET conservation_status = 'Historic' WHERE discovery_date < '1799-12-31';

-- Problem 08 ------------------------
CREATE OR REPLACE FUNCTION time_in_day(ts TIMESTAMP)
RETURNS TEXT AS $$
BEGIN
  IF EXTRACT(HOUR FROM ts) < 12 THEN
    RETURN 'Morning';
  ELSIF EXTRACT(HOUR FROM ts) BETWEEN 12 AND 17 THEN
    RETURN 'Afternoon';
  ELSE
    RETURN 'Evening';
  END IF;
END;
$$ LANGUAGE plpgsql;

SELECT sighting_id, time_in_day(sighting_time) AS time_of_day FROM sightings;


-- problem 09 ------------------------------------- 
DELETE FROM rangers
WHERE ranger_id IN (
        SELECT rangers.ranger_id 
        FROM rangers 
        LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
        WHERE sightings.ranger_id IS NULL
);


