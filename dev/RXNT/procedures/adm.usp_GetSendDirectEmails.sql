SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Vipul
Create date			: 08-Jan-2019
Description			: Get Send Direct Emails
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/

CREATE PROCEDURE [adm].[usp_GetSendDirectEmails]
(
	@Username					VARCHAR(100) = NULL,
	@FromEmailAddress			VARCHAR(100) = NULL,
	@StartDate					DATETIME = NULL,
	@EndDate					DATETIME = NULL,
	@PageSize					INT,
	@CurrentPageIndex			INT
)
AS 
BEGIN
	SET NOCOUNT ON;
	DECLARE @UnPaidInvoiceStatusId BIGINT
	DECLARE @PaymentFailedInvoiceStatusId BIGINT
	DECLARE @StartRowNumber AS INT
	DECLARE @EndRowNumber AS INT
	DECLARE @TempDirectEmail AS TABLE (from_address VARCHAR(255), count INT, NUM INT) 
	DECLARE @TempData AS TABLE (username VARCHAR(50), from_address VARCHAR(255))

	SET @StartRowNumber = @CurrentPageIndex
	SET @EndRowNumber = @CurrentPageIndex + @PageSize
  
	INSERT INTO @TempData 
	SELECT dr_username as username, dea.DirectAddressPrefix+'@'+dem.DirectDomainPrefix+'.direct.rxnt.com' as from_address
	FROM direct_email_addresses dea WITH(NOLOCK) 
	INNER JOIN dbo.direct_email_domains dem WITH(NOLOCK)  ON dea.DirectDomainID=dem.DirectDomainID
	INNER JOIN dbo.doctors docs WITH(NOLOCK) ON dea.OwnerEntityID = docs.dr_id
  
	INSERT INTO @TempDirectEmail
	SELECT DESM.from_address, count(DESM.from_address)as count, ROW_NUMBER() OVER(ORDER BY DESM.from_address DESC)
	FROM [dbo].[direct_email_sent_messages] DESM WITH (NOLOCK)
	INNER JOIN @TempData TMP ON TMP.from_address = DESM.from_address
	WHERE	1 = 1 AND 
			((@StartDate IS NULL AND @EndDate IS NULL) OR
			(@StartDate IS NOT NULL AND @EndDate IS NOT NULL AND DATEADD(D, 0, DATEDIFF(D, 0, DESM.sent_date)) BETWEEN DATEADD(D, 0, DATEDIFF(D, 0, @StartDate)) AND DATEADD(D, 0, DATEDIFF(D, 0, @EndDate)))) AND
			(ISNULL(@Username, '') = '' OR TMP.username LIKE @Username + '%') AND
			(ISNULL(@FromEmailAddress, '') = '' OR DESM.from_address LIKE '%' + @FromEmailAddress + '%' ) 
	GROUP BY DESM.from_address		
	
	SELECT * INTO #TempDirectEmailSend
	FROM @TempDirectEmail
	WHERE NUM >= @StartRowNumber AND NUM < @EndRowNumber
	
	SELECT *
	FROM #TempDirectEmailSend 
	
	SELECT COUNT(*) As TotalNoOfRecords
	FROM @TempDirectEmail
	
	DROP TABLE #TempDirectEmailSend

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
