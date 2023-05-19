SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji>
-- Create date: <03-16-2015>
-- Description:	<PrescriptionTaperInfo>
-- =============================================
CREATE PROCEDURE GetPrescriptionTaperInfoByPDID 
	-- Add the parameters for the stored procedure here
	@PDId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
		case when Dose is null then '' else Dose END As Dose,
		case when Sig is null then '' else Sig END As Sig,
		case when Days is null then '' else cast(Days As varchar(5)) END As Days,
		case when Hrs is null then '' else cast(Hrs As varchar(5)) END As Hours
		from prescription_taper_info with(nolock) where pd_id=@PDId 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
