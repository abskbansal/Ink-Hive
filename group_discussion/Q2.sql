-- TO CREATE THE TABLES

CREATE TABLE candidate (
    candidateID INT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    age INT NOT NULL,
    experience DECIMAL(5, 2),
    email VARCHAR(32)
);

CREATE TABLE phone (
    phone BIGINT,
    candidateID INT NOT NULL,

    PRIMARY KEY (phone),
    FOREIGN KEY (candidateID) REFERENCES candidate(candidateID)
);

CREATE TABLE `entry` (
    entryID INT,
    media_file VARCHAR(128) NOT NULL,
    `type` CHAR(5) NOT NULL,
    submission_date DATE NOT NULL,
    candidateID INT NOT NULL,
    channel VARCHAR(7),

    PRIMARY KEY (entryID),
    FOREIGN KEY (candidateID) REFERENCES candidate(candidateID),
    CHECK (`type` in ('audio', 'video')),
    CHECK (channel in ('digital', 'print'))
);

CREATE TABLE panelist (
    panelistID INT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    experience DECIMAL(5, 2),
    association VARCHAR(32) NOT NULL
);

CREATE TABLE evaluates (
    entryID INT,
    panelistID INT,
    outcome CHAR(4),

    PRIMARY KEY (entryID, panelistID),
    FOREIGN KEY (entryID) REFERENCES `entry`(entryID),
    FOREIGN KEY (panelistID) REFERENCES `panelist`(panelistID),
    CHECK (outcome in ('pass', 'fail'))
);

CREATE TABLE `show` (
    showID INT PRIMARY KEY,
    date_of_performance DATE,
    candidateID INT,
    selected VARCHAR(3),

    FOREIGN KEY (candidateID) REFERENCES candidate(candidateID),
    CHECK (selected in ('yes', 'no'))
);

CREATE TABLE album (
    albumID INT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    date_of_release DATE NOT NULL,
    no_of_visits INT,
    no_of_likes INT,
    no_of_dislikes INT,
    price INT NOT NULL,
    `type` CHAR(5),

    CHECK (`type` in ('audio', 'video'))
);

CREATE TABLE `group` (
    groupID INT PRIMARY KEY,
    name VARCHAR(32),
    directorID INT NOT NULL,
    albumID INT,

    FOREIGN KEY (directorID) REFERENCES candidate(candidateID),
    FOREIGN KEY (albumID) REFERENCES album(albumID)
);

CREATE TABLE `belongs` (
    candidateID INT,
    groupID INT,
    `role` VARCHAR(32) NOT NULL,

    PRIMARY KEY (candidateID, groupID),
    FOREIGN KEY (candidateID) REFERENCES candidate(candidateID),
    FOREIGN KEY (groupID) REFERENCES `group`(groupID)
);

CREATE TABLE distributor (
    distributorID INT PRIMARY KEY,
    name VARCHAR(32)
);

CREATE TABLE sells (
    distributorID INT,
    albumID INT,
    price INT NOT NULL,

    PRIMARY KEY (distributorID, albumID),
    FOREIGN KEY (distributorID) REFERENCES distributor(distributorID),
    FOREIGN KEY (albumID) REFERENCES album(albumID)
);

CREATE TABLE download (
    downloadID INT PRIMARY KEY,
    incomingURL VARCHAR(128) NOT NULL,
    date_of_download DATE,
    `status` CHAR(7),
    albumID INT,

    FOREIGN KEY (albumID) REFERENCES album(albumID),
    CHECK (`status` in ('success', 'failure'))
);

--
-- TO POPULATE DATA
--

-- Insert data into candidate table
INSERT INTO candidate (candidateID, name, age, experience, email) VALUES
(1, 'Rajesh Kumar', 28, 3.5, 'rkumar@gmail.com'),
(2, 'Priya Sharma', 25, 2.8, 'psharma@gmail.com'),
(3, 'Amit Singh', 30, 4.2, 'asingh@gmail.com'),
(4, 'Deepika Patel', 27, 3.9, 'dpatel@gmail.com'),
(5, 'Rahul Verma', 32, 5.1, 'rverma@gmail.com');

-- Insert data into phone table
INSERT INTO phone (phone, candidateID) VALUES
(9876543210, 1),
(8765432109, 1),
(7654321099, 1),
(6543210988, 1),
(7654321098, 2),
(6543210987, 2),
(5432109876, 3),
(4321098765, 3),
(5432109877, 3),
(3210987654, 4),
(2109876543, 4),
(9876543211, 5);

-- Insert data into entry table
INSERT INTO `entry` (entryID, media_file, `type`, submission_date, candidateID, channel) VALUES
(101, 'audio_file1.mp3', 'audio', '2024-01-15', 1, 'digital'),
(102, 'video_file1.mp4', 'video', '2024-01-16', 1, 'print'),
(103, 'video_file5.mp4', 'video', '2024-01-22', 2, 'print'),
(104, 'audio_file4.mp3', 'audio', '2024-01-21', 2, 'digital'),
(105, 'audio_file2.mp3', 'audio', '2024-01-17', 3, 'digital'),
(106, 'video_file2.mp4', 'video', '2024-01-18', 4, 'print'),
(107, 'audio_file3.mp3', 'audio', '2024-01-19', 4, 'print'),
(108, 'video_file3.mp4', 'video', '2024-01-20', 4, 'digital'),
(109, 'video_file4.mp4', 'video', '2024-01-22', 5, 'print'),
(110, 'video_file4.mp4', 'video', '2024-01-22', 5, 'print');

