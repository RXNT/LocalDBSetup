SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Ramakrishna
-- Create date	: 2016/11/Jan
-- Description	: Insert vitas cml pre load data
-- =============================================
CREATE PROCEDURE [dbo].[VitasCMLPreLoad]
	@pres_id				BIGINT,
	@pd_id					BIGINT,
	@DCID					INT,
	@DGID					INT,	
	@MedicationOrderId		INT,
	@BATCHID				varchar(20)
AS	
BEGIN						
	INSERT INTO prescription_external_info 
	(	pres_id, pd_id, external_order_id, comments, active, created_date, 
		created_by, last_modified_date, last_modified_by, 
		dc_id, dg_id, external_source_syncdate, 
		batch_id, response_status) 
	values (@pres_id, @pd_id, @MedicationOrderId, '',null, GETDATE(),
	1, null, null, @DCID, @DGID,GETDATE(),@BATCHID,0)
				
END

		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
