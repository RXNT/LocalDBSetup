SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Nambi
-- Create date:  Sep 26, 2016
-- Description:	 Update Comments
-- =============================================
CREATE PROCEDURE [prv].[usp_UpdateCommentsForResult]
(
	@LabId BIGINT,
	@Comments VARCHAR(MAX)
)
AS
BEGIN
	UPDATE lab_main 
	SET comments = CASE 
					WHEN comments IS NOT NULL and comments<>'' then comments +'|'+ @comments 
					ELSE @comments 
				   END 
	WHERE LAB_ID = @LabId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
