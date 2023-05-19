SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 
 
 
 
/* 
=======================================================================================
Author				:	JahabrYusuff M
Create date			:	23-Jan-2020
Description			:	to get the Doctor  Details
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_GetDoctorDetails]
	@DoctorCompanyId BIGINT,
	@DoctorId BIGINT
AS
BEGIN
	 SELECT ISNULL(D.dr_last_name,'')	+ ' ' + ISNULL(D.dr_first_name,'') + ' ' + ISNULL(D.dr_middle_initial,'') As DoctorFullName,
	 MDC.Name as CompanyName,D.DR_FIRST_NAME,D.DR_LAST_NAME,
	 D.TIME_DIFFERENCE, D.DR_MIDDLE_INITIAL,  D.DR_DEA_NUMB,
	 D.DR_ID, D.DG_ID, DG.DC_ID, DG.DG_NAME , D.DR_ADDRESS1, D.DR_ADDRESS2, D.DR_CITY,
      D.DR_STATE, D.DR_ZIP, D.DR_PHONE,D.DR_EMAIL,D.DR_FAX,D.DR_SUFFIX, D.DR_PREFIX
      FROM DOCTORS D WITH(NOLOCK)
      INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON D.DG_ID = DG.DG_ID 
      inner join	dbo.doc_companies	DC with(nolock)on			DC.dc_id				=	DG.dc_id
      inner join [dbo].[RsynMasterCompanyExternalAppMaps]	a1	with(nolock)	on a1.ExternalCompanyId	=	DC.DC_ID
      INNER JOIN [dbo].[RsynRxNTMasterCompaniesTable] MDC WITH(NOLOCK) ON MDC.CompanyId				=	a1.CompanyId
	  
      WHERE D.dr_id=@DoctorId AND DG.DC_ID = @DoctorCompanyId  AND D.DR_ENABLED = 1 
END
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
