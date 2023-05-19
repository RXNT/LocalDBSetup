SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 10/29/07
-- Description:	Fetches a free id for the sample if possible
-- =============================================
CREATE PROCEDURE  [dbo].[FetchSampleId] @sample_id int, @resultd varchar(100) output
AS
BEGIN	
	DECLARE @xreftablename varchar(150)
	DECLARE @sql nvarchar(1000)
	DECLARE @param nvarchar(100)
	DECLARE @result varchar(100)
	DECLARE @sampleexpiremessage varchar(500)
	SET @xreftablename = ''
	SET @result = ''
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT @xreftablename=xref_tbname from FreeSample where sampleid = @sample_id
    and startdate <= getdate() and enddate >= getdate()
	
	IF (@xreftablename <> '')
	 BEGIN
	  SET @sql = N'SELECT Top 1 @resultout = ID from ' + @xreftablename + ' where is_valid =1 order by id '
	  SET @param = N'@resultout varchar(100) output'
	 
	  exec sp_executesql @sql, @param,@resultout=@result output
	 
	  If @result <> '' 
		BEGIN 
			SET @sql = N'Update ' + @xreftablename + N' set is_valid =0 where id = @currid'			
			SET @param = N'@currid varchar(100)';
			exec sp_executesql @sql, @param, @result
		END 	  
	  ELSE
		BEGIN
			/* No more vouchers, prevent future use */
			UPDATE FREESAMPLE SET ENDDATE=GETDATE()-1 WHERE SAMPLEID = @sample_id
			SET @sampleexpiremessage = 'The sample for ' + @xreftablename + ' has expired'
			EXEC msdb.dbo.sp_send_dbmail @profile_name='Scott Brunner',
			@recipients='ganeshan@rxnt.com;thomask@rxnt.com',
			@subject = 'Freesample expired',
			@body =@sampleexpiremessage
		END	  
	 END
	If (@result <> '') SET @resultd = @result				
	Else  SET @resultd = ''
		
	RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
