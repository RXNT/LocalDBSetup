SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0001_DEN]
    @doctorid BIGINT , 
	@startdate DATETIME ,
	@enddate DATETIME 
AS
BEGIN
BEGIN TRY
	select count(distinct PAT.pa_id)SM from patients PAT inner join 
                     (select pa_id from patient_procedures PP INNER JOIN NQF_Codes NQF on PP.code=NQF.code 
                     where NQF.NQF_id='0001' and NQF.code_type='CPT' and criteriatype='POP1' and criteria=1 
                     and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid AND PP.date_performed between 
                     @startdate AND @enddate 
                     group by pa_id having count(pa_id) > 1)PPC on PAT.pa_id=PPC.pa_id INNER JOIN PATIENT_ACTIVE_DIAGNOSIS PAD ON PAT.PA_ID=PAD.PA_ID 
                     where datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 5*12 and 
                     datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) <= 40*12 AND not (pa_dob like '1901-01-01') 
                     AND PAD.ICD9 IN (select code from NQF_CODES where IsActive=1 AND IsExclude=0 AND NQF_id='0001' AND criteriatype='POP1' AND code_type='icd-9' ) AND PAD.type=1 and PAD.enabled=1 ;
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
