SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--UPDATE

CREATE PROCEDURE [dbo].[UpdateReferringTargetDocsContactIdBySync]
(
   @TargetDrId int,
   @MasterContactId int
)
AS
BEGIN
	UPDATE [dbo].[referral_target_docs] 
	SET MasterContactId = @MasterContactId
	WHERE target_dr_id=@TargetDrId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
