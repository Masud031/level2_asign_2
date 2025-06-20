-- Active: 1747490419603@@127.0.0.1@5432@conservation_db
CREATE TABLE rangers (
 id SERIAL PRIMARY KEY,
 name VARCHAR(25),
 region VARCHAR(50)
);
ALTER TABLE rangers RENAME COLUMN id TO ranger_id;


INSERT INTO rangers (name, region) VALUES
    ('Alice Green', 'Northern Hills'),
    ('Bob White', 'River Delta'),
    ('Carol King', 'Mountain Range');

--Problem 1--
INSERT INTO rangers (name, region) VALUES
('Derek Fox','Coastal Plains');


SELECT *FROM rangers

CREATE TABLE species (
 species_id SERIAL PRIMARY KEY,
 common_name VARCHAR(25),
 scientific_name VARCHAR(50),
  discovery_date DATE,
  conservation_status VARCHAR(50)
);

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
    ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
    ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
    ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
    ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');




SELECT *FROM species;

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(species_id),
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    sighting_time TIMESTAMP, 
    location VARCHAR(100),
    notes VARCHAR(100)
);

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
    (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
    (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
    (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
    (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


--- problem 2---
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;


--- problem 3 ---
SELECT *FROM  sightings WHERE  location ILIKE '%Pass%' ; 


SELECT *FROM sightings;


--- problem 4 ---
SELECT rangers.NAME,  count(sightings.sighting_id) AS total_sightings from rangers LEFT JOIN sightings on rangers.ranger_id =sightings.ranger_id
GROUP BY rangers.NAME 
ORDER BY total_sightings DESC; 


--- problem 5 ---
SELECT sp.species_id, sp.common_name
FROM species sp
LEFT JOIN sightings s ON sp.species_id = s.species_id
WHERE s.species_id IS NULL;


--- problem 6 ---
SELECT sp.common_name, s.sighting_time, r.name AS ranger_name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;


--- problem 7 ---
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';



--- problem 8 ---
SELECT 
  sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;


--- problem 9 ---
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
  WHERE ranger_id IS NOT NULL
);




