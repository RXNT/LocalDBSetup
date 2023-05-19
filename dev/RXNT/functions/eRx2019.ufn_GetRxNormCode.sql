SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetRxNormCode] 
( 
    @DrugId BIGINT
) 
RETURNS @Output TABLE(DrugId BIGINT,RxNormCode VARCHAR(50),RxNormCodeTypeId INT,RxNormCodeType VARCHAR(50))
BEGIN 
	DECLARE @RxNormCode VARCHAR(50),@RxNormCodeTypeId INT,@RxNormCodeType VARCHAR(50)
	DECLARE @evd_ext_vocab_id VARCHAR(50),@evd_ext_vocab_type_id VARCHAR(50),@evd_vocab_type_desc VARCHAR(50),@evd_fdb_vocab_id VARCHAR(50)
	IF EXISTS(SELECT TOP 1 * FROM rmiid1 WHERE medid=@DrugId AND med_ref_gen_drug_name_cd=2) --//is Brand
	BEGIN
		SELECT TOP 1 @evd_ext_vocab_type_id = evd_ext_vocab_type_id,@evd_vocab_type_desc = r2.evd_vocab_type_desc,@evd_ext_vocab_id=evd_ext_vocab_id,@evd_fdb_vocab_id =evd_fdb_vocab_id 
		FROM  revdel0 r1 WITH(NOLOCK) 
		INNER JOIN revdvt0 r2 WITH(NOLOCK) ON r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id 
		INNER JOIN rmiid1 r3 WITH(NOLOCK)  ON evd_fdb_vocab_id = r3.medid 
		WHERE evd_fdb_vocab_type_id=3 
		AND evd_ext_vocab_type_id IN (502,504,505)  
		AND evd_fdb_vocab_id = @DrugId 
		AND R3.med_ref_gen_drug_name_cd =  2 
	END 
	ELSE
	BEGIN
		SELECT TOP 1 @evd_ext_vocab_type_id=evd_ext_vocab_type_id,@evd_vocab_type_desc =r2.evd_vocab_type_desc,@evd_ext_vocab_id = evd_ext_vocab_id,@evd_fdb_vocab_id=evd_fdb_vocab_id 
		FROM revdel0 r1 WITH(NOLOCK) 
		INNER JOIN revdvt0 r2 WITH(NOLOCK) ON r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id 
		WHERE evd_fdb_vocab_type_id=3 AND evd_ext_vocab_type_id in (501,503) AND evd_fdb_vocab_id = @DrugId
	END
	     
    IF @evd_ext_vocab_id IS NOT NULL
    BEGIN
        SET @RxNormCode = @evd_ext_vocab_id;
    END
    SET @RxNormCodeTypeId=-1
    IF (LEN(ISNULL(@RxNormCode,''))>0 AND @evd_ext_vocab_type_id IS NOT NULL)
	BEGIN

        IF @evd_ext_vocab_type_id='501'
        BEGIN
			SET @RxNormCodeTypeId=0;
            SET @RxNormCodeType = 'SCD';
		END
        ELSE IF @evd_ext_vocab_type_id='502'
        BEGIN
			SET @RxNormCodeTypeId=1;
			SET @RxNormCodeType = 'SBD'; 
        END   
		ELSE IF @evd_ext_vocab_type_id='503'
		BEGIN
			SET @RxNormCodeTypeId=3;
			SET @RxNormCodeType = 'GPK'; 
		END
        ELSE IF @evd_ext_vocab_type_id='504'
        BEGIN
			SET @RxNormCodeTypeId=2;
			SET @RxNormCodeType = 'BPK';
		END
    END
    INSERT INTO @Output (DrugId,RxNormCode,RxNormCodeTypeId,RxNormCodeType)  
	VALUES (@DrugId,@RxNormCode,@RxNormCodeTypeId,@RxNormCodeType)
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
