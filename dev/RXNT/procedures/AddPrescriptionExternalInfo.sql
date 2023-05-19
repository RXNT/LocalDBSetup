SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE AddPrescriptionExternalInfo 
(
	@pres_id INT,
	@pd_id INT,
	@external_order_id VARCHAR(255),
	@comments VARCHAR(1000)	  
)
AS
BEGIN
	BEGIN TRY
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO [dbo].[prescription_external_info]
			   ([pres_id]
			   ,[pd_id]
			   ,[external_order_id]
			   ,[comments]
			   --,[active]
			   ,[created_date]
			   --,[created_by]
			   --,[last_modified_date]
			   --,[last_modified_by]
			   )
		 VALUES
			   (@pres_id
			   ,@pd_id
			   ,@external_order_id
			   ,@comments
			   ,GETDATE()
			   )
			COMMIT
		END	
	END TRY
	BEGIN CATCH
		ROLLBACK -- Rollback TRANSACTION
		
		DECLARE @ErrorMessage AS NVARCHAR(4000),@ErrorSeverity AS INT,@ErrorState AS INT;
		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'RxNTWS','SavePrescriptionAsPending','',ERROR_LINE ())				   
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
