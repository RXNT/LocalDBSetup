SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Niyaz
-- Create date: 	11-JUNE-2018
-- Description:		Save Doctor Group Favorite Drug
-- =============================================
CREATE PROCEDURE [dbo].[SaveDoctorGroupFavoritePharmacy]
  @DoctorGroupId			BIGINT,
  @DoctorId					BIGINT,
  @PharmId					BIGINT,
  @IsDelete					BIT=0,
  @FromDoctorId				BIGINT = 0
AS
BEGIN
	IF(ISNULL(@IsDelete,0)=0)
	BEGIN
		DECLARE @ImportRefId AS BIGINT = 0
		IF(@FromDoctorId > 0)
		BEGIN
			SELECT @ImportRefId = ISNULL(fp_id,0) FROM doc_fav_pharms WHERE pharm_id=@PharmId AND dr_id=@FromDoctorId
		END
		IF NOT EXISTS(SELECT TOP 1 1 FROM doc_group_fav_pharms WHERE dg_id=@DoctorGroupId AND pharm_id=@PharmId)
		BEGIN
			INSERT INTO doc_group_fav_pharms (dg_id,added_by_dr_id,added_date,pharm_id,import_ref_id,import_date)
			VALUES(@DoctorGroupId,@DoctorId,GETDATE(),@PharmId,@ImportRefId,GETDATE())
		END
	END
	ELSE
	BEGIN
		DELETE FROM doc_group_fav_pharms WHERE dg_id=@DoctorGroupId AND pharm_id=@PharmId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
