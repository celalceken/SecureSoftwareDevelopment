CREATE TABLE "Ogrenci"(
	"OgrenciNo"                 INTEGER NOT NULL UNIQUE,
	"Ad"    					character varying(50) DEFAULT 'isim'::character varying NOT NULL,
	"Soyad"     				character varying(50) DEFAULT 'soyisim'::character varying NOT NULL,
	"oBolumNo"                   INT,
	"oDanisman"                  INT,
	"oilKodu"					INT,
	CONSTRAINT "OgrenciNoPK" PRIMARY KEY("OgrenciNo")
);

create table "AcilanDers"(
    "ADersKodu"                 INTEGER NOT NULL UNIQUE,
    "Sube"                      VARCHAR(40) NOT NULL,
    "aDersKodu"                  INT,
    "aDerslikNo"                 INT,
	"abolumNo"                   INT,
	"adonemNo"					 INT,
	"atcKimlikNo"				 INT,
    CONSTRAINT "ADersKoduPK" PRIMARY KEY("ADersKodu")
);

CREATE TABLE "Kayit"(
    "OgrenciNo"                 int REFERENCES "Ogrenci" ("OgrenciNo") ON UPDATE CASCADE ON DELETE CASCADE,
    "ADersKodu"                 int REFERENCES "AcilanDers" ("ADersKodu") ON UPDATE CASCADE,
    "KayitTarihi"               timestamp with time zone DEFAULT now() NOT NULL,
    "BasariNotu"                VARCHAR(40) NOT NULL
);

CREATE TABLE "OgretimUyesi"(
	"TcKimlikNo"         		INTEGER NOT NULL UNIQUE,
	"Ad"    					character varying(50) DEFAULT 'isim'::character varying NOT NULL,
	"Soyad"     				character varying(50) DEFAULT 'soyisim'::character varying NOT NULL,
    "IlkHarfler"                VARCHAR(40) NOT NULL,
	"ogrbolumNo"				INT,
	CONSTRAINT "TcKimlikNoPK" PRIMARY KEY("TcKimlikNo")
);

CREATE TABLE "Fakulte"(
    "FakulteNo"         INTEGER NOT NULL UNIQUE,
    "FakulteAdi"        VARCHAR(40) NOT NULL UNIQUE,
	"funiversiteNo"		INT,
	"fDekan"			INT,
    CONSTRAINT "FakulteNoPK" PRIMARY KEY("FakulteNo")
);

create table "Universite"(
    "UniversiteNo"      INTEGER NOT NULL UNIQUE,
    "adi"               VARCHAR(40) NOT NULL UNIQUE,
    "telefonu"          VARCHAR(40) NOT NULL,
	"uniilceKodu"		INT,
	"uniilKodu"			INT,
    CONSTRAINT "UniversiteNoPK" PRIMARY KEY("UniversiteNo")
);

create table "Bolum"(
    "BolumNo"           INTEGER NOT NULL UNIQUE,
    "BolumAdi"          VARCHAR(40) NOT NULL UNIQUE,
	"bolFakulteNo"		INT,
	"bolbBaskani"		INT,
    CONSTRAINT "BolumNoPK" PRIMARY KEY("BolumNo")
);

CREATE TABLE "KatalogDers"(
    "DersKodu"          INTEGER NOT NULL UNIQUE,
    "DersAdi"           VARCHAR(40) NOT NULL UNIQUE,
    "Kredi"             VARCHAR(40) NOT NULL,
	"kbolumNo"			INT,
    CONSTRAINT "DersKoduPK" PRIMARY KEY("DersKodu")
);

create table "DersProgrami"(
    "programNo"         INTEGER NOT NULL UNIQUE,
    "dersNo"            VARCHAR(40) NOT NULL,
    "gun"               timestamp with time zone DEFAULT now() NOT NULL,
    "baslamaSaati"      timestamp with time zone DEFAULT now() NOT NULL,
    "bitisSaati"        timestamp with time zone DEFAULT now() NOT NULL,
    "donem"             VARCHAR(40) NOT NULL,
	"ddonemNo"			INT,
	"dgunNo"			INT,
	"dADersKodu"        INT,
    CONSTRAINT "programNoPK" PRIMARY KEY("programNo")
);

CREATE TABLE "il"(
    "ilKodu"            INTEGER NOT NULL UNIQUE,
    "adi"               VARCHAR(40) NOT NULL UNIQUE,
    CONSTRAINT "ilKoduPK" PRIMARY KEY("ilKodu")
);

create table "ilce"(
    "ilceKodu"          INTEGER NOT NULL UNIQUE,
    "adi"               VARCHAR(40) NOT NULL,
	"ilceilKodu"		INT,
    CONSTRAINT "ilceKoduPK" PRIMARY KEY("ilceKodu")
);

create table "yerleske"(
    "yerleskeNo"        INTEGER NOT NULL UNIQUE,
    "adi"               VARCHAR(40) NOT NULL,
    "adresi"            VARCHAR(40) NOT NULL,
	"yilceKodu"			INT,
    CONSTRAINT "yerleskeNoPK" PRIMARY KEY("yerleskeNo")
);

create table "donem"(
    "donemNo"           INTEGER NOT NULL UNIQUE,
    "donem"             VARCHAR(40) NOT NULL,
    CONSTRAINT "donemNoPK" PRIMARY KEY("donemNo")
);

