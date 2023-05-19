SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to get pending deduplication dc request
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_GetPendingDoctorCompanyDeduplicateRequests]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	SMDR.*, SPS.Code, SPS.Name, CMP.dc_Name As CompanyName
	FROM	rpt.DoctorCompanyDeduplicateRequests SMDR WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes SPS WITH (NOLOCK) ON SPS.ProcessStatusTypeId = SMDR.ProcessStatusTypeId
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) on CMP.dc_id = SMDR.CompanyId
	WHERE	SPS.Code = 'PENDG' 
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
