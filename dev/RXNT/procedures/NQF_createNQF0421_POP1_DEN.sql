SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0421_POP1_DEN]
    @doctorid BIGINT , 
	@startdate DATETIME ,
	@enddate DATETIME 
AS
BEGIN
BEGIN TRY
	select distinct PAT.pa_id from patients PAT inner join 
                     (select pa_id from patient_procedures PP INNER JOIN NQF_Codes NQF on PP.code=NQF.code 
                     where NQF.NQF_id='0421' and NQF.code_type='CPT' and criteriatype='POP1' and criteria=1 
                     and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid AND PP.date_performed between 
                     @startdate AND @enddate group by pa_id having count(pa_id) >= 1)PPC on PAT.pa_id=PPC.pa_id 
                     where datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 65*12 and 
                     not (pa_dob like '1901-01-01');                 
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
