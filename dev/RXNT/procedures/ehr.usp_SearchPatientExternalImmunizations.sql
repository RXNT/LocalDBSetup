SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientExternalImmunizations]
	-- Add the parameters for the stored procedure here
	@PatientId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	vac_rec_id,
	vac_id,
	vac_name,
	vac_base_name,
	cvx_code,
	mvx_code,
	manufacturer_name,
	vac_dt_admin,
	vac_dose,
	vac_dose_unit_code,
	route, 
	route_code,
	vac_site,
	vac_site_code,
	vac_lot_no,
	vac_exp_date
	FROM dbo.tblPatientExternalVaccinationRecord WITH(NOLOCK)
	WHERE vac_pat_id = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
