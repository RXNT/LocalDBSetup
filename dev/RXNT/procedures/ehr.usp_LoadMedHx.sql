SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	23-JUNE-2016
Description			:	This procedure is used to Load Prescription 
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_LoadMedHx]
	@PrescriptionId BIGINT
AS
BEGIN
	 select pam_id,pa_id,drug_id,date_added,added_by_dr_id
            compound,drug_comments,drug_name,dosage,duration_amount,
            duration_unit,numb_refills,use_generic,days_supply,
            prn,prn_description,date_end,date_start
            FROM patient_medications_hx WITH(NOLOCK) where pam_id= @PrescriptionId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
