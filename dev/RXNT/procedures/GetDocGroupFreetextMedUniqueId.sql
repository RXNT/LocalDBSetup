SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kalimuthu
-- Create date: 2019/11/07
-- Description:	get doctor group free text medication unique id
-- =============================================
CREATE PROCEDURE [dbo].[GetDocGroupFreetextMedUniqueId]

	@DrugId BIGINT = NULL,
	@DGId BIGINT = NULL

AS
BEGIN
	SET NOCOUNT ON;
	if ISNULL(@DrugId,0) > 0
		Begin
			select top 1 dgfm_id from doc_group_freetext_meds with(nolock) where dg_id=@DGId and drug_id=@DrugId; 
		End
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
