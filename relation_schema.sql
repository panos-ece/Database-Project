CREATE TABLE Ομάδα_Μηχανικών ( 
	Έξοδα	REAL,
	Κωδ_Ομάδας	INTEGER	NOT NULL,
	Τομέας	CHAR(20),
	Αρ_ατόμων	INTEGER,
	FK1_Κωδ_Αγωνιστικού	INTEGER	NOT NULL,
PRIMARY KEY (Κωδ_Ομάδας) );

CREATE TABLE Πίστα ( 
	Κόστος_Εν	REAL,
	Συντ_δυσκολίας	INTEGER,
	Πόλη	CHAR(20),
	Κωδ_Πίστας	INTEGER	NOT NULL,
PRIMARY KEY (Κωδ_Πίστας) );

CREATE TABLE Αγωνιστικό_Αυτοκίνητο ( 
	Κωδ_Αγωνιστικού	INTEGER	NOT NULL,
	Κόστος	REAL,
	Έτος	INTEGER,
	Μέγιστη_ταχ	INTEGER,
	FK1_Κωδ_Εργοστασίου	INTEGER	NOT NULL,
PRIMARY KEY (Κωδ_Αγωνιστικού) );

CREATE TABLE Εργοστάσιο ( 
	Πόλη	CHAR(20),
	Τ_μ	REAL,
	Πλήθος_Εργ	INTEGER,
	Κωδ_Εργοστασίου	INTEGER	NOT NULL,
PRIMARY KEY (Κωδ_Εργοστασίου) );

CREATE TABLE Εργαζόμενος ( 
	Ονοματεπώνυμο	CHAR(30),
	Ηλικιία	INTEGER,
	Αρ_τηλ	CHAR(10),
	Κωδ_Εργαζομένου	INTEGER	NOT NULL,
	FK1_Κωδ_Εργοστασίου	INTEGER	NOT NULL,
PRIMARY KEY (Κωδ_Εργαζομένου, FK1_Κωδ_Εργοστασίου) );

CREATE TABLE Test_drive ( 
	Καιρικές_συνθήκες	CHAR(15),
	Ημ_έναρξης	DATE,
	Ημ_λήξης	DATE,
	FK1_Κωδ_Ομάδας	INTEGER	NOT NULL,
	FK2_Κωδ_Πίστας	INTEGER	NOT NULL,
	FK3_Κωδ_Αγωνιστικού	INTEGER	NOT NULL,
PRIMARY KEY (FK1_Κωδ_Ομάδας, FK2_Κωδ_Πίστας, FK3_Κωδ_Αγωνιστικού) );

ALTER TABLE Ομάδα_Μηχανικών ADD FOREIGN KEY (FK1_Κωδ_Αγωνιστικού) REFERENCES Αγωνιστικό_Αυτοκίνητο (Κωδ_Αγωνιστικού) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Αγωνιστικό_Αυτοκίνητο ADD FOREIGN KEY (FK1_Κωδ_Εργοστασίου) REFERENCES Εργοστάσιο (Κωδ_Εργοστασίου) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Εργαζόμενος ADD FOREIGN KEY (FK1_Κωδ_Εργοστασίου) REFERENCES Εργοστάσιο (Κωδ_Εργοστασίου) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Test_drive ADD FOREIGN KEY (FK1_Κωδ_Ομάδας) REFERENCES Ομάδα_Μηχανικών (Κωδ_Ομάδας) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Test_drive ADD FOREIGN KEY (FK2_Κωδ_Πίστας) REFERENCES Πίστα (Κωδ_Πίστας) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Test_drive ADD FOREIGN KEY (FK3_Κωδ_Αγωνιστικού) REFERENCES Αγωνιστικό_Αυτοκίνητο (Κωδ_Αγωνιστικού) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE  VIEW Πίστες_Με_Δυσκολία_Μεγαλύτερης_Του_3 (Κωδ_Πίστας, Πόλη, Συντ_δυσκολίας) 
	AS SELECT Π.Κωδ_Πίστας, Π.Πόλη, Π.Συντ_δυσκολίας
	   FROM Πίστα Π
	   WHERE Π.Συντ_δυσκολίας > 3;


CREATE  VIEW Πόλη_και_Καιρικές_Συνθήκες_Πίστας (Πόλη, Καιρικές_συνθήκες)
        AS SELECT Π.Πόλη, T.Καιρικές_συνθήκες
	   FROM Πίστα Π NATURAL JOIN Test_drive T;


CREATE  VIEW Κωδ_Ομάδας_Σχεδίασμου_Μοντέλου(Κωδ_Ομάδας, Κωδ_Αγωνιστικού, Έτος)
	AS SELECT Ο.Κωδ_Ομάδας, Α.Κωδ_Αγωνιστικού, Α.Έτος
	   FROM Ομάδα_Μηχανικών Ο NATURAL JOIN Αγωνιστικό_Αυτοκίνητο Α
	   WHERE Α.Μέγιστη_ταχ > 250 AND Α.Έτος > 2003;

CREATE UNIQUE INDEX Αγωνιστικό
ON Αγωνιστικό_Αυτοκίνητο(Κωδ_Αγωνιστικού, Έτος, Μέγιστη_ταχ);

CREATE UNIQUE INDEX Μηχανικοί
ON Ομάδα_Μηχανικών(Κωδ_Ομάδας, Τομέας);

