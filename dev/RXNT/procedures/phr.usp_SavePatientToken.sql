SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Save Patient Tokens
-- =============================================
CREATE PROCEDURE  [phr].[usp_SavePatientToken]
 (
	@PatientId			BIGINT,
	@DoctorCompanyId	BIGINT,
	@Token				VARCHAR(900),
	@ExpirySeconds		INT	
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @TokenExpiryDate DATETIME2;
	SET @TokenExpiryDate = DATEADD(SS, @ExpirySeconds, GETDATE());
	INSERT INTO [dbo].[PatientTokens]
           ([PatientId]
           ,[DoctorCompanyId]
           ,[Token]
           ,[TokenExpiryDate]
		   ,[Active]
           ,[CreatedDate]
           ,[CreatedBy])
     VALUES
           (@PatientId
           ,@DoctorCompanyId
           ,@Token
           ,@TokenExpiryDate
		   ,1
           ,GETDATE()
           ,@PatientId)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
