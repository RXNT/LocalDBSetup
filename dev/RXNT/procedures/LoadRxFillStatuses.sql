SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   PROCEDURE [dbo].[LoadRxFillStatuses]
@pres_Id BIGINT,
@pa_id BIGINT

AS
BEGIN
    SET NOCOUNT ON
    SELECT FillReqId, Note, Reason, ResponseType, RequestDate
	FROM  [erx].[RxFillRequests] WITH(NOLOCK)
	WHERE PatientId=@pa_id AND PrescriberOrderNumber=@pres_Id
	ORDER BY FillReqId DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
