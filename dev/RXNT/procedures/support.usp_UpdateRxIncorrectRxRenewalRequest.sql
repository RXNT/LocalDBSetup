SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[usp_UpdateRxIncorrectRxRenewalRequest] 
@RefillRequestId BIGINT,
@RxId BIGINT,
@RxDetailId BIGINT,
@OldDrugId BIGINT,
@OldDrugName VARCHAR(150),
@OldDrugNDC VARCHAR(30),
@OldDrugLevel INT=NULL,
@d_drug_ndc VARCHAR(30),
@d_drug_name VARCHAR(150),
@d_drug_level INT=NULL,
@p_drug_ndc VARCHAR(30),
@p_drug_name VARCHAR(150),
@p_drug_level INT=NULL,
@RxNTDrugCategory INT,
@DoctorGroupId BIGINT
AS
BEGIN
    DECLARE @d_drug_id BIGINT
    DECLARE @d_fdb_drug_name VARCHAR(150)
    DECLARE @is_incorrect BIT
    DECLARE @is_p_dugname_matches BIT
    IF LEN(@d_drug_ndc)>0
	BEGIN
		 SELECT @d_drug_id=DrugId,@d_fdb_drug_name = DrugName  FROM [eRx2019].[ufn_GetDrugDetailsByNDC](@d_drug_ndc)
	END
	
	IF ISNULL(@d_drug_id,0)=0
	BEGIN
		 SELECT @d_drug_id=DrugId,@d_fdb_drug_name = DrugName FROM [eRx2019].[ufn_GetDrugDetailsByName](@d_drug_name)
	END  
	
	IF ISNULL(@d_drug_id,0)=0 AND @RxNTDrugCategory IN (1,2)-- 1 : Compound Drug, 2: Supplies
	BEGIN 
		EXECUTE @d_drug_id = addDocGroupFreeTextMeds @added_by_dr_id=lngDoctorId,@dg_id=lngDgId,@drug_name=@d_drug_name,@drug_level=@d_drug_level,@drug_category=@RxNTDrugCategory
		IF(@d_drug_id < 0)
			SET @d_drug_id = 0;
	END
	
	DECLARE @p_drug_id BIGINT
    DECLARE @p_fdb_drug_name VARCHAR(150)
    IF LEN(@p_drug_ndc)>0
	BEGIN
		 SELECT @p_drug_id=DrugId,@p_fdb_drug_name = DrugName  FROM [eRx2019].[ufn_GetDrugDetailsByNDC](@p_drug_ndc)
	END
	
	IF ISNULL(@p_drug_id,0)=0
	BEGIN
		 SELECT @p_drug_id=DrugId,@p_fdb_drug_name = DrugName FROM [eRx2019].[ufn_GetDrugDetailsByName](@p_drug_name)
	END  
	
	IF ISNULL(@p_drug_id,0)=0 AND @RxNTDrugCategory IN (1,2)-- 1 : Compound Drug, 2: Supplies
	BEGIN 
		EXECUTE @p_drug_id = addDocGroupFreeTextMeds @added_by_dr_id=lngDoctorId,@dg_id=lngDgId,@drug_name=@p_drug_name,@drug_level=@p_drug_level,@drug_category=@RxNTDrugCategory
		IF(@p_drug_id < 0)
			SET @p_drug_id = 0;
	END
	SET @is_incorrect=1
	IF LTRIM(RTRIM(@OldDrugName)) = LTRIM(RTRIM(@p_drug_name))
	BEGIN
		SET @is_p_dugname_matches=1
		IF @OldDrugId= @p_drug_id
		BEGIN
			SET @is_incorrect=0
		END
	END
	
	IF LTRIM(RTRIM(@OldDrugName)) = LTRIM(RTRIM(@d_drug_name))
	BEGIN
		SET @is_p_dugname_matches=0
		IF @OldDrugId = @d_drug_id
		BEGIN
			SET @is_incorrect=0
		END
	END
    INSERT INTO [support].[refill_requests_ss_3357]
           ([refreq_id]
           ,[pres_id]
           ,[pd_id]
           ,[old_drug_id]
           ,[old_drug_name]
           ,[old_drug_ndc]
           ,[old_drug_level]
           ,[d_drug_id]
           ,[d_drug_name]
           ,[d_drug_ndc]
           ,[d_drug_level]
           ,[d_fdb_drug_name]
           ,[p_drug_id]
           ,[p_drug_name]
           ,[p_drug_ndc]
           ,[p_drug_level]
           ,[p_fdb_drug_name]
           ,[is_incorrect]
           ,[created_on]
           ,[is_corrected]
           ,[corrected_on]
           ,is_p_dugname_matches)
     VALUES
           (@RefillRequestId
           ,@RxId
           ,@RxDetailId
           ,@OldDrugId
           ,@OldDrugName
           ,@OldDrugNDC
           ,@OldDrugLevel
           ,@d_drug_id
           ,@d_drug_name
           ,@d_drug_ndc
           ,ISNULL(@d_drug_level,0)
           ,@d_fdb_drug_name
           ,@p_drug_id
           ,@p_drug_name
           ,@p_drug_ndc
           ,ISNULL(@p_drug_level,0)
           ,@p_fdb_drug_name
           ,@is_incorrect
           ,GETDATE()
           ,NULL
           ,NULL
           ,@is_p_dugname_matches)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
