SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetRxNormCodeByNDC] 
( 
	@NDC VARCHAR(50)
) 
RETURNS @Output TABLE(NDC VARCHAR(50),NDCRxNormCode VARCHAR(50),NDCRxNormCodeTypeId INT,NDCRxNormCodeType VARCHAR(50))
BEGIN 
	DECLARE @NDCRxNormCode VARCHAR(50),@NDCRxNormCodeTypeId INT,@NDCRxNormCodeType VARCHAR(50)
	DECLARE @evd_ext_vocab_id VARCHAR(50),@evd_ext_vocab_type_id VARCHAR(50),@evd_vocab_type_desc VARCHAR(50),@evd_fdb_vocab_id VARCHAR(50)

	SELECT TOP 1  @evd_ext_vocab_type_id = evd_ext_vocab_type_id,@evd_vocab_type_desc = r2.evd_vocab_type_desc,@evd_ext_vocab_id=evd_ext_vocab_id,@evd_fdb_vocab_id =evd_fdb_vocab_id 
		FROM revdel0 r1 WITH(NOLOCK) 
		INNER JOIN revdvt0 r2 WITH(NOLOCK) ON r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id 
		WHERE evd_fdb_vocab_type_id=100  AND evd_fdb_vocab_id like @NDC
		AND EVD_LINK_TYPE_ID = 4
	     
    IF @evd_ext_vocab_id IS NOT NULL
    BEGIN
        SET @NDCRxNormCode = @evd_ext_vocab_id;
    END
    SET @NDCRxNormCodeTypeId=-1

    IF (LEN(ISNULL(@NDCRxNormCode,''))>0 AND @evd_ext_vocab_type_id IS NOT NULL)
	BEGIN

        IF @evd_ext_vocab_type_id='501'
        BEGIN
			SET @NDCRxNormCodeTypeId=0;
            SET @NDCRxNormCodeType = 'SCD';
		END
        ELSE IF @evd_ext_vocab_type_id='502'
        BEGIN
			SET @NDCRxNormCodeTypeId=1;
			SET @NDCRxNormCodeType = 'SBD'; 
        END   
		ELSE IF @evd_ext_vocab_type_id='503'
		BEGIN
			SET @NDCRxNormCodeTypeId=3;
			SET @NDCRxNormCodeType = 'GPK'; 
		END
        ELSE IF @evd_ext_vocab_type_id='504'
        BEGIN
			SET @NDCRxNormCodeTypeId=2;
			SET @NDCRxNormCodeType = 'BPK';
		END
    END
    INSERT INTO @Output (NDC,NDCRxNormCode,NDCRxNormCodeTypeId,NDCRxNormCodeType)  
	VALUES (@NDC,@NDCRxNormCode,@NDCRxNormCodeTypeId,@NDCRxNormCodeType)
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
