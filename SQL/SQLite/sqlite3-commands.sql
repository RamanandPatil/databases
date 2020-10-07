/* Use only "sqlite3" command to enter into sqlite3 shell with a transient
   in-memory database. But later you should use ".open databasename.db" to enter
   into an actual database file.*/
C:\Users\rkpatil.ORADEV>sqlite3
SQLite version 3.28.0 2019-04-16 19:49:53
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
-- open the database file.
sqlite>.open test.db
sqlite>


/* The above 2 commands are equivalent to below single command, which uses
   database name db name from outside the sqlite3 shell: */
D:\Learning\databases>sqlite3 test.db
SQLite version 3.28.0 2019-04-16 19:49:53
Enter ".help" for usage hints.
sqlite>

/* ".help" for help menu inside sqlite3 shell.
sqlite> .help
.archive ...             Manage SQL archives
.auth ON|OFF             Show authorizer callbacks
.backup ?DB? FILE        Backup DB (default "main") to FILE
.bail on|off             Stop after hitting an error.  Default OFF
.binary on|off           Turn binary output on or off.  Default OFF
.cd DIRECTORY            Change the working directory to DIRECTORY
.changes on|off          Show number of rows changed by SQL
.check GLOB              Fail if output since .testcase does not match
.clone NEWDB             Clone data into NEWDB from the existing database
.databases               List names and files of attached databases
.dbconfig ?op? ?val?     List or change sqlite3_db_config() options
.dbinfo ?DB?             Show status information about the database
.dump ?TABLE? ...        Render all database content as SQL
.echo on|off             Turn command echo on or off
.eqp on|off|full|...     Enable or disable automatic EXPLAIN QUERY PLAN
.excel                   Display the output of next command in a spreadsheet
.exit ?CODE?             Exit this program with return-code CODE
.expert                  EXPERIMENTAL. Suggest indexes for specified queries
.fullschema ?--indent?   Show schema and the content of sqlite_stat tables
.headers on|off          Turn display of headers on or off
.help ?-all? ?PATTERN?   Show help text for PATTERN
.import FILE TABLE       Import data from FILE into TABLE
.imposter INDEX TABLE    Create imposter table TABLE on index INDEX
.indexes ?TABLE?         Show names of indexes
.limit ?LIMIT? ?VAL?     Display or change the value of an SQLITE_LIMIT
.lint OPTIONS            Report potential schema issues.
.load FILE ?ENTRY?       Load an extension library
.log FILE|off            Turn logging on or off.  FILE can be stderr/stdout
.mode MODE ?TABLE?       Set output mode
.nullvalue STRING        Use STRING in place of NULL values
.once (-e|-x|FILE)       Output for the next SQL command only to FILE
.open ?OPTIONS? ?FILE?   Close existing database and reopen FILE
.output ?FILE?           Send output to FILE or stdout if FILE is omitted
.parameter CMD ...       Manage SQL parameter bindings
.print STRING...         Print literal STRING
.progress N              Invoke progress handler after every N opcodes
.prompt MAIN CONTINUE    Replace the standard prompts
.quit                    Exit this program
.read FILE               Read input from FILE
.restore ?DB? FILE       Restore content of DB (default "main") from FILE
.save FILE               Write in-memory database into FILE
.scanstats on|off        Turn sqlite3_stmt_scanstatus() metrics on or off
.schema ?PATTERN?        Show the CREATE statements matching PATTERN
.selftest ?OPTIONS?      Run tests defined in the SELFTEST table
.separator COL ?ROW?     Change the column and row separators
.sha3sum ...             Compute a SHA3 hash of database content
.shell CMD ARGS...       Run CMD ARGS... in a system shell
.show                    Show the current values for various settings
.stats ?on|off?          Show stats or turn stats on or off
.system CMD ARGS...      Run CMD ARGS... in a system shell
.tables ?TABLE?          List names of tables matching LIKE pattern TABLE
.testcase NAME           Begin redirecting output to 'testcase-out.txt'
.timeout MS              Try opening locked tables for MS milliseconds
.timer on|off            Turn SQL timer on or off
.trace ?OPTIONS?         Output each SQL statement as it is run
.vfsinfo ?AUX?           Information about the top-level VFS
.vfslist                 List all available VFSes
.vfsname ?AUX?           Print the name of the VFS stack
.width NUM1 NUM2 ...     Set column widths for "column" mode
*/


/* Prints table headers (name of each column) for every query used to display
   the content. By default this option is off. */
sqlite> .headers on





/* Creates a table named "contacts", with 3 columns namely name, phone and email
   of type text, integer, and text respectively. */
sqlite> CREATE TABLE contacts (name text, phone integer, email text);
-- Every SQL query must end with semicolon(;).





/* Insert one contact entry into contacts table. */
sqlite> INSERT INTO contacts (name, phone, email) VALUES('Tim', 6545678, 'tim@email.com');

/* OR we can use only values to insert, if we are providing all the values in
   the same order as that of columns of the table. */
sqlite> INSERT INTO contacts VALUES('Tim', 6545678, 'tim@email.com');

/* Insert one more entry. */
sqlite> INSERT INTO contacts VALUES("Brian", 1234, "brian@myemail.com");

/* Insert one more entry, with only 2 values. This will be failed with error
   shown below, because we have not provided all the values.
   This will work, if we explicitly provide column names to be updated. */
sqlite> INSERT INTO contacts VALUES("Steve", 1234);
Error: table contacts has 3 columns but 2 values were supplied

/* Below query will work even with 2 values, because we are providing column
   names which needs to be updated with the provided values.*/
sqlite> INSERT INTO contacts(name, phone) VALUES("Steve", 1234);
-- Note, that we have not provided email id and it is OK for sqlite3.





/* Fetch and display all the entries from contacts table. */
sqlite> SELECT * FROM contacts;
name|phone|email
Tim|6545678|tim@email.com
Brian|1234|brian@myemail.com
Steve|1234|

/* This is same as below query: */
sqlite> SELECT name, phone, email FROM contacts;
name|phone|email
Tim|6545678|tim@email.com
Brian|1234|brian@myemail.com
Steve|1234|

/* Now select/show only email entries from contacts tables. */
sqlite> SELECT email FROM contacts;
email
tim@email.com
brian@myemail.com




