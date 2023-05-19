SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author				:	<Author,,Name>
-- Create date			:	<Create Date,,>
-- Description			:	<Description,,>
-- Last Modified By		:	Nambi
-- Last Modifed Date	:	20-JULY-2021
-- Last Modification	:	ADV2-1563: added prescribing authority to select list
-- =============================================
CREATE PROCEDURE [dbo].[usp_SSOAuthentication] 
	(@userName VARCHAR(50),@password VARCHAR(250), @IsAuthenticateUserByToken BIT = 0)
AS
DECLARE @DGID AS BIGINT
DECLARE @DRID AS BIGINT
DECLARE @DCID AS BIGINT
BEGIN
	SELECT @DRID=DR_ID,@DGID = DG_ID FROM DOCTORS WITH(NOLOCK) WHERE DR_USERNAME=@userName AND (@IsAuthenticateUserByToken = 1 OR (ISNULL(@IsAuthenticateUserByToken, 0) = 0 AND DR_PASSWORD=@password))
	-- AND DR_ENABLED=1  
	AND LOGINLOCK = 0 AND LOWUSAGE_LOCK = 0
	
	IF @DRID<>'' AND @DGID<>'' 
		 BEGIN
			SELECT D.DR_ID,D.DR_USERNAME,DC.dc_name,D.DG_ID,DG.DC_ID,DR_FIRST_NAME,DR_LAST_NAME,DR_EMAIL,D.NPI, D.ISMIGRATED,D.professional_designation,
			DATEDIFF(dd, GETDATE(), D.password_expiry_date) AS 'DaysToExpire',D.dr_enabled AS Active,
			DG.dg_name,PA.isSingleSignOn,SP.email as rep_email, D.prescribing_authority
			FROM DOCTORS  D WITH(NOLOCK)
			INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON DG.DG_ID=D.DG_ID
			INNER JOIN DOC_COMPANIES DC WITH(NOLOCK) ON DC.DC_ID=DG.DC_ID
			LEFT JOIN PARTNER_ACCOUNTS PA WITH(NOLOCK) ON PA.PARTNER_ID = DC.partner_id
			LEFT JOIN RXNT.dbo.sales_person_info SP WITH(NOLOCK) ON SP.sale_person_id = D.sales_person_id
			WHERE DR_ID=@DRID
			
			SELECT '' AS APPLICATIONID,'eHr' AS NAME,'eRx | eHr' AS APPLICATIONTYPENAME,DI.VERSIONURL AS APPLICATIONVERSION,'' AS APPLICATIONURL,  DCH.DC_HOST_NAME AS APPHOSTNAME,DCH.DC_HOST_LOGIN_PROTO AS APPHOSTPROTOCAL
			FROM DOCTORS D
			INNER JOIN DOCTOR_INFO DI ON DI.DR_ID=D.DR_ID
			INNER JOIN DOC_GROUPS DG ON DG.DG_ID=D.DG_ID
			INNER JOIN DOC_COMPANIES DC ON DC.DC_ID=DG.DC_ID
			INNER JOIN DOC_COMPANY_HOSTS DCH ON DCH.DC_HOST_ID=DC.DC_HOST_ID
			WHERE D.DR_ID=@DRID			
		 END
	ELSE
		BEGIN
			RAISERROR (15600,-1,-1, 'Invalid Username or Password');
		END		 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO