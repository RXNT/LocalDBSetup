SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	06-JULY-2017
-- Description:		Get prescription written by and last edit by info
-- =============================================
CREATE PROCEDURE [support].[GetPrescriptionInfo]
  @PrescriptionId			BIGINT
AS
BEGIN
	SELECT pres.pres_id PrescriptionId,pd.pd_id PrescriptionDetailId,
	doc.dr_id AS UserId,doc.dr_username AS Username, doc.dr_first_name PrescAddedByUserFirstName, doc.dr_last_name PrescAddedByUserLastName, 
	doc1.dr_id as ApprovedByUserId, doc1.dr_username as ApprovedByUsername, doc1.dr_last_name as ApprovedByUserLastname, doc1.dr_first_name as ApprovedByUserFirstname,
	doc2.dr_id as PrimaryDoctorId, doc2.dr_username as PrimaryDoctorUsername, doc2.dr_last_name as PrimaryDoctorUserLastname, doc2.dr_first_name as PrimaryDoctorUserFirstname 
	FROM prescription_details pd WITH(NOLOCK)
	INNER JOIN prescriptions pres ON pd.pres_id = pres.pres_id
	LEFT OUTER JOIN doctors doc WITH(NOLOCK) ON pres.writing_dr_id=doc.dr_id
	LEFT OUTER JOIN doctors doc1 WITH(NOLOCK) ON pres.last_edit_dr_id=doc1.dr_id
	LEFT OUTER JOIN doctors doc2 WITH(NOLOCK) ON pres.prim_dr_id=doc2.dr_id
	WHERE pd.pd_id=@PrescriptionId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
