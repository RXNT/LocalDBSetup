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

CREATE   PROCEDURE [prv].[SaveSelectedChangeRxRequestedDrug]
	@ChgReqId BIGINT, 
	@ChgReqInfoId BIGINT=NULL,
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	IF ISNULL(@ChgReqInfoId,0)>0
	BEGIN
		DECLARE @RxId BIGINT
		DECLARE @DrugName VARCHAR(1000) 
		DECLARE @Dosage VARCHAR(1000)
		DECLARE @NDC VARCHAR(50) 
		DECLARE @DrugId BIGINT
		DECLARE @DrugLevel INT
		DECLARE @DoctorGroupId INT
		DECLARE @IsUseGeneric BIT
		DECLARE @NoOfRefills INT
		DECLARE @Comments VARCHAR(1000)
		DECLARE @DaysSupply INT
		DECLARE @DurationAmount VARCHAR(1000)
		DECLARE @DurationUnit VARCHAR(1000)
		SELECT @RxId=RC.presid,@DrugName=RCI.DrugName,@NDC=RCI.DrugNDC,@Dosage=RCI.Dosage1,@DoctorGroupId=dr.dg_id,@NoOfRefills=RCI.Refills,@Comments=RCI.Comments1
		,@IsUseGeneric=CAST(ISNULL(RCI.SubstitutionCode,0) AS BIT),@DaysSupply=RCI.DaysSupply
		--,@DrugLevel=RCI.DrugLevel
		--,RCI.ChgReqInfoId,RC.PresId pres_id,RCI.ChgReqId,RC.PatientId ,  RCI.Comments1 Comments,0 DRUGLEVEL,RCI.Refills numb_refills,CAST(0 AS BIT)use_generic,
		,@DurationAmount=RCI.Qty1,@DurationUnit=RCI.Qty1Units
		FROM erx.RxChangeRequestsInfo RCI WITH(NOLOCK)
		INNER JOIN erx.RxChangeRequests RC WITH(NOLOCK) ON RCI.ChgReqId=RC.ChgReqId 
		INNER JOIN prescriptions pres WITH(NOLOCK) ON pres.pres_id=RC.PresId 
		INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=pres.dr_id 
		WHERE RC.ChgReqId = @ChgReqId AND RCI.ChgReqInfoId= @ChgReqInfoId


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
			SET @DrugLevel =ISNULL(@DrugLevel,0)
			EXECUTE @DrugId = addDocGroupFreeTextMeds @added_by_dr_id=-2,@dg_id=@DoctorGroupId,@drug_name=@DrugName,@drug_level=@DrugLevel,@drug_category=@RxNTDrugCategory
			IF(@DrugId < 0)
				SET @DrugId = 0;
		END
		UPDATE prescription_details 
		SET drug_name = @DrugName, ddid =  @DrugId , dosage = @Dosage,  use_generic = @IsUseGeneric , numb_refills =  @NoOfRefills , comments = ISNULL(@Comments,''), days_supply =  @DaysSupply  ,
		NDC=@NDC,duration_amount = ISNULL(@DurationAmount,''), duration_unit = ISNULL(@DurationUnit,'')
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
