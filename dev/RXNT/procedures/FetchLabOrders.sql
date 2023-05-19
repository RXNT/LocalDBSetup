SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FetchLabOrders]
	(
	@PatientID INTEGER
	)
AS
BEGIN
	BEGIN TRY
	select PLOM.lab_master_id ,
    ( SELECT PLO.lab_test_name + ' , ' 
           FROM patient_lab_orders  PLO with(nolock)
          WHERE PLO.lab_master_id = PLOM.lab_master_id
          FOR XML PATH('') ) AS Lab_Test_Name,
          MAX(PLO.order_date) AS Order_Date
          from patient_lab_orders_master PLOM with(nolock)
	 inner join patient_lab_orders PLO with(nolock) on PLO.lab_master_id=PLOM.lab_master_id
	  where PLO.pa_id=@PatientID
      GROUP BY PLOM.lab_master_id order by Order_Date desc
	END  TRY
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
					   
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
