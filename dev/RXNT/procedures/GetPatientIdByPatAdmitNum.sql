SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji>
-- Create date: <02-29-2016>
-- Description:	<Get Patint Id by PatAdmitNum>
-- =============================================
CREATE PROCEDURE [dbo].[GetPatientIdByPatAdmitNum]
	-- Add the parameters for the stored procedure here
	@PatientIdentifier bigint OUTPUT,
	@LastName varchar(50),
	@FirstName varchar(50),
	@PatAddress1 varchar(50),
	@PatAddress2 varchar(50),
	@PatCity varchar(50),
	@PatState varchar(50),
	@PatZip varchar(50),	
	@PatHomePhone varchar(50),
	@PatBirthDate datetime,
	@PatGender varchar(50),
	@PatEthnCode varchar(50),
	@PatHeight varchar(50),
	@PatWeight varchar(50),
	@PatMarStat varchar(50),
	@PatMarStatDesc varchar(50),
	@PatAdmitNum varchar(50),
	@pa_ext_ssn_no varchar(50),
	@DCID int,
	@PatAltId varchar(100) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Set @PatientIdentifier=0

	
	If Exists(select * from patients PAT WITH(NOLOCK) 
		where PAT.dg_id in 
		(select dg_id from doc_groups with(nolock) 
			where dc_id = @DCID
		) 
		and pa_ssn =@PatAdmitNum 
		and pa_last=@LastName 
		and pa_first=@FirstName
	)
	Begin
		select top 1  @PatientIdentifier =pa_id from patients WITH(NOLOCK) 
		where dg_id in (select dg_id from doc_groups with(nolock) where dc_id = @DCID) 
		and pa_ssn =@PatAdmitNum and pa_last=@LastName and pa_first=@FirstName
		ORDER BY pa_id DESC
	End
	If @PatientIdentifier=0 And Not(@PatAltId Is NULL)
	Begin
		If Exists(select * from patients PAT WITH(NOLOCK) 
			LEFT OUTER JOIN patient_identifiers PI with(nolock) on PAT.pa_id = PI.pa_id
			LEFT OUTER JOIN patient_identifier_keys PK with(nolock) on PI.pik_id = PI.pik_id
			WHERE 
			PK.dc_id = @DCID
			AND PK.keyname = 'AlternativeID'
			AND PI.value = @PatAltId
			AND PAT.dg_id in 
			(select dg_id from doc_groups with(nolock) 
				where dc_id = @DCID
			) 
		)
		BEGIN
			select top 1  @PatientIdentifier = PAT.pa_id from patients PAT WITH(NOLOCK) 
			LEFT OUTER JOIN patient_identifiers PI with(nolock) on PAT.pa_id = PI.pa_id
			LEFT OUTER JOIN patient_identifier_keys PK with(nolock) on PI.pik_id = PI.pik_id
			WHERE 
			PK.dc_id = @DCID
			AND PK.keyname = 'AlternativeID'
			AND PI.value = @PatAltId
			AND PAT.dg_id in 
			(select dg_id from doc_groups with(nolock) 
				where dc_id = @DCID
			) 
			ORDER BY  PAT.pa_id  DESC
		END
	End
	--PRINT @PatientIdentifier
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
