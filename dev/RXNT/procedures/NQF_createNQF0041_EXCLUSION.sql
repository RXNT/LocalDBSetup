SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0041_EXCLUSION]
    @doctorid BIGINT , 
	@startdate DATETIME ,
	@enddate DATETIME 
AS
BEGIN
BEGIN TRY
	select count(distinct PAT.pa_id)SM from patients PAT inner join 
                     ((select pa_id from patient_procedures PP INNER JOIN NQF_Codes NQF on PP.code=NQF.code 
                     where NQF.NQF_id='0041' and NQF.code_type='CPT' and criteriatype='POP1' and criteria=1 
                     and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid AND ((PP.date_performed between 
                     @startdate AND @enddate)) 
                     group by pa_id having count(pa_id) > 0) union (select pa_id from patient_procedures PP INNER JOIN NQF_Codes NQF on PP.code=NQF.code 
                     where NQF.NQF_id='0041' and NQF.code_type='CPT' and criteriatype='POP1' and criteria=2 
                     and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid AND PP.date_performed between 
                     @startdate AND @enddate 
                     group by pa_id having count(pa_id) > 2))PPC on PAT.pa_id=PPC.pa_id inner join patient_new_allergies PAA on PAT.pa_id=PAA.pa_id 
                     inner join patient_procedures PP on PAT.pa_id=PP.pa_id 
                     where datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 50*12 and 
                     not (pa_dob like '1901-01-01') AND PAA.allergy_type=1 and PAA.allergy_id in 
                     (SELECT CODE FROM NQF_CODES where IsActive=1 AND IsExclude=1 AND NQF_id='0041' AND criteriatype='EXCL' AND 
                     code_type='ALLERGEN1') AND PP.date_performed between 
                     @startdate AND @enddate AND PP.CODE 
                     in (select code from NQF_Codes where NQF_id='0041' and  code_type='CPT' 
                     and IsActive = 1 and criteria = 3 and criteriatype = 'POP1');
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