/* Even thought it is not a good practice, we can insert data with different type
   into table without any issues. For example below, we insert phone number as
   text, instead of integer. And sqlite3 inserts it without any issues.*/
sqlite> INSERT INTO contacts VALUES("Avril", "+61 (0)87654321", "avril@email.com.au");

sqlite> SELECT * FROM contacts;
name|phone|email
Tim|6545678|tim@email.com
Brian|1234|brian@myemail.com
Steve|1234|
Avril|+61 (0)87654321|avril@email.com.au





/* Now, backup out test.db: */
sqlite> .backup test.db
-- cannot use the same name for backup.
Error: database is locked

sqlite> .backup testbackup.db
-- Now, you can see the testbackup.db file in the same directory (working).





/* Update tables:
   We know that we have inserted entry for Steve without email.
   Let us update email for Steve. And verify the results by showing table data. */
sqlite> UPDATE contacts SET email="steve@isemail.com";

-- Now, select all the records from contacts table:
sqlite> SELECT * FROM contacts;
name|phone|email
Tim|6545678|steve@isemail.com
Brian|1234|steve@isemail.com
Steve|1234|steve@isemail.com
Avril|+61 (0)87654321|steve@isemail.com
/* What went wrong? we have updated all records with same Steve's email id.
   Now, it is time to learn a new keyword called "WHERE" clause.
   Before that, just restore our backed up test.db database which has correct
   emails for everyone(with Steve having no email id).*/
sqlite> .restore testbackup.db
/* Verify if we have restored test.db correctly by displaying all records from
   contacts table. */
sqlite> SELECT * FROM contacts;
name|phone|email
Tim|6545678|tim@email.com
Brian|1234|brian@myemail.com
Steve|1234|
Avril|+61 (0)87654321|avril@email.com.au


/* Now, update email id for Steve by using WHERE clause. */
sqlite> UPDATE contacts SET email="steve@isemail.com" WHERE name="Steve";
-- Verify Steve's email
sqlite> SELECT * FROM contacts;
name|phone|email
Tim|6545678|tim@email.com
Brian|1234|brian@myemail.com
Steve|1234|steve@isemail.com
Avril|+61 (0)87654321|avril@email.com.au

/* Since we know what WHERE clause is, using it now we can view/select only
   Steve's record. */
sqlite> SELECT * FROM contacts WHERE name="Steve";
name|phone|email
Steve|1234|steve@isemail.com

/* Few more examples using WHERE clause.
   Can you select and show all records for Brian in the contacts table ?. */
sqlite> SELECT * FROM contacts WHERE name="Brian";
name|phone|email
Brian|1234|brian@myemail.com

-- Show only phone and email for Brian.
sqlite> SELECT phone, email FROM contacts WHERE name="Brian";
phone|email
1234|brian@myemail.com





/* Deleting records:
   Delete all the records from the contacts table who have 1234 as phone number. */
sqlite> DELETE FROM contacts WHERE phone=1234;
-- See the table contents to confirm deletion.
sqlite> SELECT * FROM contacts;
name|phone|email
Tim|6545678|tim@email.com
Avril|+61 (0)87654321|avril@email.com.au
-- You can see that the whole record for "Brian" is deleted from the table.





/* Some miscellaneous sqlite3 commands:
   .tables -> Shows all the available tables in sqlite3 database.
   .schema -> Shows schema for all the available tables in database.
   .dump -> Shows information about all the tables present in the database
            including all the records for each table. */
sqlite> .tables
contacts

sqlite> .schema
CREATE TABLE contacts (name text, phone integer, email text);

sqlite> .dump
PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE contacts (name text, phone integer, email text);
INSERT INTO contacts VALUES('Tim',6545678,'tim@email.com');
INSERT INTO contacts VALUES('Avril','+61 (0)87654321','avril@email.com.au');
COMMIT;


-- Use .exit ot .quit to exit/quit from the sqlite3 shell.
sqlite> .exit









/* Now, let us work on some different database.(music.db) This database is provided by
   Tim Buchalka, my Udemy course instructor for "Java Masterclass". */

D:\Learning\databases>sqlite3 music.db
SQLite version 3.28.0 2019-04-16 19:49:53
Enter ".help" for usage hints.

/* View the schema to know about all the tables available along with the
   rows and their type for each table. */
sqlite> .schema
CREATE TABLE songs (_id INTEGER PRIMARY KEY, track INTEGER, title TEXT NOT NULL, album INTEGER);
CREATE TABLE albums (_id INTEGER PRIMARY KEY, name TEXT NOT NULL, artist INTEGER);
CREATE TABLE artists (_id INTEGER PRIMARY KEY, name TEXT NOT NULL);

-- turn on header info:
.header on
-- View all records from table named artists. (Truncated output is shown here).
sqlite> SELECT * FROM artists;
_id|name
1|Mahogany Rush
2|Elf
3|Mehitabel
...
...
199|Thomas Tallis
200|Stevie Ray Vaughan
201|Chemical Brothers


-- View all records from table named albums. (Truncated output is shown here).
sqlite> SELECT * FROM albums;
_id|name|artist
1|Tales of the Crown|16
2|The Masquerade Ball|16
3|Grace|159
...
...
437|Cross Road - The Best Of|54
438|The Division Bell|130
439|Attack & Release|133

-- View all records from table named songs. (Truncated output is shown here).
sqlite> SELECT * FROM songs;
_id|track|title|album
1|2|I Can't Quit You Baby|343
2|1|Taking the Easy Way Out Again|311
3|6|Let's Have A Party|260
...
...
5348|17|Walk In My Shadow|108
5349|10|Permanent Vacation|367
5350|4|Just Walk In My Shoes (2004 Digital Remaster)|118






-- Quiz-1: Show artist whose id is 131.
sqlite> SELECT * FROM artists WHERE _id=131;
131|King Crimson


-- Quiz-2: Show 367th Album name.
sqlite> SELECT name FROM albums WHERE _id=367;
name
Permanent Vacation

-- OR
sqlite> SELECT * FROM albums WHERE _id=367;
_id|name|artist
367|Permanent Vacation|152


-- Backup our databse file now.
sqlite> .backup musicbackup.db
sqlite>







/* Ordering/Sorting of the tables, using ORDER BY
   Select all the artists and display them/order them by their name. */
