SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 07-Feb-2018
-- Description:	to save the permisiions of user
-- Modified	By: 
-- Modified Date : 
-- Description:	
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveRegisterUserPermission]
	@DocotorId			BIGINT,
	@UserPermissionList	XML,
	@CompanyId BIGINT
AS

BEGIN
	SET NOCOUNT ON; 
	SELECT  A.S.value('(PermissionId)[1]', 'BIGINT') AS 'PermissionId',						
			A.S.value('(Code)[1]', 'VARCHAR(50)') AS 'Code',
			A.S.value('(Permission)[1]', 'VARCHAR(50)') AS 'Permission',
			A.S.value('(IsSelected)[1]', 'BIT') AS 'IsSelected',
			0 AS IsProcessed		
	INTO #UserPermissionList			
	FROM @UserPermissionList.nodes('ArrayOfUserPermission/UserPermission') A(S);
	 
	DELETE FROM doc_security_group_members where dr_id=@DocotorId AND dsg_id IN (SELECT PermissionId FROM #UserPermissionList WHERE ISNULL(IsSelected,0)=0)
	
	INSERT INTO doc_security_group_members (dr_id, dsg_id) 
	SELECT @DocotorId,UPL.PermissionId
	FROM #UserPermissionList UPL WITH(NOLOCK)
	LEFT OUTER JOIN doc_security_group_members sgm WITH(NOLOCK) ON sgm.dr_id=@DocotorId AND UPL.PermissionId=sgm.dsg_id 
	WHERE UPL.IsSelected=1 AND sgm.dsgm_id IS NULL 
	
	DECLARE @dsg_id BIGINT
	DECLARE @IsSelected BIT
	DECLARE @SelectedRight BIGINT
	DECLARE @OldRights BIGINT
	DECLARE @NewRights BIGINT	
	
	SELECT @OldRights=rights FROM doctors WITH(NOLOCK) WHERE dr_id=@DocotorId
	
	SET @NewRights=@OldRights
	
	WHILE EXISTS(SELECT * FROM #UserPermissionList UPL WITH(NOLOCK) 
	INNER JOIN  doc_security_groups sg WITH(NOLOCK) ON UPL.PermissionId=sg.dsg_id WHERE IsProcessed=0 AND sg.rights>0 )
	BEGIN
		
		SELECT TOP 1 @dsg_id=UPL.PermissionId,@IsSelected=IsSelected,@SelectedRight=sg.rights
		FROM #UserPermissionList UPL WITH(NOLOCK) 
		INNER JOIN  doc_security_groups sg WITH(NOLOCK) ON UPL.PermissionId=sg.dsg_id 
		WHERE IsProcessed=0 AND sg.rights>0
		
		IF @SelectedRight=1 
		BEGIN
			SET @NewRights= @NewRights|@SelectedRight
		END
		ELSE 
		BEGIN
			SET @NewRights=@NewRights^@SelectedRight
		END
		
		UPDATE #UserPermissionList SET IsProcessed=1 
		WHERE IsProcessed=0 AND PermissionId=@dsg_id
		
	END
	
	IF @NewRights<>@OldRights
	BEGIN
		UPDATE doctors SET rights=@NewRights WHERE dr_id=@DocotorId
	END
	DROP TABLE #UserPermissionList	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
