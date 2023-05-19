SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			VINOD
-- Create date: 	21-06-2018
-- Description:		-
-- =============================================
CREATE PROCEDURE [dbo].[SearchPatientMessagesForPrescriber] --1,10,2,12,0,9161,'INBOX'
	@PageIndex INT = 1,
	@PageSize INT = 10,
	@iCheckComplete INT,
	@nLookBack INT = 0,
	@isRead BIT,
	@id INT,
	@TypeOfRetrieval VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	  Declare @strSql varchar(8000)
		Set @strSql = ' '

	 Set @strSql=@strSql+'  SELECT  ROW_NUMBER() OVER (ORDER BY[MSG_DATE] DESC)AS RowNumber, 
	 [id],[from_id],[to_id],[msg_date],[message],[is_read],[is_complete],messagedigest,
	  PR.FirstName AS "RepresentativeFirstName", PR.LastName AS "RepresentativeLastName",
	  PR.MiddleInitial  AS "RepresentativeMiddleInitial",PR.PatientRepresentativeId, COALESCE(DOC.time_difference, 0) as time_difference '

	if (@TypeOfRetrieval = 'OUTBOX')
	BEGIN
            Set @strSql=@strSql+', DOC.dr_first_name +''' + ' ' + ''' + DOC.dr_last_name as FromDrSource 
			, pTo.pa_first + ''' + ' ' + ''' + pTo.pa_last as ToPatientSource  '
	END
	ELSE
	BEGIN 
	 Set @strSql=@strSql+', DOC.dr_first_name +  ''' + ' ' + ''' + DOC.dr_last_name as ToDrSource,
	  pFrom.pa_first +  ''' + ' ' + ''' + pFrom.pa_last as FromPatientSource '
	END

	 Set @strSql=@strSql+' INTO #Results FROM [dbo].[doctor_patient_messages] DPM WITH(NOLOCK) 
	 LEFT JOIN phr.PatientRepresentatives PR WITH(NOLOCK) ON DPM.PatientRepresentativeId = PR.PatientRepresentativeId ' 


	if (@TypeOfRetrieval = 'OUTBOX')
	BEGIN
            Set @strSql=@strSql+'LEFT OUTER JOIN DOCTORS DOC ON DOC.dr_id = from_id   
			LEFT OUTER JOIN PATIENTS pTo ON pTo.pa_id = to_id   
			WHERE [from_deleted_id] IS NULL and [from_id] = '+  Cast(@id as Varchar)
	END
	ELSE
	BEGIN 
	 Set @strSql=@strSql+'LEFT OUTER JOIN DOCTORS DOC ON DOC.dr_id = to_id
	 LEFT OUTER JOIN PATIENTS pFrom ON pFrom.pa_id = from_id
	 WHERE [to_deleted_id] IS NULL and [to_id] = '+  Cast(@id as Varchar)
	END

	if (@iCheckComplete =2)
	BEGIN
            Set @strSql=@strSql+' AND (is_complete IS NULL OR is_complete <>1)'
	END
	if (@iCheckComplete =1)
	BEGIN
            Set @strSql=@strSql+' AND is_complete = 1'
	END
	
	if (@isRead = 1)
	BEGIN
            Set @strSql=@strSql+' AND is_read = 1 '
	END
	ELSE
	BEGIN
            Set @strSql=@strSql+' AND ISNULL(is_read,0) = 0 '
	END
	
	if (@nLookBack != 0)
	BEGIN
		Set @strSql=@strSql+'AND MSG_DATE > DATEADD(M, -'+  Cast(@nLookBack as Varchar) +', GETDATE()) ORDER BY MSG_DATE DESC '
	END


	  Set @strSql=@strSql+' 
	  SELECT COUNT(*) AS RecordCount FROM #Results

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
