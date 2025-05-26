-- Create Database
CREATE DATABASE conservation_db;

-- Create Rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);

-- Insert data into the Rangers table
INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

-- Create Species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

-- Insert data into the Species table
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

-- Create Sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT,
    species_id INT,
    sighting_time TIMESTAMP,
    location VARCHAR(255),
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    FOREIGN KEY (species_id) REFERENCES species (species_id)
);

-- Insert data into the Sightings table
INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

-- Problem 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3
SELECT
    sighting_id,
    species_id,
    ranger_id,
    location,
    sighting_time,
    notes
FROM sightings
WHERE
    location LIKE '%Pass%';

-- Problem 4
SELECT name, COUNT(name) as total_sightings
FROM rangers
    JOIN sightings USING (ranger_id)
GROUP BY
    name;

-- Problem 5
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT DISTINCT
            species_id
        FROM sightings
    );

-- Problem 6
SELECT sp.common_name, s.sighting_time, r.name
FROM
    sightings s
    JOIN species sp ON s.species_id = sp.species_id
    JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    EXTRACT(
        YEAR
        FROM discovery_date
    ) < 1800;

-- Problem 8
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) > 17 THEN 'Evening'
        ELSE 'Unknown'
    END AS time_of_day
FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );