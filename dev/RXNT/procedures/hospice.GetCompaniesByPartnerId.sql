SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 25-APR-2018
-- Description:	Get Companies By PartnerId
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [hospice].[GetCompaniesByPartnerId]
	@PartnerId				BIGINT
AS
BEGIN
	IF (ISNULL(@PartnerId,0) > 0)
	BEGIN
		SELECT dc.dc_id, dc.dc_name FROM PARTNER_ACCOUNTS pa WITH(NOLOCK)
		INNER JOIN doc_companies dc WITH(NOLOCK) ON dc.partner_id=pa.PARTNER_ID
		WHERE pa.PARTNER_ID = @PartnerId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
