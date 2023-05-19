SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
  
  
  
  
  
  
  
  
  
  
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 2016/06/207 
-- Description: Load the epa details 
-- =============================================  
CREATE  PROCEDURE [dbo].[SS_LoadEPAInfo]  -- SS_LoadEPAInfo 9161,31197
 @DoctorId BIGINT,  
 @QuantityUnit VARCHAR(50), 
 @DrugId BIGINT ,
 @PatientId BIGINT 
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		DECLARE @RxNormCode VARCHAR(50)
		DECLARE @NDC VARCHAR(25)
		DECLARE @RxNormCodeType VARCHAR(50)
		
		DECLARE @PotencyUnitCode VARCHAR(50)
		
		DECLARE @SPI_ID VARCHAR(50)
		
		SELECT TOP 1 @PotencyUnitCode = potency_unit_code  FROM duration_units WITH(NOLOCK) WHERE du_text = @QuantityUnit
		SELECT TOP 1 @SPI_ID =spi_id  FROM doctors WITH(NOLOCK) WHERE dr_id = @DoctorId
		
				
		IF EXISTS(select TOP 1 * from RMIID1 where MEDID=@DrugId AND med_ref_gen_drug_name_cd=2) --is Brand
		BEGIN
			SELECT TOP 1 @RxNormCodeType = EVD_EXT_VOCAB_TYPE_ID, @RxNormCode = EVD_EXT_VOCAB_ID
			FROM 
			REVDEL0 R1 WITH(NOLOCK) inner join REVDVT0 R2 WITH(NOLOCK) on 
			R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID INNER JOIN RMIID1 R3 ON EVD_FDB_VOCAB_ID = R3.MEDID where 
			EVD_FDB_VOCAB_TYPE_ID=3 AND EVD_EXT_VOCAB_TYPE_ID in (502,504,505)  AND EVD_FDB_VOCAB_ID = @DrugId AND R3.med_ref_gen_drug_name_cd =  2 
		END
		ELSE
		BEGIN
			SELECT TOP 1 @RxNormCodeType   = EVD_EXT_VOCAB_TYPE_ID,@RxNormCode = EVD_EXT_VOCAB_ID
			FROM REVDEL0 R1 WITH(NOLOCK) inner join REVDVT0 R2 WITH(NOLOCK) on 
			R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID 
			WHERE EVD_FDB_VOCAB_TYPE_ID=3 AND EVD_EXT_VOCAB_TYPE_ID in (501,503) AND EVD_FDB_VOCAB_ID = @DrugId 
		END
		SELECT TOP 1 @NDC = RNM.NDC--,LN25,MED_STRENGTH,MED_STRENGTH_UOM,MED_REF_DEA_CD 
		FROM RNMMIDNDC RNM WITH(NOLOCK)
		WHERE RNM.MEDID=@DrugId
		
		
		
		SELECT @PotencyUnitCode AS PotencyUnitCode,
			@SPI_ID AS SPI_ID,
			CASE 
				WHEN @RxNormCodeType = '501' THEN  'SCD'
				WHEN @RxNormCodeType = '502' THEN  'SBD'
				WHEN @RxNormCodeType = '503' THEN  'GPK'
				WHEN @RxNormCodeType = '504' THEN  'BPK'
			END AS RxNormCodeType,
			@RxNormCode AS RxNormCode,
			@NDC AS NDC
	RETURN
END



















  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
