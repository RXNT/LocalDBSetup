SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 12-SEP-2018
-- Description: Validate Patient Email Token
-- =============================================
CREATE PROCEDURE  [phr].[usp_ValidatePatientEmailToken]
 	@PatientEmailToken	VARCHAR(900),
 	@Type				VARCHAR(10),
	@CheckExpiration	BIT=1
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @EmailTypeId AS BIGINT=0
	
	SELECT TOP 1 @EmailTypeId=ISNULL(ATC.ApplicationTableConstantId,0) FROM [ehr].[ApplicationTableConstants] ATC WITH(NOLOCK)
	INNER JOIN [ehr].[ApplicationTables] AT WITH(NOLOCK) ON ATC.ApplicationTableId=AT.ApplicationTableId
	WHERE AT.Code='PMTYP' AND ATC.Code=@Type
		
	SELECT TOP 1 ISNULL(PEL.PatientEmailLogId,0) AS PatientEmailLogId
	FROM [phr].[PatientEmailLogs] PEL WITH(NOLOCK)
	WHERE Token=@PatientEmailToken AND PEL.Active=1 
	AND Type=@EmailTypeId
	AND ((TokenExpiryDate > GETDATE() AND ISNULL(@CheckExpiration,0) = 1) OR ISNULL(@CheckExpiration,0) = 0)
	ORDER BY PEL.CreatedDate DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