sqlite> SELECT * FROM artists ORDER BY name;
_id|name|artist
11|1000 Maniacs
86|10cc
66|AC DC
152|Aerosmith
...
...
12|Wishbone Ash
148|Yardbirds
179|Yngwie Malmsteen
23|ZZ Top



-- Similarly for albums:
sqlite> SELECT * FROM albums ORDER BY name;
_id|name|artist
54|18 Singles|193
281|1984|84
372|25 Years On|28
103|4|150
288|A Saucerful Of Secrets|130
...
...
173|You Know Who You Are|3
398|Zappa In New York|140
364|Zooma|187
325|heavens to betsy|72
430|whip Jamboree|72
-- The last 2 entries came after Z, because those are in lower case.
-- To ignore case sensitivity use COLLATE NOCASE
sqlite> SELECT * FROM albums ORDER BY name COLLATE NOCASE;
_id|name|artist
54|18 Singles|193
281|1984|84
372|25 Years On|28
103|4|150
288|A Saucerful Of Secrets|130
144|A Trick Of The Tail|116
391|Aerosmith|152
...
...
347|XS All Areas|29
173|You Know Who You Are|3
398|Zappa In New York|140
364|Zooma|187


/* You can use ASC or DESC for ordering the data in Ascending or Descending
   order. */
sqlite> SELECT * FROM albums ORDER BY name COLLATE NOCASE DESC;
_id|name|artist
364|Zooma|187
398|Zappa In New York|140
173|You Know Who You Are|3
347|XS All Areas|29
...
...
144|A Trick Of The Tail|116
288|A Saucerful Of Secrets|130
103|4|150
372|25 Years On|28
281|1984|84
54|18 Singles|193


/* What if we want to group almbums with same artists together, i.e.- we want to
   order the albums first by artists and then by name? We can use ORDER BY with
   more than one column.*/
sqlite> SELECT * FROM albums ORDER BY artist, name COLLATE NOCASE;
_id|name|artist
210|Mahogany Rush IV|1
140|Mahogany Rush Live|1
227|Carolina County Ball|2
176|Trying To Burn The Sun|2
34|Demo|3
173|You Know Who You Are|3
413|Cheaper Thrills|4
...
...
76|Who Do We Think We Are Remastered Edition|196
404|The Very Best Of Marc Bolan And T. Rex|197
47|Greatest Hits|198
7|Spem In Alium|199
373|Collections|200
289|Push The Button|201
sqlite>






/*
  Challenge: List all the songs so that the songs from the same album appear
  together in track order.
*/
sqlite> SELECT * FROM songs ORDER BY album, track COLLATE NOCASE;
_id|track|title|album
2934|1|Higher|1
382|2|"Ain't Gonna Win"|1
4227|3|Angel Eyes|1
4941|4|Crossfire|1
1890|5|Touching My Soul|1
1249|6|Emotional Echoes|1
3795|7|Riding on an Arrow|1
3672|8|Tales of the Crown|1
1460|9|Buried Alive|1
4348|10|Northern Lights|1
859|1|The Arrival (intro)|2
4323|2|Earls of Black|2
1753|3|Voodoo Nights|2
33|4|Night and rain|2
3879|5|The Masquerade Ball|2
4148|6|Tear down the walls|2
3997|7|The Line|2
2827|8|Hot wheels|2
2013|9|The temple of the Holy|2
2334|10|July morning|2
3742|1|Mojo Pin|3
2154|2|Grace|3
...
...










/* SQL JOIN clause: It is used to join tables together. Keeping data normalized,
   so that tables only contain information that relates to a single thing
   (song, album or artist in our example) is a fundamental part of relational
   databases and by doing that and joining the tables back together you get a
   great deal of flexibility in how you can query and manipulate the data.

   Remember that the songs table contains a column holding the album id, and
   the albums table has an artist ID field. These are used to provide a link
   between the tables.

*/

sqlite> SELECT songs.track, songs.title, albums.name FROM songs
        JOIN albums ON songs.album=albums._id;
track|title|name
2|"I Can't Quit You Baby"|BBC Sessions
1|Taking the Easy Way Out Again|Rhinos Winos and Lunatics
6|"Let's Have A Party"|Private Practice
7|Flaming Telepaths|Champions Of Rock
11|"Yearnin'"|The Big Come Up
1|Bat Out Of Hell|Bat Out Of Hell
5|Evil Woman|Black Sabbath
7|Rat Salad|Paranoid
...
...


/*
    TODO: Read and exercise more on JOINS.
    Types of Joins: INNER JOIN, OUTER JOIN,
*/
sqlite> SELECT songs.track, songs.title, albums.name FROM songs
        INNER JOIN albums ON songs.album=albums._id;

-- If you want to sort the result you can also use ORDER BY and ASC or DESC.
sqlite> SELECT songs.track, songs.title, albums.name FROM songs
        INNER JOIN albums ON songs.album=albums._id
        ORDER BY albums.name, songs.track;

-- Same query but showing first album name.
sqlite> SELECT albums.name, songs.track, songs.title FROM songs
        INNER JOIN albums ON songs.album=albums._id
        ORDER BY albums.name, songs.track;





/* Challenge:Produce a list of all artists, with their albums, in alphabetical
   order of artist name. */
sqlite> SELECT artists.name, albums.name FROM artists
        INNER JOIN albums ON artists._id=albums.artist
        ORDER BY artists.name;


/* Now, if we want to find out which artist produced a particular song,
   it is little tricky as there is no direct link between artists and songs
   tables. But we can find it out with the help of albums table.
   ASongs table has a albums,and albums table has artist entry.
   So, we can get what we want by joining these 3 tables. */
sqlite> SELECT artists.name, albums.name, songs.track, songs.title FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        ORDER BY artists.name, albums.name, songs.track;

-- Adding where clause to above query:
sqlite> SELECT artists.name, albums.name, songs.track, songs.title FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name="Black Sabbath"
        ORDER BY artists.name, albums.name, songs.track;

sqlite> SELECT artists.name, albums.name, songs.track, songs.title FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE albums.name="Born Again"
        ORDER BY artists.name, albums.name, songs.track;

-- Combining above 2 queries using AND:
sqlite> SELECT artists.name, albums.name, songs.track, songs.title FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name="Black Sabbath" AND albums.name="Born Again"
        ORDER BY artists.name, albums.name, songs.track;

