SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	28-NOV-2022
-- Description:		Get Code Description Details By Code and CodeSystem
-- =============================================
CREATE   PROCEDURE [cqm2022].[Get2022CodeDescription]
  @Code			VARCHAR(30),
  @CodeSystem		VARCHAR(100)
AS
BEGIN 
	DECLARE @CodeDescription Varchar(200) = '';
	
	SELECT TOP 1 @CodeDescription = Description FROM cqm2022.SysLookupCMS117v10_NQF0038 
	WHERE Code=@Code AND CodeSystemId IN 
	(
		SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
	)
		
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2022.SysLookupCMS136v11_NQF0108
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2022.SysLookupCMS138v10_NQF0028
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2022.SysLookupCMS147v11_NQF0041
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2022.SysLookupCMS153v10_NQF0033
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2022.SysLookupCMS155v10_NQF0024
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1 @CodeDescription = Description FROM cqm2022.SysLookupCMS68v11_NQF0419
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
			)
		END
	
	
	IF ISNULL(@CodeDescription,'') = ''
		BEGIN 
			SELECT TOP 1  @CodeDescription = Description FROM cqm2022.SysLookupCMS69v10_NQF0421
			WHERE Code=@Code AND CodeSystemId IN 
			(
				SELECT CodeSystemId FROM cqm2022.SysLookupCodeSystem WHERE CodeSystemOID=@CodeSystem
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
