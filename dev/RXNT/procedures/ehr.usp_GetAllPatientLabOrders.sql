SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Singaravelan
-- Create date:  Sep 21, 2016
-- Description:	 Get All patient lab orders
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetAllPatientLabOrders]
(
	@PatientId INT
)
AS
BEGIN
	select PLOM.lab_master_id ,
				( SELECT PLO.lab_test_name + ' , ' 
				FROM patient_lab_orders  PLO with(nolock)
				WHERE PLO.lab_master_id = PLOM.lab_master_id
				FOR XML PATH('') ) 
          AS Lab_Test_Name,
          MAX(PLO.order_date) AS Order_Date
          from patient_lab_orders_master PLOM with(nolock)
	  inner join patient_lab_orders PLO with(nolock) on PLO.lab_master_id=PLOM.lab_master_id
	  where PLO.pa_id=@PatientId
      GROUP BY PLOM.lab_master_id order by Order_Date desc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
