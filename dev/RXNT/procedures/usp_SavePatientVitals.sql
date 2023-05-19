SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 27-May-2016
-- Description:	Save Patient Vitals
-- =============================================

CREATE PROCEDURE [dbo].[usp_SavePatientVitals]
(
	@PatientVitalsId INT OUTPUT,
	@PatientId INT,
	@Weight FLOAT,
	@Height FLOAT,
	@Pulse FLOAT,
	@BPSystolic FLOAT,
	@BPDiastolic FLOAT,
	@Glucose FLOAT,
	@Respiration FLOAT,
	@Temperature FLOAT,
	@BMI FLOAT,
	@Age INT,
	@EntryDate DATETIME,
	@AddedByPrescriberId INT,
	@RecordDate DATETIME,
	@Oxygen FLOAT,
	@HeadCircumference FLOAT,
	@BPLocationSitting INT,
	@BPSysStatnding FLOAT,
	@BPDiaStatnding FLOAT,
	@BPLocationStatnding INT,
	@BPSysSupine FLOAT,
	@BPDysSupine FLOAT,
	@BPLocationSupine INT,
	@TemperatureMethod INT,
	@PulseRhythmSitting INT,
	@PulseStanding FLOAT,
	@PulseSupine FLOAT,
	@PulseRhythmStanding INT,
	@PulseRhythmSupine INT,
	@RespirationQuality INT,
	@HeartRate FLOAT,
	@FiO2 FLOAT,
	@Flow FLOAT,
	@Comment VARCHAR(MAX),
	@Active BIT,	
	@GroupId INT,
	@DoctorId INT
)
AS
BEGIN
	IF ISNULL(@PatientVitalsId, 0) = 0
	BEGIN
		INSERT INTO [dbo].[patient_vitals] 
		([pa_id],[pa_wt],[pa_ht],[pa_pulse],[pa_bp_sys],[pa_bp_dys],[pa_glucose],[pa_resp_rate],[pa_temp],[pa_bmi],[age]
		,[date_added],[dg_id],[added_by],[added_for],[record_date],[pa_oxm],[pa_hc],[pa_bp_location],[pa_bp_sys_statnding]
		,[pa_bp_dys_statnding],[pa_bp_location_statnding],[pa_bp_sys_supine],[pa_bp_dys_supine],[pa_bp_location_supine]
		,[pa_temp_method],[pa_pulse_rhythm],[pa_pulse_standing],[pa_pulse_rhythm_standing],[pa_pulse_supine]
		,[pa_pulse_rhythm_supine],[pa_heart_rate],[pa_fio2],[pa_flow],[pa_resp_quality],[pa_comment], [active], [last_modified_date], [last_modified_by])
		VALUES
		(@PatientId,@Weight,@Height,@Pulse,@BPSystolic, @BPDiastolic, @Glucose, @Respiration, @Temperature, @BMI, @Age
		,@EntryDate, @GroupId, @AddedByPrescriberId, @DoctorId, @RecordDate, @Oxygen, @HeadCircumference, @BPLocationSitting, @BPSysStatnding
		,@BPDiaStatnding, @BPLocationStatnding, @BPSysSupine, @BPDysSupine, @BPLocationSupine
		,@TemperatureMethod, @PulseRhythmSitting, @PulseStanding,@PulseRhythmStanding, @PulseSupine
		,@PulseRhythmSupine, @HeartRate, @FiO2, @Flow, @RespirationQuality, @Comment, @Active, GETDATE(), @AddedByPrescriberId)
		
		SET @PatientVitalsId = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE [patient_vitals] 
		SET [pa_wt] = @Weight,[pa_oxm]=@Oxygen,[pa_hc]=@HeadCircumference,[pa_ht] = @Height,[pa_pulse] = @Pulse, [age] = @Age,
		 [pa_bp_sys] = @BPSystolic,[pa_bp_dys] = @BPDiastolic,[pa_glucose] = @Glucose,[pa_resp_rate] = @Respiration,
		 [pa_temp] = @Temperature,[pa_bmi] = @BMI,[added_by] = @AddedByPrescriberId, record_modified_date=getdate(),
		 [pa_bp_location]=@BPLocationSitting,[pa_bp_sys_statnding]=@BPSysStatnding,[pa_bp_dys_statnding]=@BPDiaStatnding,[pa_bp_location_statnding]=@BPLocationStatnding,
		 [pa_bp_sys_supine]=@BPSysSupine,[pa_bp_dys_supine]=@BPDysSupine,[pa_bp_location_supine]=@BPLocationSupine,
		 [pa_temp_method]=@TemperatureMethod,[pa_pulse_rhythm]=@PulseRhythmSitting,[pa_pulse_standing]=@PulseStanding,
		 [pa_pulse_rhythm_standing]=@PulseRhythmStanding,[pa_pulse_supine]=@PulseSupine,[pa_pulse_rhythm_supine]=@PulseRhythmSupine,
		 [pa_heart_rate]=@HeartRate,[pa_fio2]=@FiO2,[pa_flow]=@Flow,[pa_resp_quality]=@RespirationQuality,[pa_comment]=@Comment,[record_date] = @RecordDate,  
		 [last_modified_date] = GETDATE(), [last_modified_by] = @AddedByPrescriberId
		WHERE pa_id= @PatientId and pa_vt_id =  @PatientVitalsId
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
