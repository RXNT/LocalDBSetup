SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 5-Aug-2016
-- Description:	To save the vaccine
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveVaccine]
	@VaccineId INT OUTPUT,
	@VaccineName VARCHAR(100),
	@VaccineBaseName VARCHAR(100),
	@CVX VARCHAR(10),
	@Manufacturer VARCHAR(100),
	@MVX VARCHAR(10),
	@Type VARCHAR(50),
	@Comments VARCHAR(250),
	@Route VARCHAR(50),
	@RouteCode VARCHAR(3),
	@Link VARCHAR(200),
	@DoctorCompanyId INT,
	@FundingProgramEligibilityCategoryCode VARCHAR(3),
	@ExpirationDate DATETIME
AS
BEGIN
	IF ISNULL(@VaccineId, 0) = 0
	BEGIN
		INSERT INTO [dbo].[tblVaccines] 
		([vac_name],[vac_base_name],cvx_code,[manufacturer],mvx_code,[type],[comments]
		,[route],route_code,[info_link],[dc_id],eligibility_category_code,Expiration_Date)
        VALUES (@VaccineName, @VaccineBaseName,@CVX, @Manufacturer,@MVX, @Type, @Comments,
         @Route,@RouteCode,@Link, @DoctorCompanyId,@FundingProgramEligibilityCategoryCode,@ExpirationDate);
         SET @VaccineId = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		update tblVaccines 
		set  vac_name=@VaccineName, vac_base_name=@VaccineBaseName, 
		cvx_code=@CVX, manufacturer=@Manufacturer, mvx_code=@MVX, [type]=@Type, comments=@Comments, 
		route=@Route, route_code =@RouteCode,info_link=@Link,dc_id=@DoctorCompanyId,
		eligibility_category_code=@FundingProgramEligibilityCategoryCode,Expiration_Date=@ExpirationDate 
		where vac_id = @VaccineId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
