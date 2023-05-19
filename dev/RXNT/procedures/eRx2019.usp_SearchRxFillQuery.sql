SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SearchRxFillQuery]
@RxId BIGINT,
@PatientId BIGINT
AS
BEGIN
    SET NOCOUNT ON
    
	SELECT pt.pt_id RxTransmitalid, 'NEWRX-1-' + CAST(pt.pt_id AS VARCHAR(50)) AS RelatesToMessageID,
	pt.pd_id RxDetailId, pt.pres_id RxId,ph.ncpdp_numb AS PharmacyNCPDP
	FROM prescription_transmittals pt WITH(NOLOCK)
	INNER JOIN prescriptions pres WITH(NOLOCK) ON pt.pres_id = pres.pres_id
	INNER JOIN pharmacies ph WITH(NOLOCK) ON ph.pharm_id = pres.pharm_id
	WHERE pres.PRES_ID =  @RxId AND pres.pa_id=@PatientId;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
