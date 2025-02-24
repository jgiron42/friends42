CREATE TABLE IF NOT EXISTS USERS
(
	id                  INTEGER PRIMARY KEY,
	name                VARCHAR(12) UNIQUE,
	image               VARCHAR(100),
	image_medium        VARCHAR(100),
	pool                VARCHAR(100),
	lang                VARCHAR(3) DEFAULT 'fr',
	active              TIMESTAMP  DEFAULT 0,
	last_wifi_activity  TIMESTAMP  DEFAULT '1970-01-01 00:00:00',
	campus              INTEGER    DEFAULT 1,
    ip_tracking         BOOL       DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS COOKIES
(
	id       INTEGER PRIMARY KEY AUTOINCREMENT,
	userid   INTEGER,
	uuid     VARCHAR(65) UNIQUE,
	name     VARCHAR(40) DEFAULT NULL,
	creation TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (userid) REFERENCES USERS (id)
);

CREATE TABLE IF NOT EXISTS FRIENDS
(
	id       INTEGER PRIMARY KEY AUTOINCREMENT,
	who      INTEGER,
	has      INTEGER,
	relation INTEGER DEFAULT 0,
	UNIQUE (who, has),
	FOREIGN KEY (who) REFERENCES USERS (id),
	FOREIGN KEY (has) REFERENCES USERS (id)
);

CREATE TABLE IF NOT EXISTS DEAD_PC
(
	id      INTEGER PRIMARY KEY AUTOINCREMENT,
	issuer  INTEGER,
	station VARCHAR(8),
	issue   INTEGER,
	solved  INTEGER   DEFAULT 0,
	since   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (issuer, station),
	FOREIGN KEY (issuer) REFERENCES USERS (id)
);

CREATE TABLE IF NOT EXISTS PROFILES
(
	userid  INTEGER PRIMARY KEY REFERENCES USERS (id),
	website TEXT        DEFAULT '',
	github  TEXT        DEFAULT '',
	discord VARCHAR(40) DEFAULT '',
	recit   TEXT        DEFAULT ''
);

CREATE TABLE IF NOT EXISTS BAN_LIST
(
	id     INTEGER PRIMARY KEY AUTOINCREMENT,
	userid INTEGER,
	reason TEXT,
	since  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (userid) REFERENCES USERS (id)
);

CREATE TABLE IF NOT EXISTS NOTIFICATIONS_TELEGRAM
(
	userid      INTEGER PRIMARY KEY,
	telegram_id INTEGER,
	message     TEXT    DEFAULT NULL,
	enabled     INTEGER DEFAULT 1,
	FOREIGN KEY (userid) REFERENCES USERS (id)
);

CREATE TABLE IF NOT EXISTS THEME
(
	userid     INTEGER PRIMARY KEY,
	javascript TEXT    DEFAULT NULL,
	css        TEXT    DEFAULT NULL,
	enabled    INTEGER DEFAULT 0,
	FOREIGN KEY (userid) REFERENCES USERS (id)
);

CREATE TABLE IF NOT EXISTS MATES
(
	id             INTEGER PRIMARY KEY AUTOINCREMENT,
	project        TEXT,
	created        DATETIME DEFAULT CURRENT_TIMESTAMP,
	creator_id     INTEGER,
	campus         INTEGER,
	people         INTEGER,
	deadline       TEXT     DEFAULT NULL,
	progress       INTEGER  DEFAULT 0,
	quick_contacts TEXT,
	mates          TEXT,
	description    TEXT,
	contact        TEXT,
	UNIQUE (project, creator_id),
	FOREIGN KEY (creator_id) REFERENCES USERS (id)
);

CREATE TABLE IF NOT EXISTS PROJECTS
(
	id           INTEGER PRIMARY KEY,
	name         TEXT NOT NULL,
	slug         TEXT NOT NULL,
	solo         INTEGER DEFAULT 1,
	subject      TEXT    DEFAULT NULL,
	description  TEXT    DEFAULT NULL,
	experience   INTEGER DEFAULT 0,
	attachements TEXT    DEFAULT '[]'
);

CREATE TABLE IF NOT EXISTS SHADOW_BAN
(
	id  INTEGER PRIMARY KEY AUTOINCREMENT,
	user INTEGER,
	offender INTEGER,
	reason TEXT DEFAULT '',
	UNIQUE (user, offender),
	FOREIGN KEY (user) REFERENCES USERS (id),
	FOREIGN KEY (offender) REFERENCES USERS (id)
);

/*
CREATE TABLE IF NOT EXISTS PREFERENCES
(
	userid          INTEGER PRIMARY KEY,
	show_piscine    INTEGER DEFAULT 0,
	low_performance INTEGER DEFAULT 0,
	telegram_uid    TEXT DEFAULT NULL,
	send_notif      INTEGER DEFAULT 0,
	theme           INTEGER DEFAULT 0,
	lang 			VARCHAR DEFAULT 'fr'
	privacy         INTEGER DEFAULT 0,
	FOREIGN KEY (userid) REFERENCES USERS (id)
);
*/