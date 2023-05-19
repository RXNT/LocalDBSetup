SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Ramakrishna
-- Create date: 	24-Nov-2016
-- Description:		
-- =============================================
CREATE PROCEDURE [dbo].[SearchDrugSigIndication]

	@DoctorGroupId		INT

AS
BEGIN
	IF EXISTS(SELECT TOP 1 1 FROM doc_group_drug_indication WHERE dg_id=@DoctorGroupId )
	BEGIN
		SELECT code,description FROM doc_group_drug_indication WHERE dg_id=@DoctorGroupId 
	END
	ELSE
	BEGIN
		SELECT code,description FROM drug_indication 
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
