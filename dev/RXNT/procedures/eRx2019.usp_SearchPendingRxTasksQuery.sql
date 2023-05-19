SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 12/11/2021
-- Description: Fetch all pending epa prescriptions
-- Modified By : 
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_SearchPendingRxTasksQuery]
 
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT TOP 200 A.pd_id RxDetailId,A.pres_id RxId,A.PAReferenceId
	FROM prescription_details A WITH (NOLOCK) 
	INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
	INNER JOIN RNMMIDNDC RNM WITH(NOLOCK) ON RNM.MEDID=A.DDID 
	LEFT OUTER JOIN prescription_tasks_auto_release tar  WITH (NOLOCK) ON tar.pd_id = A.pd_id 
	WHERE  B.pres_approved_date IS NULL 
	AND A.PAReferenceId IS NOT NULL
	AND B.pres_entry_date > getdate()-1 
	AND B.pharm_id>0
	AND B.pres_delivery_method=262144
	AND tar.performed_on IS NULL
	AND B.pres_prescription_type=1 
	AND ISNULL(med_ref_dea_cd,0)<2
	ORDER BY A.pres_id 

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
