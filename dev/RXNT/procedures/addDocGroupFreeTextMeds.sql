SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addDocGroupFreeTextMeds]
@drug_name VARCHAR(200),
@drug_level INT,
@dg_id BIGINT,
@added_by_dr_id BIGINT,
@drug_category INT,
@GCN varchar(10) = null,
@RxNormCode VARCHAR(50) =  NULL,
@preferred_name BIT = NULL,
@dgfm_id int = NULL OUTPUT

AS
DECLARE @drug_id INT 

	IF LEN(ISNULL(@RxNormCode,''))=0
	BEGIN
	SELECT TOP 1 @drug_id=RM.MEDID , @dgfm_id=F.dgfm_id
	FROM 
		RNMMIDNDC RM WITH(NOLOCK)
		INNER JOIN RMIID1 R WITH(NOLOCK) ON RM.MEDID=R.MEDID 
		Inner Join doc_group_freetext_meds F WITH(NOLOCK) On RM.MEDID=F.drug_id 
		WHERE  
		med_name = @drug_name 
		AND dg_id=@dg_id 
		--AND  obsdtec is null
		And F.is_active=1
	END

IF ISNULL(@drug_id,0)<=0 -- If not exists in drug database 
BEGIN
		
		SELECT TOP 1 @drug_id=MAX(MEDID)+1 FROM RMIID1 WITH(NOLOCK) WHERE MEDID>999999
		
		IF ISNULL(@drug_id,0)<=999999
			SET @drug_id=1000000
		
		IF NOT EXISTS(SELECT TOP 1 1 FROM RMIID1 WITH(NOLOCK) WHERE MEDID=@drug_id)
			INSERT INTO RMIID1 
			(
				MEDID,MED_MEDID_DESC,ROUTED_DOSAGE_FORM_MED_ID,
				GCN_SEQNO,MED_GCNSEQNO_ASSIGN_CD,MED_NAME_SOURCE_CD,
				MED_REF_FED_LEGEND_IND,MED_REF_DEA_CD,MED_REF_MULTI_SOURCE_CD,
				MED_REF_GEN_DRUG_NAME_CD,MED_REF_GEN_COMP_PRICE_CD,
				MED_REF_GEN_SPREAD_CD,MED_REF_INNOV_IND,MED_REF_GEN_THERA_EQU_CD,
				MED_REF_DESI_IND,MED_REF_DESI2_IND,MED_STATUS_CD,GCN_STRING
			) 
			VALUES
			(
				@drug_id,@drug_name,0,0,0,0,0,@drug_level,0,0,0,0,0,0,0,0,0,@GCN
			)
		IF NOT EXISTS(SELECT TOP 1 1 FROM RNMMIDNDC WITH(NOLOCK) WHERE MEDID=@drug_id)
			INSERT INTO 
			RNMMIDNDC 
			(
				MEDID,med_name,MED_MEDID_DESC,obsdtec,NDC,
				MED_REF_DEA_CD,ROUTED_DOSAGE_FORM_MED_ID,med_routed_df_med_id_desc,
				ROUTED_MED_ID,MED_ROUTED_MED_ID_DESC,MED_NAME_ID,
				MED_NAME_TYPE_CD,MED_DOSAGE_FORM_ID,MED_DOSAGE_FORM_ABBR,
				MED_DOSAGE_FORM_DESC,MED_ROUTE_ID,MED_ROUTE_ABBR,MED_ROUTE_DESC,ETC_ID
			) 
			VALUES
			(
				@drug_id,@drug_name,@drug_name,GETDATE(),'',
				@drug_level,0,'',0,'',0,0,0,'','',0,'','',0
			)
		
		IF NOT EXISTS(SELECT TOP 1 1 FROM ACTIVE_DRUGS  WITH(NOLOCK) WHERE MEDID=@drug_id)	
			INSERT INTO ACTIVE_DRUGS(MEDID,is_active) Values(@drug_id,1)
	 
END

IF LEN (@RxNormCode)>0 AND @drug_id>0 AND NOT EXISTS(SELECT TOP 1 * FROM REVDEL0 WHERE  EVD_EXT_VOCAB_TYPE_ID in(501,502) AND EVD_EXT_VOCAB_ID=@RxNormCode AND EVD_FDB_VOCAB_ID = CAST( @drug_id AS VARCHAR(50)))
BEGIN
	INSERT INTO REVDEL0 (EVD_FDB_VOCAB_ID,EVD_FDB_VOCAB_TYPE_ID,EVD_EXT_VOCAB_ID,EVD_EXT_VOCAB_TYPE_ID,EVD_LINK_TYPE_ID)
	VALUES(CAST( @drug_id AS VARCHAR(50)),100,@RxNormCode,501,1) 
END

IF  @drug_id>999999
BEGIN 
	IF NOT EXISTS
		(SELECT TOP 1 1 FROM doc_group_fav_drugs WITH(NOLOCK) 
			WHERE dg_id=@dg_id AND drug_id=@drug_id
		)
	BEGIN
		INSERT INTO doc_group_fav_drugs(dg_id,added_by_dr_id,added_date,drug_id)
		VALUES(@dg_id,@added_by_dr_id,GETDATE(),@drug_id)
	END
	
	IF NOT EXISTS
		(SELECT TOP 1 1 FROM doc_group_freetext_meds WITH(NOLOCK) 
			WHERE dg_id=@dg_id AND drug_name=@drug_name AND is_active=1
		)
	BEGIN
		INSERT INTO doc_group_freetext_meds
			(dg_id,added_by_dr_id,added_date,drug_name,drug_id,drug_category,preferred_name,is_active)
		VALUES
			(@dg_id,@added_by_dr_id,GETDATE(),@drug_name,@drug_id,@drug_category,@preferred_name,1)		
		SET @dgfm_id=SCOPE_IDENTITY()
	END 
	--ELSE IF LEN(ISNULL(@RxNormCode,''))=0
	--	SET @drug_id=-1
		
	SELECT @drug_id
	RETURN @drug_id
END
ELSE IF LEN(ISNULL(@RxNormCode,''))=0
BEGIN
	SELECT -1 -- Already exists in drug database with the same name
	RETURN -1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
