SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  PROCEDURE [support].[usp_SearchIncorrectRxRenewalRequestQuery]
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Participant INT=262144,  
	@MaxRetryCount INT=3,
	@version VARCHAR(50)='v6.1'
	DECLARE @refreq_date_start DATETIME =CAST('2019-12-30 06:16:35.873' AS DATETIME)
	DECLARE @refreq_date_end DATETIME= CAST('2020-02-08' AS DATETIME)
	SELECT TOP 50 RQ.refreq_id RefillRequestId,RQ.pres_id RxId,pd.pd_id RxDetailId--,pd.ddid OldDrugId,pd.drug_name OldDrugName
	FROM  refill_requests RQ WITH(NOLOCK)
	INNER JOIN PRESCRIPTIONS P WITH(NOLOCK) ON RQ.PRES_ID = P.PRES_ID
	INNER JOIN patients PAT WITH(NOLOCK) ON PAT.pa_id = P.pa_id
	INNER JOIN prescription_details pd WITH(NOLOCK) ON P.pres_id = pd.pres_id
	LEFT OUTER JOIN SUPPORT.refill_requests_ss_3357 RQB  WITH(NOLOCK) ON RQ.refreq_id=RQB.refreq_id
	WHERE p.PRES_ENTRY_DATE >=@refreq_date_start AND p.PRES_ENTRY_DATE<@refreq_date_end  AND RQ.versionType=@version
	AND RQB.refreq_id IS NULL


	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
