SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: RAJARAM
-- Create date	: 24-Sep-2019
-- Description	: To save/update doctor security group rights for enrollment
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveDoctorSecurityGroupForEnrollment]
(
	@V1UserId					BIGINT,
	@SecurityGroupId			INT, -- should be a value from doc_security_groups dsg_id
	@Active						BIT
)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM dbo.doc_security_group_members WHERE dr_id = @V1UserId AND dsg_id = @SecurityGroupId)
	BEGIN
		IF @Active = 0
		BEGIN
			DELETE FROM dbo.doc_security_group_members  WHERE dr_id = @V1UserId AND dsg_id = @SecurityGroupId
		END
	END
	ELSE
	BEGIN
		IF @Active = 1
		BEGIN
			INSERT INTO dbo.doc_security_group_members (dr_id, dsg_id) VALUES (@V1UserId,@SecurityGroupId)
		END
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