-- Creating query using OR:
sqlite> SELECT artists.name, albums.name, songs.track, songs.title FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE albums.name="Sabotage" OR albums.name="Born Again"
        ORDER BY artists.name, albums.name, songs.track;

-- Giving aliases to column name:
sqlite> SELECT artists.name AS "artist_name", albums.name AS "album_name", songs.track, songs.title FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE albums.name="Sabotage" OR albums.name="Born Again"
        ORDER BY artists.name, albums.name, songs.track;

/*
 Using wildcards search in WHERE clause.
 List all the songs where the song artists name contains word "Black".
 http://www-db.deis.unibo.it/courses/TW/DOCS/w3schools/sql/sql_wildcards.asp.html

 Note: Like is not case sensitive, but equals(=) is case sensitive.
*/

sqlite> SELECT artists.name AS "artist_name", albums.name AS "album_name",
               songs.track AS "song_track", songs.title AS "song_title" FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name LIKE "%Black%"
        -- You can use the alias name as well.
        -- WHERE artist_name LIKE "%Black%"
        ORDER BY artists.name, albums.name, songs.track;

-- Search for the artist name starting with Black:
sqlite> SELECT artists.name AS "artist_name", albums.name AS "album_name",
               songs.track AS "song_track", songs.title AS "song_title" FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name LIKE "Black%"
        -- Name starts with Black the a space then letter S and then any letters.
        -- WHERE artists.name LIKE "Black S%"
        ORDER BY artists.name, albums.name, songs.track;







-- VIEWS:
sqlite> CREATE VIEW artists_list AS
        SELECT artists.name AS "artist_name", albums.name AS "album_name",
               songs.track AS "song_track", songs.title AS "song_title" FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        ORDER BY artists.name, albums.name, songs.track;

/* Now this view has been added to the sqlite3 database as a new table.
   You can view this using .schema */
sqlite> .schema
CREATE TABLE songs (_id INTEGER PRIMARY KEY, track INTEGER, title TEXT NOT NULL, album INTEGER);
CREATE TABLE albums (_id INTEGER PRIMARY KEY, name TEXT NOT NULL, artist INTEGER);
CREATE TABLE artists (_id INTEGER PRIMARY KEY, name TEXT NOT NULL);
CREATE VIEW artists_list AS
        SELECT artists.name AS "artist_name", albums.name AS "album_name",
               songs.track AS "song_track", songs.title AS "song_title" FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        ORDER BY artists.name, albums.name, songs.track
/* artists_list(artist_name,album_name,song_track,song_title) */;


/* We can use this view as a normnal table and do same quesry operations as that
   of normal table, except inserting and deleting data. */
sqlite> SELECT * FROM artists_list WHERE name LIKE "%Black%";

-- Create one more VIEW:
sqlite> CREATE VIEW album_list AS
        SELECT name FROM albums
        ORDER BY name
        COLLATE NOCASE;









/* DELETING/REMOVING/DROPPING VIEWS AND TABLES */
sqlite> DROP TABLE table_name;

-- lets Drop our VIEW artists_list.
sqlite> DROP VIEW artists_list;
--  Now, this view will also disappear from the .schema.

/* Important Note: Deleting a view does not affect data in database,
   but deleting a table will affect. So, be very careful while deleting a table.
   It is always better to backup our database before trying to delete anything.
*/
sqlite> .backup musicbackup_v2.db;


/* Now try playing with actual tables:
   Delete all the records from songs table where track is less than 50.
*/
sqlite> DELETE FROM songs WHERE track < 50;

-- Now see the songs table:
sqlite> SELECT * FROM songs;
_id|track|title|album
198|60|Turkeys|177
912|53|My Brother Makes The Noises For The Talkies|177
1116|59|The Strain|177
1690|61|King Of Scurf|177
1994|67|Fresh Wound|177
2135|63|Straight From The Heart|177
2434|57|Mr. Apollo (Single Version) (German Version)|177
2535|50|I Want To Be With You|177
2583|68|Bad Blood|177
2621|69|Slush|177
2679|65|Rawlinson End|177
2736|54|I'm Going To Bring A Watermelon To My Girl Tonight|177
2794|66|Don't Get Me Wrong|177
3010|58|Ready Mades|177
3358|64|Rusty (Champion Thrust)|177
3618|72|Trouser Freak - Roger Ruskin Spear & His Giant Orchestral Wardrobe|177
3712|62|Waiting For The Wardrobe|177
3797|70|Labio-Dental Fricative - Vivian Stanshall Sean Head Showband|177
3959|55|Alley Oop|177
4308|52|Busted|177
4881|51|Noises For The Leg|177
4991|56|Button Up Your Overcoat|177
5256|50|Closer To You|254
5312|71|Re-Cycled Vinyl Blues - Neil Innes|177
sqlite>

/* Very few records left. Lets find out how many artists records left from our
   artist_list VIEW created earlier, which also should have changed because of
   the last delete command. */

sqlite> SELECT * FROM artists_list;
artist_name|album_name|song_track|song_title
Bonzo Dog Band|Cornology|50|I Want To Be With You
Bonzo Dog Band|Cornology|51|Noises For The Leg
Bonzo Dog Band|Cornology|52|Busted
Bonzo Dog Band|Cornology|53|My Brother Makes The Noises For The Talkies
Bonzo Dog Band|Cornology|54|"I'm Going To Bring A Watermelon To My Girl Tonight"
Bonzo Dog Band|Cornology|55|Alley Oop
Bonzo Dog Band|Cornology|56|Button Up Your Overcoat
Bonzo Dog Band|Cornology|57|Mr. Apollo (Single Version) (German Version)
Bonzo Dog Band|Cornology|58|Ready Mades
Bonzo Dog Band|Cornology|59|The Strain
Bonzo Dog Band|Cornology|60|Turkeys
Bonzo Dog Band|Cornology|61|King Of Scurf
Bonzo Dog Band|Cornology|62|Waiting For The Wardrobe
Bonzo Dog Band|Cornology|63|Straight From The Heart
Bonzo Dog Band|Cornology|64|Rusty (Champion Thrust)
Bonzo Dog Band|Cornology|65|Rawlinson End
Bonzo Dog Band|Cornology|66|"Don't Get Me Wrong"
Bonzo Dog Band|Cornology|67|Fresh Wound
Bonzo Dog Band|Cornology|68|Bad Blood
Bonzo Dog Band|Cornology|69|Slush
Bonzo Dog Band|Cornology|70|Labio-Dental Fricative - Vivian Stanshall Sean Head Showband
Bonzo Dog Band|Cornology|71|Re-Cycled Vinyl Blues - Neil Innes
Bonzo Dog Band|Cornology|72|Trouser Freak - Roger Ruskin Spear & His Giant Orchestral Wardrobe
J.J. Cale|Anyway The Wind Blows - The Anthology|50|Closer To You
sqlite>

