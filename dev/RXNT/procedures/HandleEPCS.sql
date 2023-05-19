SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[HandleEPCS]
  @DRID INTEGER, @ENABLE BIT=0
  AS

		BEGIN
			IF EXISTS(select dr_id from doctor_info where dr_id=@DRID)
			BEGIN
				IF @ENABLE = 1
				BEGIN
					
					IF EXISTS(select dr_id from doc_admin where dr_id=@DRID and dr_partner_participant=262144)
					BEGIN
						update doc_admin set dr_service_level = dr_service_level | 2048,update_date = GETDATE() where dr_id=@DRID and dr_partner_participant=262144
					END
					ELSE
					BEGIN
						INSERT INTO doc_admin(dr_id,dr_partner_participant,dr_service_level,dr_partner_enabled,update_date,fail_lock)
						values(@DRID,262144,2049,1,GETDATE(),0)
					END
					update doctor_info set is_epcs = 1 where dr_id = @DRID
				END
				ELSE
					BEGIN
						
						IF EXISTS(select dr_id from doc_admin where dr_id=@DRID and dr_partner_participant=262144)
						BEGIN
							update doc_admin set dr_service_level = dr_service_level ^ 2048,update_date = GETDATE() where dr_id=@DRID and dr_partner_participant=262144
						END	
						update doctor_info set is_epcs = 0 where dr_id = @DRID				
						update doctors set epcs_enabled = 0 where dr_id = @DRID
					END
			END
		END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
