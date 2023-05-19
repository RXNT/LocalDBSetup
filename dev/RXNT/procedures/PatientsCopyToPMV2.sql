SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 01/08/2015
-- Description:	To copy patients to PMV2
-- =============================================
--**********************************************
--IMPORTANT THIS SP IS CALLING FROM PatientsCopyToExternalApp SP
--**********************************************
CREATE PROCEDURE [dbo].[PatientsCopyToPMV2] 
@pa_id AS BIGINT 
AS
BEGIN
	DECLARE @IsCopied BIT --Is the patient copied in PMV2 database
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	BEGIN
		SET @IsCopied=1
	END
	PRINT @IsCopied
	RETURN @IsCopied
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
