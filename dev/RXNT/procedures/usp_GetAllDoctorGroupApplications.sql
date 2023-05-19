SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 17-May-2016
-- Description:	Get All RxNT Applications for doctor group
-- =============================================

CREATE PROCEDURE [dbo].[usp_GetAllDoctorGroupApplications]
@dg_id BIGINT
AS
BEGIN
		SELECT app.applicationid, app.name, app.descrption, app.applicationtypeid, 
		app.applicationversionid, app.active, app.createddate, app.createdby, app.modifieddate, 
		app.modifiedby, app.inactivateddate, app.inactivatedby, app.isdefault,dg_app.dg_id
		FROM applications app 
		INNER JOIN doc_group_application_map dg_app ON app.applicationid=dg_app.applicationid
		WHERE dg_app.dg_id = @dg_id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
