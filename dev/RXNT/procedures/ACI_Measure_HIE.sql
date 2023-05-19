SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Reiah    
-- Create date: 09/14/2017
-- Description: Procedure to get the measures data for secure messaging    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measure_HIE]
 @dr_id int, @dg_id int = null, @reporting_start_date date, @reporting_end_date date, @measureCode Varchar(3)   
AS    
BEGIN    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10);    
 set @MeasureStage = 'MIPS2017'; 
 
	DECLARE @DENOMINATOR_PATIENTS TABLE 
	(
		PatientId BIGINT,
		MainDoctorID BIGINT,
		ref_id BIGINT 
	);
	IF @dg_id IS  NULL
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		select  rm.pa_id as PatientId,rm.main_dr_id as MainDoctorID,ref_id
		from  referral_main  rm  with(nolock)    
		where  1=1 
		AND rm.main_dr_id=@dr_id 
		AND   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
		group by rm.pa_id,rm.main_dr_id,rm.ref_id
	END
	ELSE
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		select  rm.pa_id as PatientId,rm.main_dr_id as MainDoctorID,ref_id
		from  referral_main  rm  with(nolock)    
		INNER JOIN patients pat WITH(NOLOCK) ON   rm.pa_id=pat.pa_id
		where  1=1 
		AND pat.dg_id=@dg_id 
		and   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
		group by rm.pa_id,rm.main_dr_id,rm.ref_id
	END;
	
	with measures_data as    
	(    
	select  @measureCode as MeasureCode, 'MIPS2017' as MeasureStage, @dr_id as dr_id, @dg_id  as dg_id    
	), 

 Numerator_Data as    
 ( 
	SELECT DISTINCT  pat.PatientId  As PatientId
	from  @DENOMINATOR_PATIENTS    pat
	
	where  1=1
		AND EXISTS (SELECT * FROM  dbo.direct_email_sent_messages de with(nolock) 
		WHERE de.attachment_type = 'CCD' AND pat.ref_id=de.ref_id
		and	  de.send_success = 1 
		and   de.sent_date between @reporting_start_date and @reporting_end_date   
		AND de.pat_id = pat.PatientId
		)
		--AND EXISTS(SELECT * FROM  dbo.MUMeasureCounts MUC WHERE MUC.pa_id = pat.PatientId AND pat.MainDoctorID=MUC.dr_id
		--and   MUC.IsNumerator = 1 
		--and   MUC.dr_id  = pat.MainDoctorID
		--and   MUC.MeasureCode = 'SC2'
		--and	  MUC.DateAdded  between @reporting_start_date and @reporting_end_date
		--AND ((@dg_id IS NULL AND MUC.dr_id = @dr_id) OR
	--(@dg_id IS NOT NULL AND MUC.dg_id=@dg_id)) 
		--)
	group by pat.PatientId
 )
 
 select  VMD.dr_id, MUM.MeasureCode,
		(select COUNT(PatientId) FROM Numerator_Data) as Numerator, 
		(select COUNT(PatientId) FROM @DENOMINATOR_PATIENTS) as Denominator,
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUM.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id , MUM.MeasureClass,  MUM.Performace_points_per_10_percent , MUM.MeasureCalculation
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
         and MUM.MeasureCode  = @measureCode    
         and MUM.IsActive  = 1    
         and MUM.MeasureStage = @MeasureStage      
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
