SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 2-Aug-2016
-- Description:	To search the vaccine Types
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchVaccineTypes]
	@CVX VARCHAR(50),
	@MainDoctorCompanyId INT
AS
BEGIN
	SELECT [record_id],[dc_id],[cvx],[vac_type],[vac_type_cvx],[statement_published_on],[statement_presented_on],vis_barcode 
	FROM tblVaccineTypes 
	WHERE dc_id =@MainDoctorCompanyId AND cvx=@cvx and active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
