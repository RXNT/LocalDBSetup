SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/30/2014
-- Description:	To get the doctor group application using type
-- =============================================
CREATE PROCEDURE [dbo].[FetchDoctorGroupApplication]
	@dg_id BIGINT  , 
	@applicationtypeid int  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS(SELECT 1 FROM applications app WITH(NOLOCK)
	INNER JOIN doc_group_application_map dg_app  WITH(NOLOCK) ON app.applicationid=dg_app.applicationid
	WHERE dg_app.dg_id=@dg_id AND app.applicationtypeid = @applicationtypeid )
	BEGIN
		SELECT TOP 1 app.applicationid, app.name, app.descrption, app.applicationtypeid, 
		app.applicationversionid, app.active, app.createddate, app.createdby, app.modifieddate, 
		app.modifiedby, app.inactivateddate, app.inactivatedby, app.isdefault,1 AS GroupEnabled
		FROM applications app  WITH(NOLOCK) 
		INNER JOIN doc_group_application_map dg_app  WITH(NOLOCK) ON app.applicationid=dg_app.applicationid
		WHERE dg_app.dg_id=@dg_id AND app.applicationtypeid = @applicationtypeid AND app.active=1
		ORDER BY app.ApplicationVersionID DESC
	END
	ELSE
	BEGIN
		SELECT  TOP 1 app.applicationid, app.name, app.descrption, app.applicationtypeid, 
		app.applicationversionid, app.active, app.createddate, app.createdby, app.modifieddate, 
		app.modifiedby, app.inactivateddate, app.inactivatedby, app.isdefault,0 AS GroupEnabled
		FROM applications app  WITH(NOLOCK)
		WHERE app.applicationtypeid = @applicationtypeid AND app.active=1 AND app.isdefault=1
		ORDER BY app.ApplicationVersionID DESC
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
