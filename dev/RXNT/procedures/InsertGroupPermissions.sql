SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Ramakrishna
-- Create date: 	24-Nov-2016
-- Description:		Inserting group permissins
-- =============================================
CREATE PROCEDURE [dbo].[InsertGroupPermissions]
	@dg_id					INT,			-- Doctor group id 
	@ModuleName				VARCHAR(50),    -- [dbo].[doc_group_module_info] => Name
	@PageName				VARCHAR(50),	-- dbo.doc_group_page_info => Name
	@ActionName				VARCHAR(50)		-- doc_group_actions = Name
AS
BEGIN		
	DECLARE @dg_module_info_id INT
	DECLARE @dg_page_info_id INT
	DECLARE @dg_action_id INT
	SELECT @dg_module_info_id=dg_module_info_id FROM [dbo].[doc_group_module_info] WHERE name=@ModuleName AND active=1
	IF ISNULL(@dg_module_info_id,0) = 0
	BEGIN
		PRINT ISNULL(@ModuleName,'@ModuleName')+' Not Found.'

	END	
	
	SELECT @dg_page_info_id=A.dg_page_info_id FROM dbo.doc_group_page_info A INNER JOIN doc_group_page_module_info B ON A.dg_page_info_id=B.dg_page_info_id WHERE A.name= @PageName AND B.dg_module_info_id=@dg_module_info_id AND A.active=1 AND B.active=1
	
	IF ISNULL(@dg_page_info_id,0) = 0
	BEGIN
		PRINT ISNULL(@PageName,'@PageName')+' Not Found.'
	END	
	 
	SELECT @dg_action_id=dg_action_id FROM dbo.doc_group_actions WHERE name= @ActionName 
	IF ISNULL(@dg_page_info_id,0) = 0
	BEGIN
		PRINT ISNULL(@PageName,'@PageName')+' Not Found.'

	END	
	
	IF @dg_id>0 AND @dg_page_info_id>0 AND @dg_action_id>0
	BEGIN
		IF NOT EXISTS(SELECT * FROM dbo.[doc_group_module_action] WHERE [dg_id]=@dg_id AND dg_page_module_info_id= @dg_page_info_id  AND dg_action_id=@dg_action_id)
		BEGIN
			INSERT INTO [dbo].[doc_group_module_action]
			(	[dg_page_module_info_id]
				,[dg_action_id]
				,[dg_id]
				,[active]
				,[CreatedBy]
				,[CreatedOn])
					 
			VALUES
			(	@dg_page_info_id
				,@dg_action_id
				,@dg_id
				,1
				,1
				,GETDATE())
		END 
		ELSE
		BEGIN
			UPDATE [dbo].[doc_group_module_action] SET active=1  WHERE [dg_id]=@dg_id AND dg_page_module_info_id= @dg_page_info_id  AND dg_action_id=@dg_action_id
		END
	END
	
	 
	 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
