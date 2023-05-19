SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Singaravelan
-- Create date:  Sep 22, 2016
-- Description:	 to get lab order master details
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetLabOrderMasterDetails]
(
	@LabId INT
)
AS
BEGIN
	select LM.lab_order_master_id,PLOM.order_date, pl.lab_test_name 
	from lab_main LM
    inner join patient_lab_orders_master PLOM on LM.lab_order_master_id=PLOM.lab_master_id 
    inner join patient_lab_orders pl on pl.lab_master_id = PLOM.lab_master_id
    where lm.lab_id= @LabId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
