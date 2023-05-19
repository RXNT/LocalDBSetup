SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 2008/05/05
-- Description:	Save the Demo User Details
-- =============================================
CREATE PROCEDURE [dbo].[SaveDemoUser]	
	@firstname varchar(50),
	@lastname varchar(50),
	@phone varchar(30),
	@email varchar(100),
	@ip varchar(50),
	@result int out
AS
BEGIN
	DECLARE @SALES_REP_ID INT
	DECLARE @PREV_SALES_REP_ID INT
	SET NOCOUNT ON;
	/* FETCH NEXT SALES PERSON IN ROUND ROBIN */
	SELECT @SALES_REP_ID = sales_rep_id	 FROM DEMO_RR
	IF @SALES_REP_ID = 2
		BEGIN
			 SET @SALES_REP_ID = 21
		END	
	ELSE IF @SALES_REP_ID = 21
		BEGIN
			SET @SALES_REP_ID = 2
		END		
	/* Check if the person signed up previously */
	SELECT TOP 1 @PREV_SALES_REP_ID = SALES_REP_ID FROM DEMO_CUSTOMERS WHERE EMAIL=@email or ip_addr = @ip
	IF @PREV_SALES_REP_ID IS NOT NULL
		BEGIN
			SET @SALES_REP_ID = @PREV_SALES_REP_ID
		END	
	ELSE
		BEGIN
			UPDATE DEMO_RR SET SALES_REP_ID = @SALES_REP_ID
		END		
	/* OK, NOW WE SAVE CUSTOMER DETAILS */
	INSERT INTO DEMO_CUSTOMERS(FIRST_NAME, LAST_NAME, PHONE, EMAIL, SALES_REP_ID,ip_addr, date_signed) 
		VALUES(@firstname,@lastname, @phone, @email, @SALES_REP_ID, @ip, getdate())

	IF @@ROWCOUNT = 1 
		Set @result =  @SALES_REP_ID
	ELSE
		Set @result = 0
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
