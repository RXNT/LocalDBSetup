SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0038_DEN]
    @doctorid BIGINT,
    @startdate datetime,
    @enddate datetime  
AS
BEGIN
BEGIN TRY
  SELECT distinct PAT.PA_ID FROM PATIENTS PAT INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID INNER JOIN
                 NQF_CODES NQF ON PP.CODE=NQF.CODE where PP.DR_ID=@doctorid and date_performed between
                  @startdate AND @enddate and nqf_id='0038' and nqf.isactive=1 and nqf.code_type='CPT'
                   AND nqf.criteriatype='DENOM' and datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 1*12 and
                     datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) < 2*12 AND not (pa_dob like '1901-01-01')                         
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
