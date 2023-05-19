SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 03/22/2022
-- Description:	Add external vaccine, mark them as inactive
-- =============================================
CREATE PROCEDURE [dbo].[usb_AddExternalVaccine]
	-- Add the parameters for the stored procedure here
	@VaccineName VARCHAR(150),
	@CVXCode VARCHAR(10),
	@ManufacturerName VARCHAR(100) = NULL,
	@MVXCode VARCHAR(10) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT 1 FROM tblVaccines WITH(NOLOCK) WHERE 
		CVX_CODE = @CVXCode AND
		-- dc_id 0 is system level vaccine
		dc_id = 0 AND
		(@MVXCode IS NULL OR
		(@MVXCode IS NOT NULL AND 
		mvx_code = @MVXCode)))
	BEGIN
		INSERT INTO tblVaccines
		(
			vac_name,
			vac_base_name,
			manufacturer,
			type,
			CVX_CODE,
			mvx_code,
			vac_exp_code,
			dc_id,
			is_active,
			is_CDC_Active
		)
		VALUES 
		(
			@VaccineName,
			'',
			@ManufacturerName,
			'',
			@CVXCode,
			@MVXCode,
			'',
			0,
			0,
			0
		)

		SELECT SCOPE_IDENTITY() as vac_id
	END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
