SET ANSI_NULLS ON 
GO
CREATE  PROCEDURE [dbo].[BulkInsertPatients] @FilePath varchar(255), @DataDelimiter varchar(10) AS

DECLARE @SQL varchar(2000)

CREATE TABLE #BulkPatients 
( 
	[dg_id] [int] NULL ,
	[dr_id] [int] NULL ,
	[pa_first] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_middle] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_last] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_ssn] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_dob] [smalldatetime] NULL ,
	[pa_address1] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_address2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_city] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_state] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_zip] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_phone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pa_wgt] [int] NULL ,
	[pa_sex] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) 

SET @SQL = "BULK INSERT #BulkPatients FROM '" + @FilePath + "' WITH (FIELDTERMINATOR = '" + @DataDelimiter + "', ROWTERMINATOR = '\n')"
EXEC (@SQL)

INSERT INTO patients (
	dg_id, dr_id, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, pa_address1, 
	pa_address2, pa_city, pa_state, pa_zip, pa_phone, pa_wgt, pa_sex
)
(
	SELECT * FROM #BulkPatients BP WHERE NOT EXISTS (
		SELECT pa_id FROM patients P 
		WHERE LOWER(P.pa_first) = LOWER(BP.pa_first) 
		AND LOWER(P.pa_last) = LOWER(BP.pa_last) 
		AND P.pa_dob = BP.pa_dob 
		AND P.dg_id = BP.dg_id
	)
)

DROP TABLE #BulkPatients
GO
SET ANSI_NULLS OFF 
GO

GO
