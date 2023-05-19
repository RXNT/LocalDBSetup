SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Niyaz
-- Create date: 	06-APR-2018
-- Description:		Save Doctor Group Favorite Referral Institution
-- =============================================
CREATE PROCEDURE [dbo].[SaveDoctorGroupFavoriteInstitution]
  @DoctorGroupId			BIGINT,
  @DoctorId					BIGINT,
  @InstitutionId			BIGINT,
  @IsDelete					BIT=0,
  @FromDoctorId				BIGINT = 0
AS
BEGIN
	IF(ISNULL(@IsDelete,0)=0)
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM doc_group_fav_ref_institutions WHERE dg_id=@DoctorGroupId AND inst_id=@InstitutionId)
		BEGIN
			INSERT INTO doc_group_fav_ref_institutions (dg_id,added_by_dr_id,added_date,inst_id,import_date)
			VALUES(@DoctorGroupId,@DoctorId,GETDATE(),@InstitutionId,GETDATE())
		END
	END
	ELSE
	BEGIN
		DELETE FROM doc_group_fav_ref_institutions WHERE dg_id=@DoctorGroupId AND inst_id=@InstitutionId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
