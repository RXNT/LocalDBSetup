SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 6-9-2019
-- Description:	to Get Doctor Restriction List
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetDoctorRestrictionList] --17821,40931190
	
	@DoctorCompanyId BIGINT,
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT dr.dr_id, ISNULL(PC.isRestricted,0) isRestricted,
	dr_last_name + ' ' + ISNULL(dr_middle_initial,'') + ' '  + dr_first_name AS DoctorName,dr.dr_enabled 
	FROM doctors dr WITH (NOLOCK)
	INNER JOIN doc_groups DG WITH(NOLOCK) ON DG.dg_id = dr.dg_id
	LEFT OUTER JOIN patient_chart_restricted_users PC WITH(NOLOCK) ON dr.dr_id = PC.dr_id and PC.pa_id = @PatientId
	WHERE (rights & Cast(4294967296 AS BIGINT) = 4294967296
	OR rights & Cast(2147483648 AS BIGINT) = 2147483648)
	and DG.dc_id = @DoctorCompanyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
