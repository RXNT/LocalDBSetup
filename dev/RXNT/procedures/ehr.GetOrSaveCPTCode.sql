SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyas
Create date			:	06-NOV-2016
Description			:	This procedure is used to Get or Save CPT code
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[GetOrSaveCPTCode] 
	@SnomedCTCode VARCHAR(100),
	@CPTCode VARCHAR(100),
	@Description VARCHAR(100)
AS

BEGIN
	IF(@CPTCode IS NOT NULL OR @CPTCode != '')
	 BEGIN 
		IF NOT EXISTS (SELECT 1 FROM [dbo].[cpt_codes] WHERE Code=@CPTCode)
			BEGIN
				INSERT INTO [dbo].[cpt_codes] 
				(
				 Code,
				 Description,
				 long_desc
				) Values (
					@CPTCode,
					@Description,
					@Description
				)
			END
	 END
	ELSE IF(@SnomedCTCode IS NOT NULL OR @SnomedCTCode != '')
	 BEGIN
		IF NOT EXISTS (SELECT 1 FROM [dbo].[cpt_codes] WHERE Code=@SnomedCTCode)
			BEGIN
				INSERT INTO [dbo].[cpt_codes] 
				(
				 Code,
				 Description,
				 long_desc
				) Values (
					@SnomedCTCode,
					@Description,
					@Description
				)
			END
	 END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