create table "Derslik"(
    "DerslikNo"         INTEGER NOT NULL UNIQUE,
	"derslikbinaNo"		INT,
    "DerslikAdi"        VARCHAR(40) NOT NULL,
    CONSTRAINT "DerslikNoPK" PRIMARY KEY("DerslikNo")
);

CREATE TABLE "bina"(
    "binaNo"            INTEGER NOT NULL UNIQUE,
    "binaAdi"           VARCHAR(40) NOT NULL,
    "adres"             VARCHAR(40) NOT NULL,
	"binayerleskeNo"	INT,
    CONSTRAINT "binaNoPK" PRIMARY KEY("binaNo")
);

CREATE TABLE "gunler"(
    "gunNo"             INTEGER NOT NULL UNIQUE,
    "gun"               VARCHAR(40) NOT NULL,
    CONSTRAINT "gunNoPK" PRIMARY KEY("gunNo")
);
--------------------------------------------------------------------------------
ALTER TABLE "public"."Universite"
	ADD CONSTRAINT "ilceilceKodu" FOREIGN KEY ("uniilceKodu")
	REFERENCES "public"."ilce" ("ilceKodu")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."Universite"
	ADD CONSTRAINT "ililKodu" FOREIGN KEY ("uniilKodu")
	REFERENCES "public"."il" ("ilKodu")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."yerleske"
	ADD CONSTRAINT "ilceilceKodu" FOREIGN KEY ("yilceKodu")
	REFERENCES "public"."ilce" ("ilceKodu")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "public"."ilce"
	ADD CONSTRAINT "ililKodu" FOREIGN KEY ("ilceilKodu")
	REFERENCES "public"."il" ("ilKodu")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "public"."Ogrenci"
	ADD CONSTRAINT "ililKodu" FOREIGN KEY ("oilKodu")
	REFERENCES "public"."il" ("ilKodu")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."AcilanDers"
	ADD CONSTRAINT "bolumbolumNo" FOREIGN KEY ("abolumNo")
	REFERENCES "public"."Bolum" ("BolumNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;	
	
ALTER TABLE "public"."AcilanDers"
	ADD CONSTRAINT "donemdonemNo" FOREIGN KEY ("adonemNo")
	REFERENCES "public"."donem" ("donemNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;	
	
ALTER TABLE "public"."DersProgrami"
	ADD CONSTRAINT "ADersADersKodu" FOREIGN KEY ("dADersKodu")
	REFERENCES "public"."AcilanDers" ("ADersKodu")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."Fakulte"
	ADD CONSTRAINT "universiteuniversiteNo" FOREIGN KEY ("funiversiteNo")
	REFERENCES "public"."Universite" ("UniversiteNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."Bolum"
	ADD CONSTRAINT "FakulteFakulteNo" FOREIGN KEY ("bolFakulteNo")
	REFERENCES "public"."Fakulte" ("FakulteNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."OgretimUyesi"
	ADD CONSTRAINT "bolumbolumNo" FOREIGN KEY ("ogrbolumNo")
	REFERENCES "public"."Bolum" ("BolumNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."Bolum"
	ADD CONSTRAINT "bbBaskani" FOREIGN KEY ("bolbBaskani")
	REFERENCES "public"."OgretimUyesi" ("TcKimlikNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "public"."Fakulte"
	ADD CONSTRAINT "DekanDekan" FOREIGN KEY ("fDekan")
	REFERENCES "public"."OgretimUyesi" ("TcKimlikNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."Ogrenci"
	ADD CONSTRAINT "DanismanDanisman" FOREIGN KEY ("oDanisman")
	REFERENCES "public"."OgretimUyesi" ("TcKimlikNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "public"."Ogrenci"
	ADD CONSTRAINT "bolumbolumNo" FOREIGN KEY ("oBolumNo")
	REFERENCES "public"."Bolum" ("BolumNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."AcilanDers"
	ADD CONSTRAINT "tcKimliktcKimlikNo" FOREIGN KEY ("atcKimlikNo")
	REFERENCES "public"."OgretimUyesi" ("TcKimlikNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."KatalogDers"
	ADD CONSTRAINT "bolumbolumNo" FOREIGN KEY ("kbolumNo")
	REFERENCES "public"."Bolum" ("BolumNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."AcilanDers"
	ADD CONSTRAINT "DersDersKodu" FOREIGN KEY ("aDersKodu")
	REFERENCES "public"."KatalogDers" ("DersKodu")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."Derslik"
	ADD CONSTRAINT "binabinaNo" FOREIGN KEY ("derslikbinaNo")
	REFERENCES "public"."bina" ("binaNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE "public"."bina"
	ADD CONSTRAINT "yerleskeyerleskeNo" FOREIGN KEY ("binayerleskeNo")
	REFERENCES "public"."yerleske" ("yerleskeNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "public"."DersProgrami"
	ADD CONSTRAINT "donemdonemNo" FOREIGN KEY ("ddonemNo")
	REFERENCES "public"."donem" ("donemNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "public"."DersProgrami"
	ADD CONSTRAINT "gungunNo" FOREIGN KEY ("dgunNo")
	REFERENCES "public"."gunler" ("gunNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "public"."AcilanDers"
	ADD CONSTRAINT "DerslikDerslikNo" FOREIGN KEY ("aDerslikNo")
	REFERENCES "public"."Derslik" ("DerslikNo")
	ON DELETE CASCADE
	ON UPDATE CASCADE;	
	