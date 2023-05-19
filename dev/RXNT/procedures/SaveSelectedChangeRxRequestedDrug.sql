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

CREATE     PROCEDURE [dbo].[SaveSelectedChangeRxRequestedDrug]
	@ChgReqInfoId BIGINT=NULL,
	@PatientId BIGINT
AS
BEGIN
	IF ISNULL(@ChgReqInfoId,0)>0
	BEGIN
		DECLARE @RxId BIGINT
		DECLARE @ChgReqId BIGINT
		DECLARE @RxDetailId BIGINT
		DECLARE @DrugName VARCHAR(1000) 
		DECLARE @DrugLevel INT
		DECLARE @NDC VARCHAR(50) 
		DECLARE @DrugId BIGINT
		DECLARE @DoctorGroupId INT
		SELECT @ChgReqId=RCI.ChgReqId,@RxId=RC.presid,@DrugName=RCI.DrugName,@NDC=RCI.DrugNDC,@DoctorGroupId=dr.dg_id,@RxDetailId=pd.pd_id
		FROM erx.RxChangeRequestsInfo RCI WITH(NOLOCK)
		INNER JOIN erx.RxChangeRequests RC WITH(NOLOCK) ON RCI.ChgReqId=RC.ChgReqId 
		INNER JOIN prescriptions pres WITH(NOLOCK) ON pres.pres_id=RC.PresId 
		INNER JOIN prescription_details pd WITH(NOLOCK) ON pres.pres_id=pd.pres_id 
		INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=pres.dr_id 
		WHERE RCI.ChgReqInfoId= @ChgReqInfoId


		--SELECT * FROM prescriptions WHERE
		UPDATE erx.RxChangeRequests SET  ApprovedChgReqInfoId = @ChgReqInfoId WHERE ChgReqId = @ChgReqId

	
		IF LEN(@NDC)>0
		BEGIN
			 SELECT @DrugId=DrugId,@DrugLevel=DrugLevel  FROM [eRx2019].[ufn_GetDrugDetailsByNDC](@NDC) 
		END
	
	
		IF ISNULL(@DrugId,0)=0
		BEGIN
			 SELECT @DrugId=DrugId,@DrugName = DrugName,@DrugLevel=DrugLevel  FROM [eRx2019].[ufn_GetDrugDetailsByName](@DrugName)
		END  
		DECLARE @RxNTDrugCategory INT
		IF ISNULL(@DrugId,0)=0
		BEGIN
			 SET @RxNTDrugCategory=1
		END  
	
		IF ISNULL(@DrugId,0)=0 AND @RxNTDrugCategory IN (1,2)-- 1 : Compound Drug, 2: Supplies
		BEGIN
			IF @DrugLevel IS NULL
			BEGIN
				IF EXISTS(SELECT 1 FROM PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)WHERE PDIN.PD_ID=@RxDetailId AND PDIN.DDID>=1000000)
				BEGIN
					SELECT TOP 1  @DrugLevel=CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END 
					FROM RNMMIDNDC RNM WITH(NOLOCK) 
					INNER JOIN PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)			ON RNM.MEDID=PDIN.DDID 
					INNER JOIN PRESCRIPTIONS PRES_IN WITH(NOLOCK)			ON PDIN.pres_id=PRES_IN.pres_id 
					WHERE PDIN.PD_ID=@RxDetailId  
				END
				BEGIN
					SELECT TOP 1  @DrugLevel=CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END 
					FROM RNMMIDNDC RNM WITH(NOLOCK) 
					INNER JOIN PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)			ON RNM.MEDID=PDIN.DDID 
					INNER JOIN PRESCRIPTIONS PRES_IN WITH(NOLOCK)			ON PDIN.pres_id=PRES_IN.pres_id 
					WHERE PDIN.PD_ID=@RxDetailId AND RNM.OBSDTEC IS NULL
				END
			END
			EXECUTE @DrugId = addDocGroupFreeTextMeds @added_by_dr_id=-2,@dg_id=@DoctorGroupId,@drug_name=@DrugName,@drug_level=@DrugLevel,@drug_category=@RxNTDrugCategory
			IF(@DrugId < 0)
				SET @DrugId = 0;
		END
		UPDATE prescription_details 
		SET drug_name = @DrugName, ddid =  @DrugId , 
		NDC=@NDC 
		WHERE pres_id =  @RxId;
	END
	RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
