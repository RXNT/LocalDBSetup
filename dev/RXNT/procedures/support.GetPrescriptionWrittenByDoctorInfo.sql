SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	06-JULY-2017
-- Description:		Get prescription written by and last edit by info
-- =============================================
CREATE PROCEDURE [support].[GetPrescriptionWrittenByDoctorInfo]
  @PrescriptionId			BIGINT
AS
BEGIN
	SELECT doc.dr_id AS UserId,doc.dr_username AS Username, doc.dr_first_name PrescAddedByUserFirstName, doc.dr_last_name PrescAddedByUserLastName, doc1.dr_id as ApprovedByUserId, doc1.dr_username as ApprovedByUsername, doc1.dr_last_name as ApprovedByUserLastname, doc1.dr_first_name as ApprovedByUserFirstname FROM prescription_details pd WITH(NOLOCK)
	INNER JOIN prescriptions pres ON pd.pres_id = pres.pres_id
	INNER JOIN doctors doc WITH(NOLOCK) ON pres.writing_dr_id=doc.dr_id
	INNER JOIN doctors doc1 WITH(NOLOCK) ON pres.last_edit_dr_id=doc1.dr_id
	WHERE pd.pd_id=@PrescriptionId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
