SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Ramakrishna
-- Create date: 	24-Nov-2016
-- Description:		Removing group permissins
-- =============================================
CREATE PROCEDURE [dbo].[RemoveGroupPermissions]

	@dg_page_module_info_id		INT,
	@dg_action_id				INT,
	@dg_id						INT

AS
BEGIN

	Delete from doc_group_module_action where dg_page_module_info_id= @dg_page_module_info_id
	AND dg_action_id= @dg_action_id AND dg_id = @dg_id

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
