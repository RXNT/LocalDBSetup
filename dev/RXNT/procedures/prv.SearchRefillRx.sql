SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[SearchRefillRx]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @IsAgent bit=0, @PatientFirstName varchar(50)=NULL, @PatientLastName varchar(50)=NULL, @RowLimit int=NULL
AS
BEGIN
	SET NOCOUNT ON;

	SET @RowLimit = ISNULL(@RowLimit,75)
	IF @RowLimit <= 0 
		SET @RowLimit = 75
	
	
	DECLARE @PreferredPrescriberId BIGINT = 0;
	
	SELECT @PreferredPrescriberId=di.staff_preferred_prescriber 
	FROM dbo.doctor_info di WITH(NOLOCK)
	WHERE di.dr_id=@UserId 
	
	IF(@PreferredPrescriberId>0)
	BEGIN
		SET @UserId = @PreferredPrescriberId;
		SET @IsRestrictToPersonalRx = 1;
	END

	IF @IsRestrictToPersonalRx = 1 
		BEGIN
			IF @IsAgent = 1 
				BEGIN
					SELECT TOP (@RowLimit) A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,
					(select COUNT (1)  FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = A.pa_id AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '' )
						 ) AS patient_details_missing
					FROM vwDrPendingPrescriptionLog A WITH(NOLOCK)
					LEFT OUTER JOIN Doctors PRIM_DOCS WITH(NOLOCK) on A.prim_dr_id = PRIM_DOCS.DR_ID 
					WHERE A.PRIM_DR_ID = @UserId
					AND PRES_PRESCRIPTION_TYPE = 2 AND(@PatientFirstName IS NULL OR A.pa_first LIKE @PatientFirstName+'%') AND(@PatientLastName IS NULL OR A.pa_last LIKE @PatientLastName+'%')
					ORDER BY pres_entry_date DESC
				END
			ELSE
				BEGIN
					SELECT TOP (@RowLimit)  A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,
					(select COUNT (1)  FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = A.pa_id AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '' )
						 ) AS patient_details_missing
					FROM vwDrPendingPrescriptionLog A WITH(NOLOCK)
					LEFT OUTER JOIN Doctors PRIM_DOCS WITH(NOLOCK) on A.prim_dr_id = PRIM_DOCS.DR_ID 
					WHERE A.DR_ID = @UserId 
					AND PRES_PRESCRIPTION_TYPE = 2 AND(@PatientFirstName IS NULL OR A.pa_first LIKE @PatientFirstName+'%') AND(@PatientLastName IS NULL OR A.pa_last LIKE @PatientLastName+'%')
					ORDER BY pres_entry_date DESC
				END		
		END
	ELSE
		BEGIN
			SELECT TOP (@RowLimit) A.*, PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,
			(select COUNT (1)  FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = A.pa_id AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '' )
						 ) AS patient_details_missing
			FROM vwDrPendingPrescriptionLog A WITH(NOLOCK)
			LEFT OUTER JOIN Doctors PRIM_DOCS WITH(NOLOCK) on A.prim_dr_id = PRIM_DOCS.DR_ID 
			WHERE A.DG_ID = @DoctorGroupId
			AND PRES_PRESCRIPTION_TYPE = 2 AND(@PatientFirstName IS NULL OR A.pa_first LIKE @PatientFirstName+'%') AND(@PatientLastName IS NULL OR A.pa_last LIKE @PatientLastName+'%')
			ORDER BY pres_entry_date DESC
		END   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
