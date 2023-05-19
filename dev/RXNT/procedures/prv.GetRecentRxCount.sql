SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[GetRecentRxCount]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @PreferredPrescriberId BIGINT = 0;
	
	SELECT @PreferredPrescriberId=di.staff_preferred_prescriber 
	FROM dbo.doctor_info di WITH(NOLOCK)
	WHERE di.dr_id=@UserId 
	
	IF(@PreferredPrescriberId>0)
	BEGIN
		SET @UserId = @PreferredPrescriberId;
		SET @IsRestrictToPersonalRx = 1;
	END
	Declare @Count as int
	IF @DoctorGroupId = 4 
	BEGIN
				SELECT @Count=COUNT(1) FROM prescriptions WITH(NOLOCK) INNER JOIN patients WITH(NOLOCK) ON 
				prescriptions.pa_id = patients.pa_id INNER JOIN doctors WITH(NOLOCK) ON prescriptions.dr_id = 
				doctors.dr_id  INNER JOIN prescription_details WITH(NOLOCK) ON prescriptions.pres_id = 
				prescription_details.pres_id  LEFT OUTER JOIN prescription_status  WITH(NOLOCK) ON 
				prescription_details.pd_id = prescription_status.pd_id  LEFT OUTER JOIN DOCTORS 
				PRIM_DOCS WITH(NOLOCK) ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID 
				LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id WHERE 
				prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL)) 
				AND (prescriptions.pres_void = 0) AND doctors.dg_id =@DoctorGroupId AND 
				prescriptions.dg_id= @DoctorGroupId  
	END
	ELSE
	BEGIN	
		IF @IsRestrictToPersonalRx = 1 
			BEGIN
				SELECT @Count=COUNT(1)  FROM prescriptions WITH(NOLOCK) INNER JOIN patients WITH(NOLOCK)
				ON prescriptions.pa_id = patients.pa_id  INNER JOIN doctors WITH(NOLOCK) ON 
				prescriptions.dr_id = doctors.dr_id  INNER JOIN prescription_details  WITH(NOLOCK) ON 
				prescriptions.pres_id = prescription_details.pres_id  LEFT OUTER JOIN 
				prescription_status WITH(NOLOCK) ON prescription_details.pd_id = prescription_status.pd_id  
				LEFT OUTER JOIN DOCTORS PRIM_DOCS WITH(NOLOCK) ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID  
				LEFT OUTER JOIN PHARMACIES  PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id			
				WHERE prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL))
				AND (prescriptions.pres_void = 0) AND doctors.dr_id = @UserId AND 
				prescriptions.dr_id= @UserId  AND PRES_APPROVED_DATE > 
				dateadd(dd, -7, getdate())  
			END
		ELSE
			BEGIN
				SELECT @Count=COUNT(1) FROM prescriptions WITH(NOLOCK) INNER JOIN patients ON 
				prescriptions.pa_id = patients.pa_id INNER JOIN doctors WITH(NOLOCK) ON prescriptions.dr_id = 
				doctors.dr_id  INNER JOIN prescription_details WITH(NOLOCK) ON prescriptions.pres_id = 
				prescription_details.pres_id  LEFT OUTER JOIN prescription_status WITH(NOLOCK) ON 
				prescription_details.pd_id = prescription_status.pd_id  LEFT OUTER JOIN DOCTORS PRIM_DOCS WITH(NOLOCK) 
				 ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID 
				LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id WHERE 
				prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL)) 
				AND (prescriptions.pres_void = 0) AND doctors.dg_id =@DoctorGroupId AND 
				prescriptions.dg_id= @DoctorGroupId  AND PRES_APPROVED_DATE > 
				dateadd(dd, -7, getdate())  
			END
		END   
	
	If @Count>75
	Begin
		Set @Count=75
	End
	Select @Count as RecentRxCount
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
