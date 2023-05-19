SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[STAGEII_MISSING_PATIENT_ERX_Excluding_Control_Substance]
@DR_ID INT,  
@REPORTING_START_DATE DATETIME,  
@REPORTING_END_DATE DATETIME

AS   
BEGIN 
	with Denominator_Data AS
	(
		select  distinct pa_id As DENOMINATORPATIENT
		  from  dbo.prescriptions   prx with(nolock)    
		  inner join dbo.prescription_details pxd with(nolock) on pxd.pres_id  = prx.pres_id    
		  inner join dbo.RMIID1     rd1 with(nolock)  on rd1.medid  = pxd.ddid    
		  where  1=1    
		  and   prx.dr_id     = @dr_id    
		  and   prx.pres_entry_date   between  @reporting_start_date and @reporting_end_date    
		  and   prx.pres_void    = 0  
		  and	prx.pres_approved_date is not null   
		  and   rd1.MED_REF_DEA_CD   < 2
	),
	Numerator_Data as    
	(    
	  select  distinct pa_id As NumeratorPatient 
	  from  dbo.prescriptions   prx with(nolock)    
	  inner join dbo.prescription_details pxd with(nolock)  on pxd.pres_id  = prx.pres_id    
	  --inner join dbo.prescription_coverage_info pci with(nolock) on pci.pd_id  = pxd.pd_id    
	  inner join dbo.RMIID1     rd1 with(nolock)  on rd1.medid  = pxd.ddid      
	  where  1=1    
	  and   prx.dr_id     = @dr_id    
	  and   prx.pres_entry_date   between  @reporting_start_date and @reporting_end_date    
	  and   prx.pres_void    = 0  
	  and	prx.pres_approved_date is not null   
	  and   prx.pres_delivery_method > 2    
	  and   rd1.MED_REF_DEA_CD   < 2
	)    
	SELECT  DISTINCT P.PA_ID AS PATIENT,
			P.PA_FIRST AS FIRSTNAME, 
			P.PA_LAST AS LASTNAME, 
			P.PA_DOB AS DATEOFBIRTH, 
			P.PA_SEX AS SEX,
			P.PA_ADDRESS1 AS ADDRESS1, 
			P.PA_CITY AS CITY,
			P.PA_STATE AS STATE, 
			P.PA_ZIP AS ZIPCODE,
			P.PA_SSN AS CHART FROM dbo.PATIENTS P with(nolock)
			INNER JOIN Denominator_Data DD ON P.PA_ID  = DD.DENOMINATORPATIENT
			LEFT OUTER JOIN Numerator_Data ND on P.PA_ID = ND.NumeratorPatient
			WHERE 1=1
			AND  ND.NUMERATORPATIENT IS NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
