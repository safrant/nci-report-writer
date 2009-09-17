-- Create Report Writer database
--
-- ------------------------------------------------------

--
-- Insert reportwriter data
--

USE @database.name@;

--
-- Data for table `USER`
--

INSERT INTO `USER` (`ID`,`LOGIN_NAME`) VALUES
 (101,'@rw.admin.user@'),
 (102,'@rw.user.name@');

--
-- Data for table `hi_value`
--

INSERT INTO `hi_value` (`next_value`) VALUES
 (68);

--
-- Data for table `REPORT_FORMAT`
--

INSERT INTO `REPORT_FORMAT` (`ID`,`DESCRIPTION`) VALUES
 (404,'Text (tab delimited)'),
 (405,'Microsoft Office Excel');

--
-- Data for table `REPORT_STATUS`
--

INSERT INTO `REPORT_STATUS` (`ID`,`LABEL`,`DESCRIPTION`,`ACTIVE`) VALUES
 (505,'DRAFT','REPORT is a draft, not ready for download.',1),
 (506,'APPROVED','REPORT has been approved for download by USERs',1);

--
-- Data for table `STANDARD_REPORT_TEMPLATE`
--

INSERT INTO `STANDARD_REPORT_TEMPLATE` (`ID`,`LABEL`,`ROOT_CONCEPT_CODE`,`ASSOCIATION_NAME`,`DIRECTION`,`CODING_SCHEME_NAME`,`CODING_SCHEME_VERSION`,`LEVEL`,`DELIMITER`) VALUES
 (202,'FDA-UNII Subset REPORT','C63923','Concept_In_Subset',0,'NCI Thesaurus','09.05d',1,'$'),
 (2323,'Individual Case Safety (ICS) Subset REPORT','C54447','Concept_In_Subset',0,'NCI Thesaurus','09.05d',1,'$'),
 (3535,'Structured Product Labeling (SPL) REPORT','C54452','Concept_In_Subset',0,'NCI Thesaurus','09.05d',2,'$'),
 (4040,'CDISC Subset REPORT ','C61410','Concept_In_Subset',0,'NCI Thesaurus','09.05d',1,'$'),
 (4646,'CDRH Subset REPORT','C62596','Concept_In_Subset',0,'NCI Thesaurus','09.05d',1,'$'),
 (6060,'FDA-SPL Country Code REPORT','Semantic_Type|null|null|null|Geographic Area|exactMatch','',0,'NCI Thesaurus','09.05d',0,'$');

--
-- Data for table `REPORT_COLUMN`
--

