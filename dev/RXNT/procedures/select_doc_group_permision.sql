SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 
-- Description:	To get the doctor group permission
-- =============================================
CREATE PROCEDURE select_doc_group_permision 
	@dg_id BIGINT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    
	SELECT ma.dg_module_action_id,
		mi.dg_module_info_id,
		mi.name AS dg_module_info_name,
		pin.dg_page_info_id,
		pin.name AS dg_page_info_name,
		a.dg_action_id,
		a.name AS dg_action_name 
	FROM doc_group_module_action ma WITH(NOLOCK)
	INNER JOIN doc_group_page_module_info	pmi	ON pmi.dg_page_module_info_id = ma.dg_page_module_info_id
	INNER JOIN doc_group_module_info		mi	ON mi.dg_module_info_id =pmi.dg_module_info_id
	INNER JOIN doc_group_page_info			pin	ON pin.dg_page_info_id =pmi.dg_page_info_id
	INNER JOIN doc_group_actions			a	ON a.dg_action_id =ma.dg_action_id
	WHERE ma.dg_id = @dg_id 
	AND pmi.active=1 
	AND ma.active=1  
	AND pin.active=1 
	AND mi.active=1 
	AND a.active=1 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
