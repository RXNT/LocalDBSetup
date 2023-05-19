SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[SearchDirectEmailAddressBookForAddreesBookSync]
	AS
		BEGIN
			SELECT TOP 50 
				DEAB.[DirectAddressBookID] as primary_id
				,DEAB.[DirectAddressOwnerType]
				,DEAB.[OwnerEntityID]
				,DEAB.[DirectAddressFullName]
				,DEAB.[DirectAddress]
				,DEAB.[MasterContactId]
				,dr.dr_prefix as Prefix
				,dr.dr_first_name as first_name
				,dr.dr_middle_initial as middle_initial
				,dr.dr_last_name as last_name
				,dr.dr_suffix as suffix
				,CURRENT_TIMESTAMP as Concurrency
				,dr.dr_address1 as address1
				,dr.dr_address2 as address2
				,dr.dr_email as email
				,dr.dr_fax as fax
				,dr.dr_phone as phone1
				,dr.dr_phone_alt1 as phone2
				,dr.dr_phone_alt2 as phone3
				,dr.dr_phone_emerg as phone4
				,dr.dr_state as statecode
				,(SELECT TOP 1 MAX(ZipCodeId) AS ZipCodeId
					FROM [dbo].[RsynRxNTMasterZipcodesTable] ZC  WITH(NOLOCK)
					INNER JOIN  [dbo].[RsynRxNTMasterStatesTable] ZST  WITH(NOLOCK)ON ZC.StateId=ZST.StateId
					WHERE  ZST.Code=dr.dr_state  AND SUBSTRING(ZC.ZipCode,0,6)=SUBSTRING(dr.dr_zip ,0,6) AND ZC.City=dr.dr_city
					GROUP BY ZST.StateId,Code,ZipCode,City
				) AS cityid
				,dr.dr_city as city
				,dr.dr_zip  as zipcode 
				,dg.dc_id as CompanyIdV2
				, SUBSTRING(dr.dr_zip,0,6) dr_zip
				,dr.dr_city, ST.StateId
				FROM  [RxNT].[dbo].[direct_email_address_book] DEAB WITH(NOLOCK)
				LEFT JOIN [dbo].[RsynRxNTMasterCompanyContactsTable] as VER_2 WITH(NOLOCK) ON VER_2.ContactId = DEAB.MasterContactId
				LEFT JOIN [RxNT].[dbo].[doctors] dr WITH(NOLOCK) ON DEAB.OwnerEntityID=dr.dr_id
				LEFT JOIN [RxNT].[dbo].[doc_groups] dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id

				LEFT OUTER JOIN [dbo].[RsynRxNTMasterStatesTable] ST WITH(NOLOCK) ON  ST.Code=dr.dr_state 
				WHERE DEAB.ModifiedDate  > VER_2.ModifiedDate  AND DEAB.DirectAddressOwnerType=1


				UNION
				SELECT TOP 50 
				DEAB.[DirectAddressBookID] as primary_id
				,DEAB.[DirectAddressOwnerType]
				,DEAB.[OwnerEntityID]
				,DEAB.[DirectAddressFullName]
				,DEAB.[DirectAddress]
				,DEAB.[MasterContactId]
				
				,dr.dr_prefix as Prefix
				,dr.dr_first_name as first_name
				,dr.dr_middle_initial as middle_initial
				,dr.dr_last_name as last_name
				,dr.dr_suffix as suffix
				,CURRENT_TIMESTAMP as Concurrency
				,dr.dr_address1 as address1
				,dr.dr_address2 as address2
				,dr.dr_email as email
				,dr.dr_fax as fax
				,dr.dr_phone as phone1
				,dr.dr_phone_alt1 as phone2
				,dr.dr_phone_alt2 as phone3
				,dr.dr_phone_emerg as phone4
				,dr.dr_state as statecode
				,(SELECT TOP 1 MAX(ZipCodeId) AS ZipCodeId
					FROM [dbo].[RsynRxNTMasterZipcodesTable] ZC  WITH(NOLOCK)
					INNER JOIN  [dbo].[RsynRxNTMasterStatesTable] ZST  WITH(NOLOCK)ON ZC.StateId=ZST.StateId
					WHERE  ZST.Code=dr.dr_state  AND SUBSTRING(ZC.ZipCode,0,6)=SUBSTRING(dr.dr_zip ,0,6) AND ZC.City=dr.dr_city
					GROUP BY ZST.StateId,Code,ZipCode,City
				) as cityid
				,dr.dr_city as city
				,dr.dr_zip  as zipcode 
				,dg.dc_id as CompanyIdV2
				,dr.dr_zip
				,dr.dr_city, ST.StateId
				FROM  [RxNT].[dbo].[direct_email_address_book] DEAB 
				LEFT JOIN [dbo].[RsynRxNTMasterCompanyContactsTable] as VER_2 ON VER_2.ContactId = DEAB.MasterContactId
				LEFT JOIN [RxNT].[dbo].[doctors] dr ON DEAB.OwnerEntityID=dr.dr_id
				LEFT JOIN [RxNT].[dbo].[doc_groups] dg ON dr.dg_id=dg.dg_id

				LEFT OUTER JOIN [dbo].[RsynRxNTMasterStatesTable] ST WITH(NOLOCK) ON  ST.Code=dr.dr_state 
				 WHERE   DEAB.MasterContactId IS NULL AND DEAB.DirectAddressOwnerType=1;
		END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
