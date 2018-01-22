DROP TABLE IF EXISTS Clubs;
CREATE TABLE Clubs (
	`name`	TEXT,
	`uniqueID`	INTEGER,
	`Description`	TEXT,
	`Advisor`	TEXT,
	`Meetings`	TEXT,
	`Contact`	TEXT,
	`Events`	TEXT,
	`Results`	TEXT,
	`Picture`	TEXT
);
INSERT INTO Clubs VALUES('FBLA',1,'The Future Business Leaders of America, or FBLA for short, is a prestigious club at South Forsyth High School that focuses on preparing young students for the corporate world by teaching them to be leaders in everything that they do. 
','Mr. James O''Connor
 Mrs.Carla Yonk
','Every Thursday afterschool in room 135
','Joconnor@forsyth.k12.ga.us
','1,2,3','None','http://upload.wikimedia.org/wikipedia/en/2/28/FBLA_PBL_Logo.png');
INSERT INTO Clubs VALUES('TSA',2,'Technology Student Association, or TSA for short, is one of the largest clubs in South Forsyth High School. The main purpose of TSA is to introduce students to the growing field of work that technology is creating, and to inspire them to partake in this field themselves. ','Mr. Nick Crowder
','Every Tuesday, Wednesday, and Thursday afterschool in room 470
','ncrowder@forsyth.k12.ga.us','4,5','None','http://upload.wikimedia.org/wikipedia/en/thumb/9/96/Technology_Student_Association_Emblem.svg/1280px-Technology_Student_Association_Emblem.svg.png');
DROP TABLE IF EXISTS EventList;
CREATE TABLE EventList (
	`uniqueID`	INTEGER,
	`name`	TEXT,
	`desc`	TEXT,
	`founder`	TEXT,
	`date`	TEXT,
	`timeStart`	TEXT,
	`timeEnd`	TEXT,
	`address`	TEXT,
	`club`	TEXT,
	`results`	TEXT,
	`imageLink`	TEXT,
	`ExtraInfo`	TEXT
);
INSERT INTO EventList VALUES(1,'Regional Leadership Conference','The Regional Leadership Conference is a conference that is held annually in the local chapter region. This Conference decides who progresses to the State level of FBLA competition. Although not all events compete at the Regional level, those that do need to make an appearance here in order to possibly qualify for State.','Harish Kamath','2/19/2015','9:00 AM','4:00 PM','2525 Mulberry St, Cumming, GA, 30041','FBLA','Winners - 
Harish Kamath(Mobile Application Development) 
Bldkdskafdlkdfld(dfkslfls)','http://www.civilrights.org/images/templates/leadership-logo.png','f');
INSERT INTO EventList VALUES(2,'State Leadership Conference','The State Leadership Conference is the next step of FBLA competition, on the way to Nationals. Those who compete here are fighting for the prize of being able to compete at the National Level for FBLA. All Events are required to compete at this level in order to continue onto Nationals.','Harish Kamath','3/26/2015','9:00 AM','4:00 PM','4193 Accessory Rd, Athens, GA, 30051','FBLA','Winners -
Harish Kamath: Mobile Application Development.
KLFdsfl: fdsjklfjdskl.','http://www.civilrights.org/images/templates/leadership-logo.png','fs');
INSERT INTO EventList VALUES(3,'National Leadership Conference','The National Leadership Conference is the ultimate competition for all FBLA members. Being held in Chicago, IL this year, the NLC is host to the best students of the USA. In order to qualify for NLC, you must be one of the top 3 performers at your State Leadership Conference. Many awards, such as cash prizes and scholarships, can be found here.
','Harish Kamath
','7/22/2015','9:00 AM

','4:00 PM
','3940 Atlanta Ave, Chicago, IL, 39401
','FBLA','Winners-
Harish Kamath - Mobile Application Development
fdslfjdsf - fjdskfjdskfds','http://www.civilrights.org/images/templates/leadership-logo.png','fdsaf');
INSERT INTO EventList VALUES(4,'State Leadership Conference
','The State Leadership Conference is the next step of TSA competition, on the way to Nationals. Those who compete here are fighting for the prize of being able to compete at the National Level for TSA. All Events are required to compete at this level in order to continue onto Nationals.','Harish Kamath
','3/26/2015','9:00 AM
','4:00 PM','3819 Fjeke Road, Athens, GA, 30042
','TSA','Winners -
 Harish Kamath: Mobile Application Development. 
KLFdsfl: fdsjklfjdskl.','http://www.civilrights.org/images/templates/leadership-logo.png','fdaf');
INSERT INTO EventList VALUES(5,'National Leadership Conference
','The National Leadership Conference is the ultimate competition for all TSA members. Being held in Chicago, IL this year, the NLC is host to the best students of the USA. In order to qualify for NLC, you must be one of the top 3 performers at your State Leadership Conference. Many awards, such as cash prizes and scholarships, can be found here.
','Harish Kamath
','7/22/2015','9:00 AM','4:00 PM','4298 Tjls Road, Chicago, IL, 20318','TSA','Winners -
 Harish Kamath: Mobile Application Development. 
KLFdsfl: fdsjklfjdskl.','http://www.civilrights.org/images/templates/leadership-logo.png','rew');
DROP TABLE IF EXISTS Results;
CREATE TABLE Results (
	`Result`	TEXT,
	`eventIndex`	INTEGER,
	`Club`	INTEGER
);
INSERT INTO Results VALUES('Winners -\n Harish Kamath(Mobile Application Development)\nBldkdskafdlkdfld(dfkslfls)\n',1,'FBLA');
INSERT INTO Results VALUES('Winners -\n Harish Kamath(Mobile Application Development)\nBldkdskafdlkdfld(dfkslfls)\n
',2,'FBLA');
INSERT INTO Results VALUES('Winners -\n Harish Kamath(Mobile Application Development)\nBldkdskafdlkdfld(dfkslfls)\n',3,'FBLA');
INSERT INTO Results VALUES('Winners -\n Harish Kamath(Mobile Application Development)\nBldkdskafdlkdfld(dfkslfls)\n',4,'TSA');
INSERT INTO Results VALUES('Winners -\n Harish Kamath(Mobile Application Development)\nBldkdskafdlkdfld(dfkslfls)\n',5,'TSA');
DROP TABLE IF EXISTS Videos;
CREATE TABLE `Videos` (
	`videoName`	TEXT,
	`videoLink`	TEXT,
	`Club`	TEXT,
	`eventIndex`	INTEGER
);
