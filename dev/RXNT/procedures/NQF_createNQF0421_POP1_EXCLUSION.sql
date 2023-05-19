SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0421_POP1_EXCLUSION]
    @PatientIds varchar(max)  
AS
BEGIN
BEGIN TRY
    declare @query varchar(max);
	set @query ='select count(distinct PAT.pa_id)SM from patients PAT inner join ((select pa_id from patient_active_diagnosis 
                     where pa_id in ('+@PatientIds+') and icd9 in (select code from NQF_codes NQF where NQF_id=0421 
                     and NQF.code_type=''ICD-9'' and criteriatype=''EXCL'' and criteria=1 AND IsActive=1)) UNION 
                     (select pa_id from patient_flag_details where pa_id in ('+@PatientIds+') AND 
                     flag_id in (14,15)))PP on PAT.pa_id=PP.pa_id'; 
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