/* We can see that only 2 artists left.
   Now, select a track which is not equal to 71.
*/
sqlite> SELECT * FROM songs WHERE track <> 71;
_id|track|title|album
198|60|Turkeys|177
912|53|My Brother Makes The Noises For The Talkies|177
1116|59|The Strain|177
1690|61|King Of Scurf|177
1994|67|Fresh Wound|177
2135|63|Straight From The Heart|177
2434|57|Mr. Apollo (Single Version) (German Version)|177
2535|50|I Want To Be With You|177
2583|68|Bad Blood|177
2621|69|Slush|177
2679|65|Rawlinson End|177
2736|54|"I'm Going To Bring A Watermelon To My Girl Tonight"|177
2794|66|"Don't Get Me Wrong"|177
3010|58|Ready Mades|177
3358|64|Rusty (Champion Thrust)|177
3618|72|Trouser Freak - Roger Ruskin Spear & His Giant Orchestral Wardrobe|177
3712|62|Waiting For The Wardrobe|177
3797|70|Labio-Dental Fricative - Vivian Stanshall Sean Head Showband|177
3959|55|Alley Oop|177
4308|52|Busted|177
4881|51|Noises For The Leg|177
4991|56|Button Up Your Overcoat|177
5256|50|Closer To You|254
sqlite>









/* We can use SQL functions in our query. The in-built functions include-
   COUNT, AVG. MIN, MAX, etc.
*/
sqlite> SELECT COUNT(*) FROM songs;
COUNT(*)
24
sqlite> SELECT COUNT(*) FROM albums;
COUNT(*)
439
sqlite> SELECT COUNT(*) FROM artists;
COUNT(*)
202
sqlite>


/* Let's restore our database and see how many entries we have got there. */
sqlite> .restore musicbackup_v2.db
sqlite> SELECT COUNT(*) FROM songs;
COUNT(*)
5350
sqlite> SELECT COUNT(*) FROM albums;
COUNT(*)
439
sqlite> SELECT COUNT(*) FROM artists;
COUNT(*)
202
sqlite>















/* Challenges:
      1. Select the titles of all the songs on the album "Forbidden".
      2. Repeat the previous query, but this time display the song in the track
         order. You may want to include the track number in the output to verify
         that it worked OK.
      3. Display all songs for the band "Deep Purple".
      4. Rename the band "Mehitabel" to "One Kitchen". Note that this is an
         exception to the advice to always fully qualify your column names.
         SET artists.name won't work, you just need to specify name.
      5. Check the record was correctly renamed.
      6. Select the titles of all the songs by Aerosmith in alphabetical order.
         Include only the title in the output.
      7. Replace the column that you used in the previous answer with
         count(title) to get just a count of the number of songs.
      8. Search the Internet to find out how to get a list of the songs from
         step 6 without any duplicates.
      9. Search the Internet again to find out how to get a count of the songs
         without duplicates.
         Hint: It uses the same keyword as step 8 but the syntax may not be
         obvious.
     10. Repeat the previous the query to find the number of artists
         (which, obviously, should be one) and the number of albums.
*/


/* My Solutions:
   Before solving the solution it is important to know the schema of all the
   available tables.
*/
D:\Learning\databases\RDBMS\SQLite>sqlite3 music.db
SQLite version 3.28.0 2019-04-16 19:49:53
Enter ".help" for usage hints.
sqlite> .schema
CREATE TABLE songs (_id INTEGER PRIMARY KEY, track INTEGER, title TEXT NOT NULL, album INTEGER);
CREATE TABLE albums (_id INTEGER PRIMARY KEY, name TEXT NOT NULL, artist INTEGER);
CREATE TABLE artists (_id INTEGER PRIMARY KEY, name TEXT NOT NULL);
CREATE VIEW artists_list AS
        SELECT artists.name AS "artist_name", albums.name AS "album_name",
               songs.track AS "song_track", songs.title AS "song_title" FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        ORDER BY artists.name, albums.name, songs.track
/* artists_list(artist_name,album_name,song_track,song_title) */;
sqlite>

-- Now, go ahead and try to solve the challenges:

-- 1. Select the titles of all the songs on the album "Forbidden".
sqlite> SELECT songs.title AS song_title/*, albums.name AS album_name*/
        FROM songs
        INNER JOIN albums ON songs.album=albums._id
        WHERE albums.name="Forbidden";
song_title
The Illusion of Power
Sick and Tired
Can't Get Close Enough
Forbidden
Shaking Off the Chains
Get a Grip
Kiss of Death
Guilty as Hell
Rusty Angels
I Won't Cry for You
sqlite>



/* 2. Repeat the previous query, but this time display the song in the track
      order. You may want to include the track number in the output to verify
      that it worked OK.
*/
sqlite> SELECT songs.track AS song_track, songs.title AS song_title
        FROM songs
        INNER JOIN albums ON songs.album=albums._id
        WHERE albums.name="Forbidden"
        ORDER BY songs.track;
song_track|song_title
1|The Illusion of Power
2|Get a Grip
3|Can't Get Close Enough
4|Shaking Off the Chains
5|I Won't Cry for You
6|Guilty as Hell
7|Sick and Tired
8|Rusty Angels
9|Forbidden
10|Kiss of Death


-- 3. Display all songs for the band "Deep Purple".
sqlite> SELECT songs.title AS song_title/*, artists.name AS artist_name*/
        FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name="Deep Purple";
