SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Neupane, Samip>
-- Create date: <01/09/2020>
-- Description:	<Get all the prescription void reasons>
-- =============================================
CREATE PROCEDURE [prv].[GetAllVoidReasons] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Id, VoidReason, Code FROM void_reason_codes WITH(NOLOCK)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
