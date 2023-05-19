SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[GetScriptGuideCoupon]
@ScriptGuideID INT 
AS
BEGIN
	DECLARE @sql NVARCHAR(1000)
	DECLARE @param NVARCHAR(100)
	DECLARE @SGCouponID INT
	DECLARE @SGCouponCode VARCHAR(50)
	DECLARE @RequireCoupon BIT

	SET @RequireCoupon = (SELECT bRequireCoupon FROM ScriptGuideProgramSpecifications WHERE sg_id = @ScriptGuideID)
	SET @SGCouponID = 0
	SET @SGCouponCode = ''
	SET @sql = N'SELECT TOP 1 @SGCouponIDOut = SGCouponID, @SGCouponCodeOut = SGCouponCode FROM ScriptGuideCoupons WHERE used = 0 AND ForSGId = ' + CAST(@ScriptGuideID AS VARCHAR(10))  + ' ORDER BY SGCouponID'
	SET @param = N'@SGCouponIDOut INT OUTPUT, @SGCouponCodeOut VARCHAR(50) OUTPUT'
	
	EXEC sp_executesql @sql, @param, @SGCouponIDOut = @SGCouponID OUTPUT, @SGCouponCodeOut = @SGCouponCode OUTPUT
	 
	If @SGCouponID > 0 
		BEGIN 
			SET @sql = N'UPDATE ScriptGuideCoupons SET used = 1 WHERE SGCouponID = @SGCouponID'			
			SET @param = N'@SGCouponID INT';
			exec sp_executesql @sql, @param, @SGCouponID
			/*SELECT @SGCouponID AS SGCouponID, @SGCouponCode AS SGCouponCode*/
			SELECT 0 AS SGCouponID, @SGCouponCode AS SGCouponCode
		END 	  
	ELSE
		BEGIN
			IF @RequireCoupon = 1
				BEGIN
					SELECT '-1' AS SGCouponID, '' AS SGCouponCode
				END
			ELSE
				BEGIN
					SELECT '0' AS SGCouponID, '' AS SGCouponCode
				END
		END
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
