SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji>
-- Create date: <02-29-2016>
-- Description:	<Get the dc_id and dg_id by Application and Hl7PrcId>
-- =============================================
CREATE PROCEDURE [dbo].[GetDCIDAndDGIDByApplicationAndHL7PrcID] 
	-- Add the parameters for the stored procedure here
	@Application varchar(50),
	@hl7_cr_id varchar(50),
	@DCId BIGINT OUTPUT,
	@DGId BigINT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SEt @DCId = 0
	SET @DGId = 0
    -- Insert statements for procedure here
	select top 1 @DCId=dc_id from hl7_cross_reference WITH(NOLOCK) Where [application]=@Application and hl7_prac_id=@hl7_cr_id
	
	select Top 1 @DGId=dg_id from doc_groups WITH(NOLOCK) where dc_id=@DCId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
