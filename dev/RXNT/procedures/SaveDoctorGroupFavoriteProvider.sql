SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Niyaz
-- Create date: 	06-APR-2018
-- Description:		Save Doctor Group Favorite Provider
-- =============================================
CREATE PROCEDURE [dbo].[SaveDoctorGroupFavoriteProvider]
  @DoctorGroupId			BIGINT,
  @DoctorId					BIGINT,
  @RefProviderId					BIGINT,
  @IsDelete					BIT=0,
  @FromDoctorId				BIGINT = 0
AS
BEGIN
	IF(ISNULL(@IsDelete,0)=0)
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM doc_group_fav_ref_providers WHERE dg_id=@DoctorGroupId AND target_dr_id=@RefProviderId)
		BEGIN
			INSERT INTO doc_group_fav_ref_providers (dg_id,added_by_dr_id,added_date,target_dr_id,import_date)
			VALUES(@DoctorGroupId,@DoctorId,GETDATE(),@RefProviderId,GETDATE())
		END
	END
	ELSE
	BEGIN
		DELETE FROM doc_group_fav_ref_providers WHERE dg_id=@DoctorGroupId AND target_dr_id=@RefProviderId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