-- Insert data into panelist table
INSERT INTO panelist (panelistID, name, experience, association) VALUES
(101, 'Arun Khanna', 5.2, 'Music Producer'),
(102, 'Sunita Reddy', 4.8, 'Singer'),
(103, 'Rahul Kapoor', 6.5, 'Music Composer'),
(104, 'Sarita Singh', 5.9, 'Music Director'),
(105, 'Vivek Sharma', 4.2, 'Sound Engineer'),
(106, 'Ananya Patel', 3.7, 'Lyricist');

-- Insert data into evaluates table
INSERT INTO evaluates (entryID, panelistID, outcome) VALUES
(101, 101, 'pass'),
(102, 103, 'fail'),
(103, 103, 'pass'),
(104, 102, 'fail'),
(105, 103, 'pass'),
(106, 106, 'fail'),
(107, 105, 'pass'),
(108, 102, 'pass'),
(109, 104, 'pass'),
(110, 105, 'fail');

-- Insert data into show table
INSERT INTO `show` (showID, date_of_performance, candidateID, selected) VALUES
(1, '2024-02-01', 1, 'yes'),
(2, '2024-02-02', 2, 'yes'),
(3, '2024-02-03', 3, 'yes'),
(4, '2024-02-04', 4, 'no'),
(5, '2024-02-05', 5, 'yes');

-- Insert data into album table
INSERT INTO album (albumID, name, date_of_release, no_of_visits, no_of_likes, no_of_dislikes, price, `type`) VALUES
(101, "Eternal Melodies", '2020-03-01', 5000, 4000, 1000, 250, 'audio'),
(102, "Serenade of Dreams", '2024-03-05', 4800, 3800, 1000, 300, 'video'),
(103, "Whispers in the Wind", '2024-03-10', 5200, 4200, 1000, 280, 'audio'),
(104, "Harmony's Embrace", '2024-03-15', 4900, 3900, 1000, 270, 'video'),
(105, "Echoes of Eternity", '2024-03-20', 5100, 4100, 1000, 290, 'audio'),
(106, "Symphony of Serenity", '2024-03-25', 5300, 4300, 1000, 260, 'audio'),
(107, "Mystical Reverie", '2024-03-30', 5200, 4200, 1000, 270, 'audio'),
(108, "Aurora's Lullaby", '2024-04-01', 5400, 4400, 1000, 280, 'video');

-- Insert data into `group` table
INSERT INTO `group` (groupID, name, directorID, albumID) VALUES
(1, 'Pop', 1, 101),
(2, 'Drummers', 2, 102),
(3, 'Rock Band', 3, 103),
(4, 'Fusion Ensemble', 3, 104),
(5, 'Jazz Quartet', 5, 105),
(6, 'Hip Hop Crew', 5, 106),
(7, 'Folk Group', 1, 107);

-- Insert data into belongs table
INSERT INTO belongs (candidateID, groupID, `role`) VALUES
(1, 1, 'Singer'),
(3, 1, 'Guitarist'),
(5, 4, 'Keyboardist'),
(5, 5, 'Drummer'),
(1, 2, 'Violinist'),
(2, 6, 'Rapper'),
(5, 7, 'Flute Player'),
(2, 3, 'DJ');

-- Insert data into distributor table
INSERT INTO distributor (distributorID, name) VALUES
(1, 'MusicPlus'),
(2, 'AudioWave'),
(3, 'MelodyMasters'),
(4, 'BeatBox'),
(5, 'RhythmRecords'),
(6, 'SymphonySound'),
(7, 'TuneWorld'),
(8, 'HarmonyHub');

-- Insert data into sells table
INSERT INTO sells (distributorID, albumID, price) VALUES
(1, 101, 200),
(2, 102, 220),
(3, 103, 240),
(4, 104, 230),
(5, 105, 250),
(6, 106, 210),
(7, 107, 230),
(8, 108, 240);

-- Insert data into download table
INSERT INTO download (downloadID, incomingURL, date_of_download, `status`, albumID) VALUES
(1, 'http://musicplus.com/download/101', '2024-03-01', 'success', 101),
(2, 'http://audiowave.com/download/102', '2024-03-02', 'success', 102),
(3, 'http://melodymasters.com/download/103', '2024-03-03', 'failure', 103),
(4, 'http://beatbox.com/download/104', '2024-03-04', 'success', 104),
(5, 'http://rhythmrecords.com/download/105', '2024-03-05', 'failure', 105),
(6, 'http://symphonysound.com/download/106', '2024-03-06', 'success', 106),
(7, 'http://tuneworld.com/download/107', '2024-03-07', 'failure', 107),
(8, 'http://harmonyhub.com/download/108', '2024-03-08', 'success', 108);
