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

CREATE PROCEDURE [adm].[usp_SearchEPCSToken]  --NULL,NULL,NULL,"MANAGE_TOKEN"
	@TokenId BIGINT=NULL,
	@DoctorIds VARCHAR(8000)=NULL,
	@IsActivated BIT = NULL,
	@Action VARCHAR(50)=NULL
AS
BEGIN
	DECLARE @ups_label_file VARCHAR(MAX)
	IF @TokenId>0
	BEGIN
		SELECT @ups_label_file=fi.Base64Content FROM  doc_token_info dti WITH(NOLOCK)
		INNER JOIN dbo.FileInfo  fi WITH(NOLOCK) ON dti.ups_file_id = fi.FileId
		WHERE dti.doc_token_track_id=@TokenId
		
	END
	SELECT [doc_token_track_id]
      ,DT.[dr_id],
	    ISNULL(D.dr_last_name,'') + ', ' + ISNULL(D.dr_first_name,'') + ' '	+ ISNULL(D.dr_middle_initial,'') As FullName
		
      ,[stage]
      ,DT.[comments]
      ,[ups_tracking_id]
      ,@ups_label_file [ups_label_file]
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
      ,LMEA.LoginId V2LoginId
      ,LMEA.CompanyId V2DoctorCompanyId
      FROM doc_token_info DT WITH(NOLOCK)
	  INNER JOIN doctors D WITH(NOLOCK) ON D.dr_id = DT.dr_id
	   INNER JOIN doc_groups DG WITH(NOLOCK) ON D.dg_id = DG.dg_id
	  INNER JOIN [dbo].[RsynRxNTMasterLoginExternalAppMaps] LMEA WITH(NOLOCK) ON LMEA.ExternalAppId=1 AND LMEA.ExternalLoginId=d.dr_id AND LMEA.ExternalCompanyId=dg.dc_id  
      
      WHERE  (@DoctorIds IS NULL OR DT.[dr_id] IN (SELECT * FROM dbo.SplitString(@DoctorIds, ',')))
	  AND [token_type] IN (1,2) 
	  AND (@IsActivated IS NULL OR [is_activated] = @IsActivated)
	  AND (@TokenId IS NULL OR [doc_token_track_id]=@TokenId) 
	  AND ((@Action='MANAGE_TOKEN' AND stage IN (0,1,4,5,6,7)) 
	  OR (@Action IS NULL  AND stage NOT IN (4,5)) )
	  order by [doc_token_track_id] desc 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
