SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji Jogi>
-- Create date: <07-10-2015>
-- Description:	<Check the valide doctor group or not>
-- =============================================
CREATE PROCEDURE ValidateDoctorGroupId 
	-- Add the parameters for the stored procedure here
	@dgId bigint,
	@status bit OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select * from doc_groups with(nolock) where dg_id=@dgId )
		Begin
			Set @status=1
		End
	Else
		Begin
			Set @status=0
		ENd
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
