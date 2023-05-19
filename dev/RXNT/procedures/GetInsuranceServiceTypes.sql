SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji>
-- Create date: <03-06-2015,>
-- Description:	<Get the insurane service codes>
-- =============================================
CREATE PROCEDURE GetInsuranceServiceTypes 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Code, Definition from InsuranceServiceTypes WITH (NOLOCK)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
