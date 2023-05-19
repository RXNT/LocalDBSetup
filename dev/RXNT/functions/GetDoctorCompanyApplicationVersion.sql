SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
        
      
      
CREATE FUNCTION [dbo].[GetDoctorCompanyApplicationVersion]       
(  
	@dc_id AS BIGINT,   -- Doctor Company Id
	@applicationtypename AS VARCHAR(100) -- Application type name
)      
RETURNS INT      

AS      
BEGIN      
	DECLARE @applicationversionid AS INT  
	
	IF EXISTS(SELECT 1 FROM applications app 
	INNER JOIN doc_group_application_map dg_app ON app.applicationid=dg_app.applicationid
	INNER JOIN doc_groups dg ON dg.dg_id = dg_app.dg_id
	INNER JOIN applicationtypes at ON app.applicationtypeid=at.applicationtypeid
	WHERE dg.dc_id=@dc_id AND at.applicationtypename = @applicationtypename )
	BEGIN
		-- If the Doctor Group has the application mapping
		SELECT TOP 1  @applicationversionid = app.applicationversionid
		FROM applications app 
		INNER JOIN doc_group_application_map dg_app ON app.applicationid=dg_app.applicationid
		INNER JOIN doc_groups dg ON dg.dg_id = dg_app.dg_id
		INNER JOIN applicationtypes at ON app.applicationtypeid=at.applicationtypeid
		WHERE dg.dc_id=@dc_id AND at.applicationtypename = @applicationtypename AND app.active=1
		ORDER BY app.applicationid DESC
	END
	ELSE
	BEGIN
		-- If the Doctor Group has not the application mapping it will select the default
		SELECT  TOP 1 @applicationversionid = app.applicationversionid
		FROM applications app
		INNER JOIN applicationtypes at ON app.applicationtypeid=at.applicationtypeid
		WHERE at.applicationtypename = @applicationtypename AND app.active=1 AND app.isdefault=1
		ORDER BY app.applicationid DESC
	END
	
	RETURN @applicationversionid      
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