INSERT INTO `REPORT_COLUMN` (`ID`,`COLUMN_NUMBER`,`LABEL`,`FIELD_ID`,`PROPERTY_TYPE`,`PROPERTY_NAME`,`IS_PREFERRED`,`REPRESENTATIONAL_FORM`,`SOURCE`,`QUALIFIER_NAME`,`QUALIFIER_VALUE`,`DELIMITER`,`CONDITIONAL_COLUMN`,`BELONGS_TO`) VALUES
 (303,1,'FDA UNII Code','Property','Generic','FDA_UNII_Code',NULL,'',' ','','','|',-1,202),
 (304,2,'FDA Preferred Term','Property','Presentation','FULL_SYN',NULL,'PT','FDA','','','|',-1,202),
 (1212,3,'NCI Concept Code','Code','','',NULL,'',' ','','','|',-1,202),
 (2929,1,'Source','Property','GENERIC','Contributing_Source',NULL,'',' ','','','|',-1,2323),
 (2930,2,'Subset Code','Associated Concept Code','','',NULL,'',' ','','','|',-1,2323),
 (2931,3,'Subset Name','Associated Concept Property','PRESENTATION','Preferred_Name',NULL,'',' ','','','|',-1,2323),
 (3131,4,'Concept Code','Code','','',NULL,'',' ','','','|',-1,2323),
 (3132,5,'Source PT','Property','PRESENTATION','FULL_SYN',NULL,'PT','FDA','','','|',-1,2323),
 (3333,6,'Source Definition','Property','DEFINITION','ALT_DEFINITION',NULL,'','FDA','','','|',-1,2323),
 (3334,6,'Source Synonym(s)','Property','PRESENTATION','FULL_SYN',NULL,'SY','FDA','','','|',-1,2323),
 (3636,1,'Source','Property','GENERIC','Contributing_Source',NULL,'',' ','','','|',-1,3535),
 (3637,2,'Subset Code','Associated Concept Code','','',NULL,'',' ','','','|',-1,3535),
 (3638,3,'Subset Name','Associated Concept Property','PRESENTATION','Preferred_Name',NULL,'',' ','','','|',-1,3535),
 (3639,4,'Concept Code','Code','','',NULL,'',' ','','','|',-1,3535),
 (3640,5,'Source PT','Property','PRESENTATION','FULL_SYN',NULL,'PT','FDA','','','|',-1,3535),
 (3641,6,'Source Definition','Property','DEFINITION','ALT_DEFINITION',NULL,'','FDA','','','|',-1,3535),
 (3642,7,'Source Synonym(s)','Property','PRESENTATION','FULL_SYN',NULL,'SY','FDA','','','|',-1,3535),
 (4141,1,'Source','Property','GENERIC','Contributing_Source',NULL,'',' ','','','|',-1,4040),
 (4142,2,'Subset Code','Associated Concept Code','','',NULL,'',' ','','','|',-1,4040),
 (4143,3,'Subset Name','Associated Concept Property','PRESENTATION','Preferred_Name',NULL,'',' ','','','|',-1,4040),
 (4144,4,'Concept Code','Code','','',NULL,'',' ','','','|',-1,4040),
 (4145,5,'Source PT','Property','PRESENTATION','FULL_SYN',NULL,'PT','CDISC','','','|',-1,4040),
 (4146,6,'Source PT Code','Property','PRESENTATION','Preferred_Name',NULL,'','','','','|',-1,4040),
 (4147,7,'Source Definition','Property','DEFINITION','ALT_DEFINITION',NULL,'','CDISC','','','|',-1,4040),
 (4148,8,'Source Synonym(s)','Property','PRESENTATION','FULL_SYN',NULL,'SY','CDISC','','','|',-1,4040),
 (4747,1,'Source','Property','GENERIC','Contributing_Source',NULL,'',' ','','','|',-1,4646),
 (4748,2,'Subset Code','Associated Concept Code','','',NULL,'',' ','','','|',-1,4646),
 (4749,3,'Subset Name','Associated Concept Property','PRESENTATION','Preferred_Name',NULL,'',' ','','','|',-1,4646),
 (4750,4,'Concept Code','Code','','',NULL,'',' ','','','|',-1,4646),
 (4848,5,'Source Code','Property Qualifier','PRESENTATION','FULL_SYN',NULL,'PT','FDA','source-code','','|',-1,4646),
 (4849,6,'Source PT','Property','PRESENTATION','FULL_SYN',NULL,'PT','FDA','','','|',-1,4646),
 (4850,7,'Source Synonym(s)','Property','PRESENTATION','FULL_SYN',NULL,'SY','FDA','','','|',-1,4646),
 (4851,8,'Source Definition','Property','DEFINITION','ALT_DEFINITION',NULL,'','FDA','','','|',-1,4646),
 (4852,9,'NCI Definition','Property','DEFINITION','DEFINITION',NULL,'',' ','','','|',-1,4646),
 (4853,10,'Parent Concept\'s NCIT Concept Code','1st Parent Code','','',NULL,'',' ','','','|',-1,4646),
 (4854,11,'Parent Concept\'s Source Code','1st Parent Property Qualifier','PRESENTATION','FULL_SYN',NULL,'PT','FDA','source-code','','|',-1,4646),
 (4855,12,'Parent Concept\'s Source PT','1st Parent Property','PRESENTATION','FULL_SYN',NULL,'PT','FDA','','','|',-1,4646),
 (4856,13,'Parent Concept\'s NCIT PT','1st Parent Property','PRESENTATION','Preferred_Name',NULL,'',' ','','','|',-1,4646),
 (4857,14,'Second Parent\'s Concept\'s NCIt Concept Code','2nd Parent Code','','',NULL,'',' ','','','|',-1,4646),
 (4858,15,'Second Parent\'s Concept\'s NCIt PT','2nd Parent Property','PRESENTATION','Preferred_Name',NULL,'',' ','','','|',6,4646),
 (6161,1,'ISO Code','Property','PRESENTATION','FULL_SYN',NULL,'CA3','NCI','','','|',-1,6060),
 (6162,2,'NCI Concept Code','Code','','',NULL,'',' ','','','|',-1,6060),
 (6163,3,'NCI Preferred Term','Property','PRESENTATION','Preferred_Name',NULL,'',' ','','','|',-1,6060);

--
-- Data for table `REPORT`
--

INSERT INTO `REPORT` (`ID`,`LABEL`,`LAST_MODIFIED`,`PATH_NAME`,`HAS_FORMAT`,`HAS_STATUS`,`MODIFIED_BY`,`CREATED_BY`) VALUES
 (5858,'Individual Case Safety (ICS) Subset REPORT.txt',NULL,'',404,505,NULL,101),
 (5859,'Individual Case Safety (ICS) Subset REPORT.xls',NULL,'',405,505,NULL,101),
 (5860,'Structured Product Labeling (SPL) REPORT.txt',NULL,'',404,505,NULL,101),
 (5861,'Structured Product Labeling (SPL) REPORT.xls',NULL,'',405,505,NULL,101),
 (5862,'CDISC Subset REPORT .txt',NULL,'',404,505,NULL,101),
 (5863,'CDISC Subset REPORT .xls',NULL,'',405,505,NULL,101),
 (5959,'CDRH Subset REPORT.txt',NULL,'',404,505,NULL,101),
 (5960,'CDRH Subset REPORT.xls',NULL,'',405,505,NULL,101),
 (6262,'FDA-UNII Subset REPORT.txt',NULL,'',404,505,NULL,101),
 (6263,'FDA-UNII Subset REPORT.xls',NULL,'',405,505,NULL,101),
 (6767,'FDA-SPL Country Code REPORT.txt',NULL,'',404,505,NULL,101),
 (6768,'FDA-SPL Country Code REPORT.xls',NULL,'',405,505,NULL,101);

--
-- Data for table `STANDARD_REPORT`
--

INSERT INTO `STANDARD_REPORT` (`REPORT_ID`,`BASED_ON_TEMPLATE`) VALUES
 (6262,202),
 (6263,202),
 (5858,2323),
 (5859,2323),
 (5860,3535),
 (5861,3535),
 (5862,4040),
 (5863,4040),
 (5959,4646),
 (5960,4646),
 (6767,6060),
 (6768,6060);

COMMIT;