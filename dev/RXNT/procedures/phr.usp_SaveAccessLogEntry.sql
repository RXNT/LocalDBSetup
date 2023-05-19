SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Save Access Log Entry
-- =============================================
CREATE PROCEDURE  [phr].[usp_SaveAccessLogEntry]
(
	@PatientId      INT,
	@PhrAccessType INT,
	@PhrAccessDescription Varchar(500),
	@PhrAccessDatetime DATETIME,
	@PhrAccessFromIp Varchar(100),
	@PatientRepresentativeId BIGINT
)
AS
BEGIN
	INSERT INTO [patient_phr_access_log] ( 
		[pa_id], [phr_access_type], [phr_access_description], [phr_access_datetime], [phr_access_from_ip], [PatientRepresentativeId]) 
	VALUES ( @PatientId, @PhrAccessType, @PhrAccessDescription, @PhrAccessDatetime, @PhrAccessFromIp, @PatientRepresentativeId); 

	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
