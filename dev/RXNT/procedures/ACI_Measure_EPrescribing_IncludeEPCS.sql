SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[ACI_Measure_EPrescribing_IncludeEPCS]    
 @dr_id int, @dg_id int=NULL, @reporting_start_date date, @reporting_end_date date    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 SET NOCOUNT ON;    
 declare @MeasureStage as varchar(10), @MeasureCode Varchar(3);    
 set @MeasureStage = 'MIPS2017';    
 set @MeasureCode = 'EPR';    
 
	DECLARE @DENOMINATOR_PATIENTS TABLE 
	(
		PatientId BIGINT
	);
	IF @dg_id IS  NULL
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		select p.pa_id AS DenomPatient
		from prescriptions p 
		inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
		inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
		where 
		p.dr_id = @dr_id AND
		p.pres_void = 0 and
		p.pres_approved_date between @reporting_start_date and @reporting_end_date
	END
	ELSE
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		select p.pa_id AS DenomPatient
		from prescriptions p 
		inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
		inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
		where  
		p.dg_id=@dg_id AND
		p.pres_void = 0 and
		p.pres_approved_date between @reporting_start_date and @reporting_end_date
	END
	
	DECLARE @NUMERATOR_PATIENTS TABLE 
	(
		PatientId BIGINT
	);
	IF @dg_id IS  NULL
	BEGIN
		INSERT INTO @NUMERATOR_PATIENTS
		select p.pa_id AS NumPatient
		from prescriptions p 
		inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
		inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
		where 
		p.dr_id = @dr_id AND
		p.pres_delivery_method > 2 and
		p.pres_void = 0 and
		p.pres_approved_date between @reporting_start_date and @reporting_end_date 
	END
	ELSE
	BEGIN
		INSERT INTO @NUMERATOR_PATIENTS
		select p.pa_id AS NumPatient
		from prescriptions p 
		inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
		inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
		where 
		p.dg_id=@dg_id AND
		p.pres_delivery_method > 2 and
		p.pres_void = 0 and
		p.pres_approved_date between @reporting_start_date and @reporting_end_date
	
	END;
	    
 with measures_data as    
 (    
  select  @MeasureCode as MeasureCode, @MeasureStage as MeasureStage, @dr_id as dr_id, @dg_id  as dg_id
 )  
    
 select  VMD.dr_id, MUM.MeasureCode, (SELECT COUNT(PatientID) FROM @DENOMINATOR_PATIENTS) AS Denominator, 
 (SELECT COUNT(PatientID) FROM @NUMERATOR_PATIENTS) AS Numerator, 
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id, MUM.MeasureClass,  MUM.Performace_points_per_10_percent, MUM.MeasureCalculation
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
                 and MUM.MeasureCode  = @MeasureCode    
                 and MUM.IsActive  = 1    
                 and MUM.MeasureStage = @MeasureStage  
     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
