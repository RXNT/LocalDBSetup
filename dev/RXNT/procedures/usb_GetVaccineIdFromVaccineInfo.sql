SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 03/22/2022
-- Description:	Get Vaccine id from cvx and mvx code
-- =============================================
CREATE PROCEDURE [dbo].[usb_GetVaccineIdFromVaccineInfo]
	-- Add the parameters for the stored procedure here
	@CVXCode VARCHAR(10),
	@MVXCode VARCHAR(10) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT top 1 vac_id, vac_name
	FROM tblVaccines WITH(NOLOCK)
	WHERE
	CVX_CODE = @CVXCode AND
	-- dc_id of is system level vaccine
	dc_id = 0 AND
	--is_active = 1 AND
	--is_CDC_active = 1 AND
	(@MVXCode IS NULL OR
	(@MVXCode IS NOT NULL AND 
	mvx_code = @MVXCode))
	ORDER BY vac_id DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
