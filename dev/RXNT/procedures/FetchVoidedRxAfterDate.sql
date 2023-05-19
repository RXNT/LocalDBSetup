SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan Jayaraman
-- Create date: 2/29/2008
-- Description:	Fetches Voided Scripts After the given date
-- =============================================
CREATE PROCEDURE [dbo].[FetchVoidedRxAfterDate]	
	@DoctorId int, @DoctorGroupId int, @bRestrictToPersonalRx bit = 1, @bAgent bit = 0, @dtDateTime DateTime
AS
BEGIN	
	SET NOCOUNT ON;
	IF @bRestrictToPersonalRx = 1 
		BEGIN
			IF @bAgent = 1 
				BEGIN
					SELECT TOP 75 * FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) WHERE A.PRIM_DR_ID = @DoctorId AND A.pres_approved_date >= @dtDateTime  ORDER BY  pres_approved_date DESC, pa_last, pa_first 
				END
			ELSE
				BEGIN
					SELECT TOP 75 * FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) WHERE A.DR_ID = @DoctorId AND A.pres_approved_date >= @dtDateTime ORDER BY pres_approved_date DESC, pa_last, pa_first 
				END		
		END
	ELSE
		BEGIN
			SELECT TOP 75 * FROM vwDrVoidedPrescriptionsLog A WITH(NOLOCK) WHERE A.DG_ID = @DoctorGroupId AND A.pres_approved_date >= @dtDateTime ORDER BY pres_approved_date DESC, pa_last, pa_first
		END   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
