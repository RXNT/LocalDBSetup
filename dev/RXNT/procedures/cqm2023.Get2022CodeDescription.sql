SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	28-NOV-2022
-- Description:		Get Code Description Details By Code and CodeSystem
-- =============================================
CREATE    PROCEDURE [cqm2023].[Get2022CodeDescription]
  @Code			VARCHAR(30),
  @CodeSystem		VARCHAR(100)
AS
BEGIN 
	DECLARE @CodeDescription Varchar(200) = '';
	
	SELECT TOP 1 @CodeDescription = Description FROM cqm2023.SysLookupCMS117v11_NQF0038 
	WHERE Code=@Code AND CodeSystemId IN 
	(
		SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
	)
		
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2023.SysLookupCMS136v12_NQF0108
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2023.SysLookupCMS138v11_NQF0028
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2023.SysLookupCMS147v12_NQF0041
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2023.SysLookupCMS153v11_NQF0033
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2023.SysLookupCMS155v11_NQF0024
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2023.SysLookupCMS68v12_NQF0419
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1  @CodeDescription = Description FROM cqm2023.SysLookupCMS69v11_NQF0421
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2023.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
		
	SELECT @CodeDescription;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
