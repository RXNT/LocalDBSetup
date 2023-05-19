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

CREATE     PROCEDURE [dbo].[GetRxChangeRequestInfoById] --[dbo].[GetRxChangeRequestInfoById]  10459,65647610
	@ChangeRequestInfoId BIGINT, 
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT RCI.ChgReqInfoId,RCI.ChgReqId,RCI.DrugName, RCI.Dosage1 dosage,RCI.DrugNDC NDC,RCI.Comments1 Comments,RCI.Refills numb_refills,CAST(ISNULL(RCI.SubstitutionCode,0) AS BIT)use_generic,
	ISNULL(RCI.Qty1,'') AS duration_amount,ISNULL(RCI.Qty1Units,'') duration_unit,RCI.DaysSupply days_supply
    FROM erx.RxChangeRequestsInfo RCI WITH(READPAST)
	WHERE RCI.ChgReqInfoId = @ChangeRequestInfoId

	RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