/*song_title
Love Help Me (2000 Digital Remaster)
Might Just Take Your Life
And The Address (2000 Digital Remaster)
Fireball (Take 1 - Instrumental)
Maybe I'm a Leo
Fireball
No One Came
Mistreated
Smoke On The Water
Mary Long
Rat Bat Blue
What's Goin' On Here
I Need Love
Studio Chat
Hush
Shield
April (2000 Digital Remaster)
Wring That Neck
When a Blind Man Cries (B-Side)
Bird Has Flown (2000 Digital Remaster)
Highway Star
Pictures Of Home
Fools
Lazy
Smoke On The Water
You Fool No One
Speed King (Piano Version)
Black Night
Slow Train (Album Outtake)
Dealer
Mistreated
Pictures of Home
Space Truckin'
Our Lady ('99 Remix)
Child In Time
The Painter (2000 Digital Remaster)
Lady Luck
Sail Away
Bloodsucker
Painted Horse (studio out-take)
Prelude_ Happiness_I'm So Glad (Medley) (2000 Digital R
Woman From Tokyo ('99 Remix)
Black Night (Unedited Roger Glover Remix)
Hey Joe (BBC Top Gear Session)
Help (Alternate Take)
Listen Learn Read On
Love Don't Mean A Thing
I'm Alone (B-Side)
Burn
Space Truckin'
The Painter (BBC Radio Session)
Studio Chat
High Ball Shooter
Woman From Tokyo
You Fool No One
Studio Chat
The Bird Has Flown (Alternate A-Side Version) (1998 Dig
Third Movement- Vivace - Presto
Woman From Tokyo (alt.bridge)
River Deep Mountain High
Living Wreck
Shadows
Rat Bat Blue (writing session)
Studio Chat
'A' 200
Studio Chat
Jam Stew (Unreleased Instrumental)
Drifter
Lady Double Dealer
Super Trouper
No One Came (Remix 1996)
Exposition - We Can Work It Out
Lalena (2000 Digital Remaster)
Speed King
Lay Down Stay Down
Into The Fire
Flight Of The Rat (Roger Glover Remix)
Strange Kind Of Woman (A-Side Remix 1996)
You Can't Do It Right
Lalena (BBC Radio Session)
The Mule (Drum Solo)
Emmaretta (1998 Digital Remaster)
Backwards Piano
Lazy (Quadrophonic Mix)
No No No
Speed King
Black Night (Original Single Version)
Hey Joe (2000 Digital Remaster)
Smooth Dancer
Love Child
The Gypsy
Lazy
Anyone's Daughter
First Day Jam (instrumental)
The Noise Abatement Society Tapes
One More Rainy Day (2000 Digital Remaster)
Stormbringer
First Movement- Moderato - Allegro
Child In Time
Lady Double Dealer
Never Before
Demon's Eye (Remix 1996)
Wring That Neck
Fault Line (2000 Digital Remaster)
You Keep On Moving
Strange Kind Of Woman
It's All Over (BBC Top Gear Session Bonus Track)
Second Movement- Andante
Child In Time
Cry Free (Roger Glover Remix)
Hey Bop A Re Bop (BBC Top Gear Session Bonus Track)
Freedom (Album Outtake)
Why Didn't Rosemary_ (1999 Digital Remaster)
Place In Line
Maybe I'm a Leo (Quadrophonic Mix)
Studio Chat
Rat Bat Blue ('99 Remix)
Wring That Neck (BBC Top Gear Session Bonus Track)
Encore- Third Movement- Vivace - Presto (Part)
Love Help Me (Instrumental Version)
Flight Of The Rat
Playground (Remixed Instrumental Studio Out Take Bonus Track)
[Intro]
Smoke On The Water
Gettin' Tighter
Demon's Eye
Maybe I'm A Leo
Stormbringer
When A Blind Man Cries
Speed King (Roger Glover Remix)
Anthem
Oh No No No (Studio Out Take Bonus Track)
Burn
Soldier Of Fortune
This Time Around Owed To 'G' (Instrumental)
Hush (Live US TV)
Lazy
Mandrake Root (1998 Digital Remaster)
Comin' Home
Hold On
Highway Star
Kentucky Woman
Hush (1998 Digital Remaster)
Highway Star
Blind (2000 Digital Remaster)
Our Lady
Never Before
Hard Lovin' Man
Holy Man
Emmaretta (BBC Top Gear Session)
Help (2000 Digital Remaster)
Chasing Shadows (2000 Digital Remaster)
The Mule
Lucille
Space Truckin'
*/



