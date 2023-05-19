SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Save Access Log Entry
-- =============================================
CREATE PROCEDURE  [dbo].[usp_SaveAccessLogEntry]
	@PatientId      INT,
	@phrAccessType INT,
	@phrAccessDescription Varchar(500),
	@phrAccessDatetime DATETIME,
	@phrAccessFromIp Varchar(100)
AS
BEGIN
INSERT INTO [patient_phr_access_log] ( [pa_id], [phr_access_type], [phr_access_description], 
				[phr_access_datetime], [phr_access_from_ip]) 
				VALUES ( @PatientId, @phrAccessType, @phrAccessDescription,
					@phrAccessDatetime, @phrAccessFromIp); 

	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
