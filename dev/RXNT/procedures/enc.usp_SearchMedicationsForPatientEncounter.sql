SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	27-10-2017
Description			:	This procedure is used to Search Patient Medications
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [enc].[usp_SearchMedicationsForPatientEncounter]
	@Name VARCHAR(50),
	@MaxRows INT = 50,
	@DoctorGroupId INT,
	@DoctorCompanyId INT
AS

BEGIN
	SET NOCOUNT ON;
	
	SELECT distinct TOP (@MaxRows) medid, med_medid_desc 
	from rnmmidndc 
	where med_medid_desc like '%'+@Name +'%' AND MEDID BETWEEN 0 AND 999999 
	UNION
	SELECT distinct medid, med_medid_desc 
	from rnmmidndc R 
	INNER JOIN doc_group_freetext_meds F ON F.drug_id=R.MEDID
	INNER JOIN DOC_GROUPS D ON D.dg_id=F.dg_id 
	WHERE MED_MEDID_DESC LIKE '%'+@Name +'%' 
	AND D.dc_id= @DoctorCompanyId
	AND is_active=1
	ORDER BY MED_MEDID_DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
