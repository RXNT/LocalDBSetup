SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 20-FEB-2017
-- Description:	This procedure is used to Get Prescriptions For a Doctor
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [support].[GetPrescriptionsForDoctor]	
	@DoctorId			BIGINT,
	@FromDate DATETIME,
	@ToDate DATETIME
AS
BEGIN
	SET @FromDate = CONVERT(VARCHAR(20),@FromDate, 101)
	SET @ToDate = CONVERT(VARCHAR(20),@ToDate, 101)
	
	SELECT pat.pa_first as PatientFirstName, pat.pa_last as PatientLastName, pat.pa_dob as DOB, pat.pa_address1 as PatientAddress, pat.pa_phone as Phone, pres.pres_id as PrescriptionId, presdet.drug_name as DrugName, presdet.dosage as Dosage, presdet.duration_amount as DurationAmount,presdet.duration_unit as DurationUnit, pres.pres_entry_date as PrescriptionEntryDate, pres.pres_approved_date as PrescriptionApprovedDate, pres.pres_void_comments as VoidComments FROM prescriptions pres WITH(NOLOCK)
	INNER JOIN prescription_details presdet WITH(NOLOCK) ON pres.pres_id=presdet.pres_id
	INNER JOIN patients pat WITH(NOLOCK) ON pres.pa_id=pat.pa_id
	WHERE pres.dr_id=@DoctorId AND pres.pres_approved_date BETWEEN @FromDate AND @ToDate
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
