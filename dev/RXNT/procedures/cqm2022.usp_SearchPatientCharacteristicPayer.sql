SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	04-DEC-2022
-- Description:		Search QRDA Patient Case Payer
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SearchPatientCharacteristicPayer]
  @PatientId			BIGINT
AS
BEGIN
	
	SELECT cp.medicare_type_code AS Code, cp.effective_start_date AS PerformedFromDate, cp.effective_end_date AS PerformedToDate
	FROM RxNTBilling.dbo.case_payers cp WITH(NOLOCK)
	INNER JOIN RxNTBilling.dbo.cases c WITH(NOLOCK) ON cp.case_id=c.case_id
	WHERE c.pa_id=@PatientId AND c.active=1
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
