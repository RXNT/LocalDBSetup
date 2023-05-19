SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: kalimuthu S
-- Create date	: 06-MAY-20120
-- Description	: Get the V2 doctor Id
-- =============================================
CREATE PROCEDURE [dbo].[GetV2DoctorId]
(	
	@DOCID INT
)
AS
BEGIN 
	select md.LoginId from [dbo].[RsynRxNTMasterLogins] md with(nolock) inner join [dbo].[RsynRxNTMasterLoginExternalAppMaps] mdea with (nolock)
	on md.LoginId = mdea.LoginId where mdea.ExternalLoginId = @DOCID and mdea.ExternalAppId = 1;			
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
