SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- =============================================
CREATE   PROCEDURE [cqm2022].[GetOrSaveCPTCode] 
	@SnomedCTCode VARCHAR(100),
	@CPTCode VARCHAR(100),
	@Description VARCHAR(100)
AS

BEGIN
	DECLARE @TempCPTCode varchar(100) = @CPTCode;
	IF ISNULL(@TempCPTCode,'') = ''
	BEGIN
		SET @TempCPTCode = @SnomedCTCode
	END 
	
	IF NOT EXISTS (SELECT 1 FROM [dbo].[cpt_codes] WHERE Code=@TempCPTCode AND ISNULL(@TempCPTCode,'') != '')  
	BEGIN
		INSERT INTO [dbo].[cpt_codes] 
		(
		 Code,
		 Description,
		 long_desc
		) Values (
			@TempCPTCode,
			@Description + '-' + @TempCPTCode,
			@Description + '-' + @TempCPTCode
		)
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
