SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 12-Oct-2016
-- Description:	To Save Carrier
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SaveCarrier]
  @CarrierId INT OUTPUT,
  @CarrierName VARCHAR(MAX),
  @Address1 VARCHAR(MAX),
  @City VARCHAR(MAX),
  @State VARCHAR(MAX),
  @ZipCode VARCHAR(MAX),
  @Phone VARCHAR(MAX)
AS
BEGIN
	INSERT INTO [referral_carrier_details] ([carrier_name] ,[address1] ,[city] ,[state], [zip],[phone])
    VALUES  (@CarrierName, @Address1, @City, @State, @ZipCode, @Phone); 
    SET @CarrierId = SCOPE_IDENTITY();
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