-- Alternatively we can use created VIEW artist_list for this purpose.
sqlite> SELECT song_title FROM artists_list WHERE artist_name="Deep Purple";
-- Output:
/*
song_title
Burn
Might Just Take Your Life
Lay Down Stay Down
Sail Away
You Fool No One
What's Goin' On Here
Mistreated
'A' 200
Comin' Home
Lady Luck
Gettin' Tighter
Dealer
I Need Love
Drifter
Love Child
This Time Around Owed To 'G' (Instrumental)
You Keep On Moving
[Intro]
Hush
Wring That Neck
Child In Time
First Movement- Moderato - Allegro
Second Movement- Andante
Third Movement- Vivace - Presto
Encore- Third Movement- Vivace - Presto (Part)
Chasing Shadows (2000 Digital Remaster)
Blind (2000 Digital Remaster)
Lalena (2000 Digital Remaster)
Fault Line (2000 Digital Remaster)
The Painter (2000 Digital Remaster)
Why Didn't Rosemary_ (1999 Digital Remaster)
Bird Has Flown (2000 Digital Remaster)
April (2000 Digital Remaster)
The Bird Has Flown (Alternate A-Side Version) (1998 Dig
Emmaretta (1998 Digital Remaster)
Emmaretta (BBC Top Gear Session)
Lalena (BBC Radio Session)
The Painter (BBC Radio Session)
Speed King
Bloodsucker
Child In Time
Flight Of The Rat
Into The Fire
Living Wreck
Hard Lovin' Man
Black Night (Original Single Version)
Studio Chat
Speed King (Piano Version)
Studio Chat
Cry Free (Roger Glover Remix)
Studio Chat
Jam Stew (Unreleased Instrumental)
Studio Chat
Flight Of The Rat (Roger Glover Remix)
Studio Chat
Speed King (Roger Glover Remix)
Studio Chat
Black Night (Unedited Roger Glover Remix)
Fireball
No No No
Demon's Eye
Anyone's Daughter
The Mule
Fools
No One Came
Strange Kind Of Woman (A-Side Remix 1996)
I'm Alone (B-Side)
Freedom (Album Outtake)
Slow Train (Album Outtake)
Demon's Eye (Remix 1996)
The Noise Abatement Society Tapes
Fireball (Take 1 - Instrumental)
Backwards Piano
No One Came (Remix 1996)
Highway Star
Maybe I'm A Leo
Pictures Of Home
Never Before
Smoke On The Water
Lazy
Space Truckin'
When A Blind Man Cries
Highway Star
Maybe I'm a Leo
Pictures of Home
Never Before
Smoke On The Water
Lazy
Space Truckin'
When a Blind Man Cries (B-Side)
Maybe I'm a Leo (Quadrophonic Mix)
Lazy (Quadrophonic Mix)
Burn
Mistreated
Lady Double Dealer
You Fool No One
Stormbringer
Highway Star
Child In Time
Smoke On The Water
The Mule (Drum Solo)
Strange Kind Of Woman
Lazy
Space Truckin'
Black Night
Speed King
Lucille
And The Address (2000 Digital Remaster)
Hush (1998 Digital Remaster)
One More Rainy Day (2000 Digital Remaster)
Prelude_ Happiness_I'm So Glad (Medley) (2000 Digital R
Mandrake Root (1998 Digital Remaster)
Help (2000 Digital Remaster)
Love Help Me (2000 Digital Remaster)
Hey Joe (2000 Digital Remaster)
Shadows
Love Help Me (Instrumental Version)
Help (Alternate Take)
Hey Joe (BBC Top Gear Session)
Hush (Live US TV)
Stormbringer
Love Don't Mean A Thing
Holy Man
Hold On
Lady Double Dealer
You Can't Do It Right
High Ball Shooter
The Gypsy
Soldier Of Fortune
Listen Learn Read On
Wring That Neck
Kentucky Woman
Exposition - We Can Work It Out
Shield
Anthem
River Deep Mountain High
Oh No No No (Studio Out Take Bonus Track)
It's All Over (BBC Top Gear Session Bonus Track)
Hey Bop A Re Bop (BBC Top Gear Session Bonus Track)
Wring That Neck (BBC Top Gear Session Bonus Track)
Playground (Remixed Instrumental Studio Out Take Bonus Track)
Woman From Tokyo
Mary Long
Super Trouper
Smooth Dancer
Rat Bat Blue
Place In Line
Our Lady
Woman From Tokyo ('99 Remix)
Woman From Tokyo (alt.bridge)
Painted Horse (studio out-take)
Our Lady ('99 Remix)
Rat Bat Blue (writing session)
Rat Bat Blue ('99 Remix)
First Day Jam (instrumental)
*/


/*
  4. Rename the band "Mehitabel" to "One Kitchen". Note that this is an
     exception to the advice to always fully qualify your column names.
     SET artists.name won't work, you just need to specify name.
*/
sqlite> UPDATE artists
        SET name="One Kitchen"
        WHERE artists.name="Mehitabel";


-- 5. Check the record was correctly renamed.
sqlite> SELECT artists.name FROM artists
        WHERE artists.name="Mehitabel" OR artists.name="One Kitchen";
/* We should see only one entry for "One Kitchen" and
  zero entries for "Mehitabel". */


/*
  6. Select the titles of all the songs by Aerosmith in alphabetical order.
     Include only the title in the output.
*/
sqlite> SELECT songs.title AS song_title
        FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name="Aerosmith"
        ORDER BY songs.title;


-- Alternatively by using VIEW:
sqlite> SELECT song_title FROM artists_list
        WHERE artist_name="Aerosmith"
        ORDER BY song_title;

-- Output:
/*
song_title
(Dulcimer Stomp) The Other Side
(Going Down) Love In An Elevator
(Hoodoo) Voodoo Medicine Man
(Water Song) Janie's Got A Gun
Adam's Apple
Adam's Apple
Ain't That A Bitch
Amazing
Amazing
Angel
Angel
Attitude Adjustment
Avant Garden
Back In The Saddle
Beyond Beautiful
Big Ten Inch Record
Blind Man
Bone To Bone (Coney Island White Fish Boy)
Boogie Man
Can't Stop Messin'
Cheese Cake
Chip Away The Stone
Chip Away The Stone
Chiquita
Come Together
Crash
Crazy
Crazy
Critical Mass
Cryin'
Cryin'
Darkness
Deuces Are Wild
Don't Get Mad Get Even
Dream On
Dream On
Drop Dead Gorgeous
Dude (Looks Like A Lady)
Dude (Looks Like A Lady)
Dude (Looks Like A Lady)- live
Eat The Rich
Eat The Rich
F.I.N.E.
Face
Fallen Angels
Falling In Love (Is Hard On The Knees)
Falling Off
Fever
Flesh
Fly Away From Here
Full Circle
Get A Grip
Girl Keeps Coming Apart
Gotta Love It
Gypsy Boots
Hangman Jury
Heart's Done Time
Hole In My Soul
I Ain't Got You
I'm Down
Intro
Jaded
Jailbait
Janie's Got A Gun
Just Push Play
Kiss Your Past Good-Bye
Last Child
Let The Music do the Talking
Lick and a Promise
Light Inside
Line Up
Livin' On The Edge
Livin' On The Edge
Lord Of The Thighs
Lord Of The Thighs
Lord Of The Thighs
Love In An Elevator
Luv Lies
Magic Touch
Make It
Mama Kin
Mama Kin
Mama Kin
Mia
Monkey On My Back
Mother Popcorn Draw The Line
Movin' Out
My Fist Your Face
My Girl
Nine Lives
No More No More
No Surprize
No Surprize
Nobody's Fault
One Way Street
Outta Your Head
Pandora's Box
Permanent Vacation
Pink
Rag Doll
Rag Doll
Rats in the Cellar
Reefer Head Woman
Remember (Walking In The Sand)
Round And Round
Round And Round
S.O.S.
S.O.S. (Too Bad)
Same Old Song And Dance
Seasons Of Wither
Shame On You
She's On Fire
Shela
Shut Up And Dance
Sick As A Dog
Sight For Sore Eyes
Simoriah
Somebody
Something's Gotta Give
Spaced
St. John
Sunshine
Sweet Emotion
Sweet Emotion
Taste Of India
The Farm
The Movie
The Other Side
The Reason A dog
The hop
Think About It
Three Mile Smile
Toys In The Attic
Toys In The Attic
Train Kept A Rollin'
Train Kept A Rollin'
Train Kept A Rollin'
Trip Hoppin'
Uncle Salty
Under My Skin
Walk On Down
Walk On Water
Walk This Way
Walk This Way
Walkin' The Dog
What It Takes
What It Takes
Woman Of The World
Write Me
You See Me Crying
Young Lust
*/


