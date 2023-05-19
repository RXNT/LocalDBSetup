SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[SearchReferralTargetDocsForAddreesBookSync]
AS 
	
	SELECT TOP 50
	  rtd.[target_dr_id] as primary_id
      ,rtd.[first_name] as first_name
      ,rtd.[last_name] as last_name
      ,rtd.[middle_initial] as middle_initial
      ,rtd.[GroupName]
      ,rtd.[address1] as address1
	  ,rtd.[address2] as address2
      ,rtd.[city] as city
	  ,(SELECT TOP 1 MAX(ZipCodeId) AS ZipCodeId
					FROM [dbo].[RsynRxNTMasterZipcodesTable] ZC  WITH(NOLOCK)
					INNER JOIN  [dbo].[RsynRxNTMasterStatesTable] ZST  WITH(NOLOCK)ON ZC.StateId=ZST.StateId
					WHERE  ZST.Code=rtd.[state]  AND SUBSTRING(ZC.ZipCode,0,6)=SUBSTRING(rtd.[zip] ,0,6) AND ZC.City=rtd.[city]
					GROUP BY ZST.StateId,Code,ZipCode,City
				) AS cityid
      ,rtd.[state] as statecode
	  ,ST.StateId stateid
	  ,ST.Name as state
      ,rtd.[zip] as zipcode
      ,rtd.[phone] as phone1
      ,rtd.[fax] as fax
      ,rtd.[dc_id] as dc_id
      ,rtd.[direct_email] as email
      ,rtd.[MasterContactId]
	   ,CMP.CompanyId AS CompanyIdV2
	   
 FROM 
 
	[dbo].[referral_target_docs] rtd  WITH(NOLOCK)
	INNER JOIN [dbo].[doc_companies] dc WITH(NOLOCK) ON rtd.dc_id= dc.dc_id
	INNER JOIN [dbo].[RsynRxNTMasterCompanyExternalAppMapsTable]  CEM WITH(NOLOCK) ON CEM.ExternalCompanyId = dc.dc_id 
	INNER JOIN [dbo].[RsynRxNTMasterApplicationsTable]  Appl WITH(NOLOCK) ON Appl.ApplicationId =  CEM.ExternalAppId AND  Appl.Code='EHRAP'
	INNER JOIN [dbo].[RsynRxNTMasterCompaniesTable] CMP WITH(NOLOCK) ON CEM.CompanyId = CMP.CompanyId
	LEFT JOIN  [dbo].[RsynRxNTMasterCompanyContactsTable] as VER_2  WITH(NOLOCK)  ON VER_2.ContactId = rtd.MasterContactId
	LEFT OUTER JOIN [dbo].[RsynRxNTMasterStatesTable] ST WITH(NOLOCK) ON  ST.Code=rtd.state
	WHERE rtd.ModifiedDate  > VER_2.ModifiedDate  AND  NOT EXISTS(SELECT * FROM 
	[dbo].[RsynRxNTMasterReferringProviderExternalAppMapsTable] RPE WITH(NOLOCK)
	INNER JOIN [dbo].[RsynRxNTMasterApplicationsTable] RefAppl WITH(NOLOCK) ON RefAppl.ApplicationId =  RPE.ExternalAppId AND  RefAppl.Code='EHRAP'
	WHERE RPE.ExternalReferringProviderId=rtd.target_dr_id)
	 
UNION 
SELECT TOP 50
	  rtd.[target_dr_id] as primary_id
      ,rtd.[first_name] as first_name
      ,rtd.[last_name] as last_name
      ,rtd.[middle_initial] as middle_initial
      ,rtd.[GroupName]
      ,rtd.[address1] as address1
	  ,rtd.[address2] as address2
      ,rtd.[city] as city
	  ,(SELECT TOP 1 MAX(ZipCodeId) AS ZipCodeId
					FROM [dbo].[RsynRxNTMasterZipcodesTable] ZC  WITH(NOLOCK)
					INNER JOIN  [dbo].[RsynRxNTMasterStatesTable] ZST  WITH(NOLOCK)ON ZC.StateId=ZST.StateId
					WHERE  ZST.Code=rtd.[state]  AND SUBSTRING(ZC.ZipCode,0,6)=SUBSTRING(rtd.[zip] ,0,6) AND ZC.City=rtd.[city]
					GROUP BY ZST.StateId,Code,ZipCode,City
				) AS cityid
      ,rtd.[state] as statecode
	  ,ST.StateId stateid
	  ,ST.Name as state
      ,rtd.[zip] as zipcode
      ,rtd.[phone] as phone1
      ,rtd.[fax] as fax
      ,rtd.[dc_id] as dc_id
      ,rtd.[direct_email] as email
      ,rtd.[MasterContactId]
	   ,CMP.CompanyId AS CompanyIdV2
	   
 FROM 
 
	[dbo].[referral_target_docs] rtd  WITH(NOLOCK)
	INNER JOIN [dbo].[doc_companies] dc WITH(NOLOCK) ON rtd.dc_id= dc.dc_id
	INNER JOIN [dbo].[RsynRxNTMasterCompanyExternalAppMapsTable]  CEM WITH(NOLOCK) ON CEM.ExternalCompanyId = dc.dc_id 
	INNER JOIN [dbo].[RsynRxNTMasterApplicationsTable]  Appl WITH(NOLOCK) ON Appl.ApplicationId =  CEM.ExternalAppId AND  Appl.Code='EHRAP'
	INNER JOIN [dbo].[RsynRxNTMasterCompaniesTable] CMP WITH(NOLOCK) ON CEM.CompanyId = CMP.CompanyId
	LEFT JOIN  [dbo].[RsynRxNTMasterCompanyContactsTable] as VER_2  WITH(NOLOCK)  ON VER_2.ContactId = rtd.MasterContactId
	LEFT OUTER JOIN [dbo].[RsynRxNTMasterStatesTable] ST WITH(NOLOCK) ON  ST.Code=rtd.state
	WHERE rtd.MasterContactId IS NULL  AND  NOT EXISTS(SELECT * FROM 
	[dbo].[RsynRxNTMasterReferringProviderExternalAppMapsTable] RPE WITH(NOLOCK)
	INNER JOIN [dbo].[RsynRxNTMasterApplicationsTable] RefAppl WITH(NOLOCK) ON RefAppl.ApplicationId =  RPE.ExternalAppId AND  RefAppl.Code='EHRAP'
	WHERE RPE.ExternalReferringProviderId=rtd.target_dr_id)
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
