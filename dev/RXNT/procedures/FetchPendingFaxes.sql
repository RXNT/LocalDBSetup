SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 2007/12/17
-- Description:	Fetch Pending Faxes
-- =============================================
CREATE PROCEDURE [dbo].[FetchPendingFaxes]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	SELECT TOP 25 pt_id,A.pd_id,A.pres_id, pharm_fax, pharm_state,MAX(transmission_flags) transmission_flags, MAX(case when (B.DG_ID=19303 Or B.dg_id=3280) Then 'BHCS.tif' Else '' End)attachfile, MAX(PD.SAMPLE_ID) SAMPLE_ID, MAX(PD.VOUCHER_ID) VOUCHER_ID, B.DG_ID
	FROM prescription_transmittals A WITH(NOLOCK) 
	INNER JOIN prescriptions B WITH(NOLOCK) ON A.pres_id = B.pres_id 
	INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id 
	inner join prescription_details PD WITH(NOLOCK) on B.pres_id=PD.pres_id 
	WHERE send_date IS NULL AND response_date is NULL AND pharm_fax IS NOT NULL AND LEN(pharm_fax) > 5 
	AND pharm_fax <> '000-000-0000' 
	AND queued_date > DATEADD(dd, -1, getdate())
	AND delivery_method = 1  
	GROUP BY pt_id,A.pd_id,A.pres_id,B.dg_id, pharm_fax,pharm_state 
	ORDER BY A.pres_id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