/*
    7. Replace the column that you used in the previous answer with
       count(title) to get just a count of the number of songs.
*/
sqlite> SELECT COUNT(songs.title)
        FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name="Aerosmith";

-- Alternatively with VIEW:
sqlite> SELECT COUNT(song_title) FROM artists_list
        WHERE artist_name="Aerosmith";
-- Output:
COUNT(songs.title)
151
-- Output with VIEW
COUNT(song_title)
151



/*  8. Search the Internet to find out how to get a list of the songs from
       step 6 without any duplicates.
*/
sqlite> SELECT DISTINCT songs.title
        FROM songs
        INNER JOIN albums ON songs.album=albums._id
        INNER JOIN artists ON albums.artist=artists._id
        WHERE artists.name="Aerosmith"
        ORDER BY songs.title;

-- Alternatively Using VIEW
sqlite> SELECT DISTINCT song_title FROM artists_list
        WHERE artist_name="Aerosmith"
        ORDER BY song_title;
-- Output:
/*
title
(Dulcimer Stomp) The Other Side
(Going Down) Love In An Elevator
(Hoodoo) Voodoo Medicine Man
(Water Song) Janie's Got A Gun
Adam's Apple
Ain't That A Bitch
Amazing
Angel
Attitude Adjustment
Avant Garden
Back In The Saddle
Beyond Beautiful
Big Ten Inch Record
Blind Man
Bone To Bone (Coney Island White Fish Boy)
Boogie Man
Can't Stop Messin'
Cheese Cake
Chip Away The Stone
Chiquita
Come Together
Crash
Crazy
Critical Mass
Cryin'
Darkness
Deuces Are Wild
Don't Get Mad Get Even
Dream On
Drop Dead Gorgeous
Dude (Looks Like A Lady)
Dude (Looks Like A Lady)- live
Eat The Rich
F.I.N.E.
Face
Fallen Angels
Falling In Love (Is Hard On The Knees)
Falling Off
Fever
Flesh
Fly Away From Here
Full Circle
Get A Grip
Girl Keeps Coming Apart
Gotta Love It
Gypsy Boots
Hangman Jury
Heart's Done Time
Hole In My Soul
I Ain't Got You
I'm Down
Intro
Jaded
Jailbait
Janie's Got A Gun
Just Push Play
Kiss Your Past Good-Bye
Last Child
Let The Music do the Talking
Lick and a Promise
Light Inside
Line Up
Livin' On The Edge
Lord Of The Thighs
Love In An Elevator
Luv Lies
Magic Touch
Make It
Mama Kin
Mia
Monkey On My Back
Mother Popcorn Draw The Line
Movin' Out
My Fist Your Face
My Girl
Nine Lives
No More No More
No Surprize
Nobody's Fault
One Way Street
Outta Your Head
Pandora's Box
Permanent Vacation
Pink
Rag Doll
Rats in the Cellar
Reefer Head Woman
Remember (Walking In The Sand)
Round And Round
S.O.S.
S.O.S. (Too Bad)
Same Old Song And Dance
Seasons Of Wither
Shame On You
She's On Fire
Shela
Shut Up And Dance
Sick As A Dog
Sight For Sore Eyes
Simoriah
Somebody
Something's Gotta Give
Spaced
St. John
Sunshine
Sweet Emotion
Taste Of India
The Farm
The Movie
The Other Side
The Reason A dog
The hop
Think About It
Three Mile Smile
Toys In The Attic
Train Kept A Rollin'
Trip Hoppin'
Uncle Salty
Under My Skin
Walk On Down
Walk On Water
Walk This Way
Walkin' The Dog
What It Takes
Woman Of The World
Write Me
You See Me Crying
Young Lust
*/


/*
  9. Search the Internet again to find out how to get a count of the songs
     without duplicates.
     Hint: It uses the same keyword as step 8 but the syntax may not be obvious.
*/
-- let us get first count of all songs, just to compare it later.
sqlite> SELECT COUNT(songs.title) FROM songs;
-- Output:
COUNT(songs.title)
5350

-- Now, get the count of songs without duplicates.
sqlite> SELECT COUNT(DISTINCT songs.title) FROM songs;
-- Output:
COUNT(DISTINCT songs.title)
4894



/*
  Repeat challenge 9 for artists "Aerosmith", this is as per the videO from Tim
  in the course:
  We use create VIEW named artists_list here.
*/
-- let us get first count of all songs, just to compare it later.
sqlite> SELECT COUNT(DISTINCT song_title)
        FROM artists_list
        WHERE artist_name="Aerosmith";

-- Output:
COUNT(song_title)
151

-- Now, get the count of songs without duplicates.
sqlite> SELECT COUNT(DISTINCT song_title)
        FROM artists_list
        WHERE artist_name="Aerosmith";

-- Output:
COUNT(DISTINCT song_title)
128






/* 10. Repeat the previous query to find the number of artists
       (which, obviously, should be one) and the number of albums.
*/
-- Total Number of artists:
sqlite> SELECT COUNT(DISTINCT artists.name) FROM artists;
-- Output:
COUNT(DISTINCT artists.name)
202

-- Total Number of albums:
sqlite> SELECT COUNT(DISTINCT albums.name) FROM albums;
-- Output:
COUNT(DISTINCT albums.name)
433


-- Below 2 are the actual challenges:

-- Distinct artists named Aerosmith.
sqlite> SELECT COUNT(DISTINCT artist_name)
        FROM artists_list
        WHERE artist_name="Aerosmith";

-- Output:
COUNT(DISTINCT artist_name)
1


-- Distinct number of albums from artists named Aerosmith.
sqlite> SELECT COUNT(DISTINCT album_name)
        FROM artists_list
        WHERE artist_name="Aerosmith";

-- Output:
COUNT(DISTINCT album_name)
13
