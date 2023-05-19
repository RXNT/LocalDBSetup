SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			VINOD
-- Create date: 	21-06-2018
-- Description:		-
-- =============================================
CREATE PROCEDURE [dbo].[SearchMessagesForPrescriber] --1,10,1,0,0,9161,0,10
	@PageIndex INT = 1,
	@PageSize INT = 10,
	@iCheckComplete INT,
	@nLookBack INT = 0,
	@subTypeId INT = 0,
	@DoctorId BIGINT = 9161,
	@isUnread BIT,
	@RecordCount INT OUTPUT 
AS
BEGIN
      SET NOCOUNT ON;
	  Declare @strSql varchar(8000)
		Set @strSql = ' '

	 Set @strSql=@strSql+'  SELECT  ROW_NUMBER() OVER
      (
            ORDER BY [MSG_DATE] DESC
      )AS RowNumber, A.DR_CST_MSG_ID MSG_ID, A.DR_SRC_ID, A.is_read, A.DR_DST_ID, DATEADD(hh,-B.time_difference,A.MSG_DATE) as MSG_DATE,A.is_complete, A.patid, A.message_typeid, A.message_subtypeid,
        A.MESSAGE, B.DR_FIRST_NAME, B.DR_LAST_NAME INTO #Results FROM DR_CUSTOM_MESSAGES A
		INNER JOIN DOCTORS B ON A.DR_SRC_ID = B.DR_ID  AND A.DR_DST_ID = '+  Cast(@DoctorId as Varchar)

	if (@nLookBack != 0)
	BEGIN
            Set @strSql=@strSql+' AND A.MSG_DATE > DATEADD(M, -'+  Cast(@nLookBack as Varchar) +', GETDATE()) '
	END
	if (@subTypeId > 0)
	BEGIN
            Set @strSql=@strSql+'AND A.message_subtypeid = '+ Cast(@subTypeId as Varchar) 
	END
	if (@isUnread = 1)
	BEGIN
            Set @strSql=@strSql+' AND ISNULL(A.IS_READ,0) = 0 '
	END

	if (@iCheckComplete = 2) -- To populate incomplete messages
	BEGIN 
		Set @strSql=@strSql+'WHERE (A.IS_COMPLETE IS NULL OR A.IS_COMPLETE <>1) AND (isnull (inbox_delete,0)) != 1 ORDER BY A.MSG_DATE DESC '
	END
	ELSE IF(@iCheckComplete = 1) -- To populate complete messages
	BEGIN 
		Set @strSql=@strSql+'WHERE A.IS_COMPLETE = 1  AND (isnull (inbox_delete,0)) != 1 ORDER BY A.MSG_DATE DESC '		
	END
	ELSE IF(@iCheckComplete = 0) -- To populate complete messages
	BEGIN 
		Set @strSql=@strSql+'AND (isnull (inbox_delete,0)) != 1 ORDER BY A.MSG_DATE DESC '		
	END

	  Set @strSql=@strSql+' 
	  SELECT  COUNT(*) AS RecordCount
      FROM #Results
	
	  
	  SELECT * FROM #Results
      WHERE RowNumber BETWEEN('+Cast(@PageIndex as Varchar) +' -1) * '+Cast(@PageSize as Varchar) +' + 1 AND((('+Cast(@PageIndex as Varchar) +' -1) * '+Cast(@PageSize as Varchar) +' + 1) + '+Cast(@PageSize as Varchar) +') - 1
     
      DROP TABLE #Results'
	  PRINT @strSql
	 Exec (@strSql)

	 
     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
