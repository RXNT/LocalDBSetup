SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Balaji
-- Create date: 01/13/2016
-- Description:	Automatic Measure Calculation - Missing Patients (CPOE Measure 1: Medication Orders - Alternate Measure)
-- =============================================
CREATE PROCEDURE CPOE_Measure1_Medication_Orders_Alternate_Measure
	-- Add the parameters for the stored procedure here
	@dr_id int, @reporting_start_date date, @reporting_end_date date  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select Count( CASE WHEN r.type=1 THEN r.ad_id ELSE NULL END)   NUMERATOR, Count(r.ad_id )  DENOMINATOR, 
	NULL as dr_id, NULL as MeasureCode,    
    'CPOE Measure 1: Medication Orders - Alternate Measure' as MeasureName, NULL as DisplayOrder, 'CPOE Measure 1: Medication Orders - Alternate Measure' as MeasureDescription, '> 30%' as PassingCriteria, NULL as MeasureGroup, NULL as MeasureStage, null as MeasureResult,NULL as MeasureGroupName,NULL as Id    
	from (
    SELECT distinct pa_id, pres.pres_id ad_id,1 AS type from prescriptions pres  with(nolock) where pres_void = 0 AND pres.pres_entry_date between @reporting_start_date and @reporting_end_date AND dr_id=@dr_id And (pres.pres_approved_date is not null)
    UNION 
    SELECT distinct pa_id, pam.pam_id ad_id,2 AS type from patient_medications_hx pam with(nolock)  where pam.date_added between @reporting_start_date and @reporting_end_date AND (added_by_dr_id=@dr_id or for_dr_id=@dr_id)
    ) r

    SET NOCOUNT OFF;

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
