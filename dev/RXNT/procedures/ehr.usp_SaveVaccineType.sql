SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 5-Aug-2016
-- Description:	To save the vaccineType
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveVaccineType]
	@DoctorCompanyId INT,
	@CVX VARCHAR(10),
	@VaccineTypeDescription VARCHAR(100),
	@VaccineTypeCVX VARCHAR(10),
	@VISBarcode VARCHAR(24),
	@StatementPublished DATETIME,
	@StatementPresented DATETIME
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM  tblVaccineTypes WHERE dc_id=@DoctorCompanyId AND vac_type=@VaccineTypeDescription AND vac_type_cvx=@VaccineTypeCVX AND cvx=@cvx AND active = 1)
    BEGIN
	   INSERT INTO [dbo].[tblVaccineTypes] 
	   ([dc_id],[cvx],vac_type,vac_type_cvx,statement_published_on,[statement_presented_on],vis_barcode, active)
       VALUES (@DoctorCompanyId, @cvx,@VaccineTypeDescription,@VaccineTypeCVX, @StatementPublished, @StatementPresented,@VISBarcode, 1)
    END
    ELSE
	BEGIN
		UPDATE tblVaccineTypes 
		SET vac_type=@VaccineTypeDescription,
		statement_published_on=@StatementPublished,
		statement_presented_on=@StatementPresented,
		vis_barcode=@VISBarcode 
		WHERE dc_id=@DoctorCompanyId AND cvx=@cvx AND vac_type_cvx=@VaccineTypeCVX
	END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
