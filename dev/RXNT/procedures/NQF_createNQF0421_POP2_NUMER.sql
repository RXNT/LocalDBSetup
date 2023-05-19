SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0421_POP2_NUMER]
    @dgid VARCHAR(15),
    @PatientIds varchar(max)  
AS
BEGIN
BEGIN TRY
   declare @query varchar(max);
	set @query ='select count(distinct PAT.pa_id)SM from patients PAT inner join ((select PV.pa_id from patient_vitals PV inner join patient_procedures PP
	                on PV.pa_id=PP.pa_id where dg_id = '+@dgid+' and PV.record_date between DATEADD(month,-6,PP.date_performed) and 
                     PP.date_performed and pa_bmi >= 18.5 and pa_bmi < 25 AND PV.pa_id in ('+@PatientIds+') group by PV.pa_id 
                 ) UNION (select PV.pa_id from patient_vitals PV inner join patient_procedures PP on PV.pa_id=PP.pa_id 
                 inner join patient_active_diagnosis PAD on PV.pa_id=PAD.pa_id where dg_id = '+@dgid+'
                 and PV.pa_id in ('+@PatientIds+') AND 
                 PV.record_date between DATEADD(month,-6,PP.date_performed) and PP.date_performed and 
                  not(pa_bmi >= 18.5 and pa_bmi < 25) and PAD.icd9 in (select CODE from NQF_codes NQF where NQF.NQF_id=0421 
                 and NQF.code_type=''ICD-9'' and criteriatype=''NUM1'' and criteria=1 AND IsActive=1) group by PV.pa_id))PP on PAT.pa_id=PP.pa_id';
    exec(@query)                              
END TRY
	  BEGIN CATCH
	   DECLARE @bkErrorMessage AS NVARCHAR(4000),@bkErrorSeverity AS INT,@bkErrorState AS INT;
		SELECT 
			@bkErrorMessage = ERROR_MESSAGE(),
			@bkErrorSeverity = ERROR_SEVERITY(),
			@bkErrorState = ERROR_STATE();
		RAISERROR (@bkErrorMessage, -- Message text.
				   @bkErrorSeverity, -- Severity.
				   @bkErrorState -- State.
				   );
						   
	  END CATCH                     
                     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
