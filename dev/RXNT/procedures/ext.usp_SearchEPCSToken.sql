SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	07-Oct-2019
Description			:	This procedure is used to get Search active tokens
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ext].[usp_SearchEPCSToken] -- 118031

	@DoctorId	BIGINT,
	@TokenId BIGINT=NULL
AS
BEGIN
	SELECT [doc_token_track_id]
      ,[dr_id]
      ,[stage]
      ,[comments]
      ,[ups_tracking_id]
      ,[ups_label_file]
      ,[shipping_fee]
      ,[shipping_address1]
      ,[shipping_address2]
      ,[shipping_city]
      ,[shipping_state]
      ,[shipping_zip]
      ,[shipping_to_name]
      ,[ship_submit_date]
      ,[shipment_identification]
      ,[email]
      ,[token_serial_no]
      ,[token_type]
      ,[is_activated]
      ,[IsSigRequired]
      FROM doc_token_info WITH(NOLOCK)
      WHERE [dr_id]=@DoctorId AND [token_type] IN (1,2) 
	  AND (@TokenId IS NULL OR [doc_token_track_id]=@TokenId) 
	  AND (@TokenId IS NOT NULL OR stage NOT IN (4,5))
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
