SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	08-June-2021
Description			:	
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE   PROCEDURE [ehr].[SearchChangeRxRequestedDrugs] --[ehr].[SearchChangeRxRequestedDrugs]  10459,65647610
	@ChgReqId BIGINT, 
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT RCI.ChgReqInfoId,RC.PresId pres_id,RCI.ChgReqId,RC.PatientId ,RCI.DrugName, RCI.Dosage1 dosage,RCI.DrugNDC NDC,RCI.Comments1 Comments,RCI.Refills numb_refills,CAST(ISNULL(RCI.SubstitutionCode,0) AS BIT)use_generic,
	RCI.Qty1 AS duration_amount,RCI.Qty1Units duration_unit,RCI.DaysSupply days_supply
    FROM erx.RxChangeRequestsInfo RCI WITH(READPAST)
	INNER JOIN erx.RxChangeRequests RC WITH(READPAST) ON RCI.ChgReqId=RC.ChgReqId
	WHERE RC.ChgReqId = @ChgReqId

	RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
