SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the patient Coverage Transaction Id
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadRxNormCodesForPrescription]
	@ddid BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	IF EXISTS(select TOP 1 * from RMIID1 where MEDID=@ddid AND med_ref_gen_drug_name_cd=2)
		BEGIN 
			select TOP 1 EVD_EXT_VOCAB_TYPE_ID,R2.EVD_VOCAB_TYPE_DESC,EVD_EXT_VOCAB_ID,EVD_FDB_VOCAB_ID from  
			REVDEL0 R1 WITH(NOLOCK) inner join REVDVT0 R2 WITH(NOLOCK) on  
			R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID INNER JOIN RMIID1 R3 ON EVD_FDB_VOCAB_ID = R3.MEDID where  
			EVD_FDB_VOCAB_TYPE_ID=3 AND EVD_EXT_VOCAB_TYPE_ID in (502,504,505)  AND EVD_FDB_VOCAB_ID = @ddid AND R3.med_ref_gen_drug_name_cd =  2
		END 
		ELSE 
		BEGIN 
			SELECT TOP 1 EVD_EXT_VOCAB_TYPE_ID,R2.EVD_VOCAB_TYPE_DESC,EVD_EXT_VOCAB_ID,EVD_FDB_VOCAB_ID from REVDEL0 R1 WITH(NOLOCK) inner join REVDVT0 R2 WITH(NOLOCK) on  
			R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID where EVD_FDB_VOCAB_TYPE_ID=3 AND EVD_EXT_VOCAB_TYPE_ID in (501,503) AND EVD_FDB_VOCAB_ID = @ddid
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
