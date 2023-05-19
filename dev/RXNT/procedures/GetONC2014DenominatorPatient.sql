SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetONC2014DenominatorPatient] 
	@encounteronly BIT,
	@drid BIGINT,
	@dtstart DATETIME,
	@dtend DATETIME,
	@measuretype AS INT
AS
BEGIN
	IF @measureType <>0
	BEGIN
		IF @measureType = 1
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct s.pa_id, pmc.pa_id ad_id from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e 
					WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S 
					left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=6 AND pmc.rec_date <= @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
			ELSE 
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					from (SELECT distinct s.pa_id, pmc.pa_id ad_id from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE DR_ID=@DRID AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0 and pres_approved_date between @DTSTART and @DTEND 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S 
					left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=6 AND pmc.rec_date <= @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
		END
		
		IF @measureType = 2
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					from (SELECT distinct s.pa_id, pmc.pa_id ad_id from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) 
					WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S 
					left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=7 AND pmc.rec_date <= @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					from (SELECT distinct s.pa_id, pmc.pa_id ad_id from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE DR_ID=@DRID and pres_approved_date between @DTSTART and @DTEND AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S 
					left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=7 AND pmc.rec_date <= @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END	
		END
		IF @measureType = 3
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					from (SELECT distinct s.pa_id, pmc.pa_id ad_id  from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) 
					WHERE E.dr_id = @DRID and enc_date between @DTSTART and @dtend and issigned =1) S 
					left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=8 AND pmc.rec_date <= @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id  
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					from (SELECT distinct s.pa_id, pmc.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE pres_approved_date between @DTSTART and @DTEND  AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 and DR_ID=@DRID 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @dtend and issigned =1) S 
					left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=8 AND pmc.rec_date <= @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END	
		END
		IF @measureType = 4
		BEGIN
			IF @encounteronly=1
				BEGIN
					SELECT DISTINCT r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					FROM (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) 
					WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
			ELSE
				BEGIN
					SELECT DISTINCT r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					FROM (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE pres_approved_date between @DTSTART and @DTEND AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 and DR_ID=@DRID 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END	
		END
		IF @measureType = 5
		BEGIN
			IF @encounteronly=1
				BEGIN
					SELECT distinct s.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) 
					WHERE E.dr_id = @DRID and e.enc_date between @DTSTART and @DTEND and issigned =1 ) S 
					left outer join (select * from patient_measure_compliance pad with(nolock) 
					where pad.rec_date between @DTSTART and @DTEND and pad.rec_type = 2 and dr_id =@DRID) r on s.pa_id = r.pa_id 
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
			ELSE
				BEGIN
					SELECT distinct s.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					where pres_approved_date between @DTSTART and @DTEND AND PRES_PRESCRIPTION_TYPE = 1  and DR_ID=@DRID 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and e.enc_date between @DTSTART and @DTEND and issigned =1 ) S 
					left outer join (select * from patient_measure_compliance pad with(nolock) 
					where pad.rec_date between @DTSTART and @DTEND and pad.rec_type = 2 and dr_id =@DRID) r on s.pa_id = r.pa_id
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END
		END
		IF @measureType = 6
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					FROM (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT E.patient_id pa_id 
					FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S 
					left outer join patient_reg_db pad with(nolock)  on s.pa_id = pad.pa_id) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  
					FROM (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE DR_ID=@DRID AND PRES_VOID = 0   AND PRES_PRESCRIPTION_TYPE = 1 and pres_approved_date between @DTSTART and @DTEND 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S 
					left outer join patient_reg_db pad with(nolock)  on s.pa_id = pad.pa_id) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END	
		END
		IF @measureType = 71
		BEGIN
			SET NOCOUNT ON;
			with 
				patient_encounter As (
					SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1
				),
				Denominator_Data As(
					select Distinct s.pa_id,@drid As doctorID from patient_encounter  s inner join 
						prescriptions pres  with(nolock) on s.pa_id = pres.pa_id where pres.pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND
						and pres.pres_approved_date is not null
				)
				
				select r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
				from Denominator_Data r 
				LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
			SET NOCOUNT OFF;	
		END
		IF @measureType = 7
		BEGIN
			SET NOCOUNT ON;
			select  r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
			from (SELECT distinct pa_id, pres.pres_id ad_id,1 AS type from prescriptions pres  with(nolock) 
			where pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND AND dr_id=@DRID And (pres.pres_approved_date is not null)
			UNION 
			SELECT distinct pa_id, pam.pam_id ad_id,2 AS type from patient_medications_hx pam with(nolock)  
			where pam.date_added between @DTSTART and @DTEND AND (added_by_dr_id=@DRID or for_dr_id=@DRID)) r
			LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
			SET NOCOUNT OFF;
		END
		IF @measureType = 8
		BEGIN
			select  p.pa_id as Patient,pa.pa_first as FirstName,pa.pa_last as LastName,pa.pa_dob as DateOfBirth,pa.pa_sex as sex,pa.pa_address1 as Address1,pa.pa_city as City,pa.pa_state as [State],pa.pa_zip as ZipCode,pa.pa_ssn as chart
			from prescriptions p  with(nolock) 
			inner join prescription_details pd with(nolock) on p.pres_id = pd.pres_id 
			inner join RMIID1 r with(nolock) on pd.ddid = r.MEDID 
			LEFT OUTER JOIN patients pa with(nolock) on p.pa_id=pa.pa_id
			where pres_entry_date between @DTSTART and @DTEND and pres_void = 0 and not(pres_approved_date is null) 
			and p.dr_id = @DRID and r.MED_REF_DEA_CD < 2
			
		END
		IF @measureType = 9
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					FROM (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK)
					INNER JOIN patients pat ON pat.pa_id =E.patient_id WHERE DATEDIFF(MONTH,pat.pa_dob,enc_date)>=2*12 AND E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S 
					left outer join patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
					AND pad.pa_ht>0 AND pad.pa_wt>0 AND pad.pa_bp_sys>0 AND pad.pa_bp_dys >0) r 
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					FROM (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE DR_ID=@DRID  AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  and pres_approved_date between @DTSTART and @DTEND UNION SELECT DISTINCT E.patient_id 
					FROM enchanced_encounter e WITH(NOLOCK) 
					INNER JOIN patients pat ON pat.pa_id =e.patient_id WHERE DATEDIFF(MONTH,pa_dob,enc_date)>=2*12 AND E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S  
					left outer join patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
					AND pad.pa_ht>0 AND pad.pa_wt>0 AND pad.pa_bp_sys>0 AND pad.pa_bp_dys >0) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END	
		END
		IF @measureType = 92
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					FROM (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK)
					INNER JOIN patients pat ON pat.pa_id =E.patient_id WHERE DATEDIFF(MONTH,pat.pa_dob,enc_date)>=2*12 AND E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S 
					left outer join  patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
					AND pad.pa_ht>0 AND pad.pa_wt>0 AND CASE WHEN age >=3 THEN pad.pa_bp_sys ELSE 1 END >0 AND CASE WHEN age>=3 THEN pad.pa_bp_dys ELSE 1 END >0 ) r 
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE DR_ID=@DRID  AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  and pres_approved_date between @DTSTART and @DTEND UNION SELECT DISTINCT E.patient_id 
					FROM enchanced_encounter e WITH(NOLOCK) INNER JOIN patients pat ON pat.pa_id =e.patient_id WHERE  E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S  
					left outer join patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
					AND pad.pa_ht>0 AND pad.pa_wt>0 AND CASE WHEN age >=3 THEN pad.pa_bp_sys ELSE 1 END >0 AND CASE WHEN age>=3 THEN pad.pa_bp_dys ELSE 1 END >0 ) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END	
		END
		IF @measureType = 93
		BEGIN
			SET NOCOUNT ON;
				select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
				from (SELECT distinct s.pa_id, pad.pa_id ad_id  from 
				(SELECT E.patient_id pa_id,MAX(e.enc_date)encounter_date,MAX(pat.pa_dob) pa_dob FROM 
				enchanced_encounter e WITH(NOLOCK)INNER JOIN 
				patients pat WITH(NOLOCK) ON pat.pa_id =E.patient_id 
				WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 group by E.patient_id) S
				left outer join  patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
				AND CASE WHEN (DATEDIFF(MONTH,S.pa_dob,S.encounter_date)>=12*2 OR ( pad.pa_ht>0 AND  pad.pa_wt>0)) THEN 1 ELSE 0 END >0) r
				LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id  		
			SET NOCOUNT OFF;
		END
		IF @measureType = 94
		BEGIN
			SET NOCOUNT ON;
				select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
				from (SELECT distinct s.pa_id, pad.pa_id ad_id  from 
				(SELECT E.patient_id pa_id,MAX(e.enc_date)encounter_date,MAX(pat.pa_dob) pa_dob FROM 
				enchanced_encounter e WITH(NOLOCK)INNER JOIN 
				patients pat WITH(NOLOCK) ON pat.pa_id =E.patient_id 
				WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 group by E.patient_id) S
				left outer join  patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
				AND CASE WHEN (DATEDIFF(MONTH,S.pa_dob,S.encounter_date)>=12*2 OR pad.pa_bp_sys>0) THEN 1 ELSE 0 END >0) r
				LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
			SET NOCOUNT OFF;
		END
		IF @measureType = 10
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM PATIENTS 
					WHERE DATEDIFF(YYYY, PA_DOB, GETDATE()) >= 13 AND PA_ID IN (SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) 
					WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)) S 
					left outer join patient_flag_details pad with(nolock)  on s.pa_id = pad.pa_id and ((pad.flag_id between 5 and 8) OR pad.flag_id < 0)) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM PATIENTS 
					WHERE DATEDIFF(YYYY, PA_DOB, GETDATE()) >= 13 AND PA_ID IN (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE DR_ID=@DRID AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  AND pres_approved_date between @DTSTART and @DTEND UNION SELECT DISTINCT E.patient_id 
					FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)) S 
					left outer join patient_flag_details pad with(nolock)  on s.pa_id = pad.pa_id and ((pad.flag_id between 5 and 8) OR pad.flag_id < 0)) r 
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END	
		END
		IF @measureType = 11
		BEGIN
			SET NOCOUNT ON;
				SELECT a.pat_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
				FROM lab_main a with(nolock)
				INNER JOIN lab_order_info b with(nolock) ON a.lab_id = b.lab_id 
				INNER JOIN lab_result_info LRI with(nolock) on b.lab_report_id = LRI.lab_order_id
				LEFT OUTER JOIN patients p with(nolock) on a.pat_id=p.pa_id
				WHERE a.DR_ID=@DRID and a.message_date between @DTSTART and @DTEND 
			SET NOCOUNT OFF;
		END
		IF @measureType = 12
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (  SELECT PA_ID FROM PATIENTS PA WITH(NOLOCK) 
					WHERE PA_ID IN ( SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @dtstart and @dtend and issigned =1))  S 
					left outer join PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on s.pa_id = pad.pa_id and pad.REC_TYPE = 5 and pad.rec_date between @DTSTART and @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (  SELECT PA_ID FROM PATIENTS PA WITH(NOLOCK) WHERE PA_ID IN ( SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) 
					WHERE DR_ID=@DRID AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 and pres_approved_date between @dtstart and @dtend 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @dtstart and @dtend and issigned =1))  S 
					left outer join PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on s.pa_id = pad.pa_id and pad.REC_TYPE = 5 and pad.rec_date between @DTSTART and @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END	
		END
		IF @measureType = 122
		BEGIN
			IF @encounteronly=1
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (  SELECT PA_ID FROM PATIENTS PA WITH(NOLOCK) WHERE PA_ID IN ( SELECT DISTINCT E.patient_id pa_id 
					FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @dtstart and @dtend and issigned =1))  S 
					left outer join PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on s.pa_id = pad.pa_id and pad.REC_TYPE = 5 and pad.rec_date between @DTSTART and @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END
			ELSE
				BEGIN
					select distinct r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (  SELECT PA_ID FROM PATIENTS PA WITH(NOLOCK) 
					WHERE PA_ID IN ( SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE DR_ID=@DRID AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 and pres_approved_date between @dtstart and @dtend 
					UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @dtstart and @dtend and issigned =1))  S 
					left outer join PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on s.pa_id = pad.pa_id and pad.REC_TYPE = 5 and pad.rec_date between @DTSTART and @DTEND) r
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END	
		END
		IF @measureType = 13
		BEGIN
			IF @encounteronly=1
				BEGIN
					select DISTINCT r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct PA_ID, MAX(ENC_DATE) ENC_DATE FROM (select patient_id pa_id, MAX(enc_date) enc_date 
					from enchanced_encounter  with(nolock) where dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 And type_of_visit like 'OFICE' 
					group by patient_id, enc_date) S GROUP BY S.pa_id) R 
					left outer join (select distinct pa_id,rec_date from patient_measure_compliance where rec_date between @dtstart and @dtend and rec_type =5 ) s on r.pa_id = s.pa_id 
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id  
				END
			ELSE
				BEGIN
					select DISTINCT r.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
					from (SELECT distinct PA_ID, MAX(ENC_DATE) ENC_DATE FROM ( SELECT pa_id, MAX(pres_approved_date) enc_date FROM  prescriptions with(nolock) 
					where dr_id = @DRID AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  and pres_approved_date between @DTSTART and @DTEND group by pa_id,pres_approved_date 
					union select patient_id pa_id, MAX(enc_date) enc_date from enchanced_encounter  with(nolock) 
					where dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 And type_of_visit like 'OFICE' group by patient_id, enc_date) S GROUP BY S.pa_id) R 
					left outer join ( select distinct pa_id,rec_date from patient_measure_compliance where rec_date between @dtstart and @dtend and rec_type =5  ) s on r.pa_id = s.pa_id  
					LEFT OUTER JOIN patients p with(nolock) on r.pa_id=p.pa_id 
				END	
		END
		IF @measureType = 14
		BEGIN
			SET NOCOUNT ON;
			DECLARE @Temp TABLE
			(
			NUMPATIENT BIGINT,
			DENOMPATIENT BIGINT
			)
			INSERT INTO @Temp
			SELECT 
			case when pad.pa_id is null then 0 ELSE pad.pa_id END NUMPATIENT,
			case when pa.pa_id > 0 THEN pa.pa_id ELSE 0 END DENOMPATIENT
			FROM PATIENTS PA WITH(NOLOCK) 
			INNER JOIN enchanced_encounter pen with(nolock) ON pen.patient_id=PA.pa_id
			LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS paext with(nolock) on paext.pa_id=PA.pa_id
			LEFT OUTER JOIN patient_flag_details PFD WITH(NOLOCK) ON PA.pa_id=PFD.pa_id
			LEFT OUTER JOIN PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on pa.pa_id = pad.pa_id 
			AND pad.REC_TYPE = 3 and pad.rec_date between @DTSTART and @DTEND
			WHERE 
			PA.dg_id in 
			(select dg.dg_id from doc_groups dg where dc_id in 
				(select DG.dc_id from doctors DR with(nolock) 
					inner join doc_groups DG with(nolock) on DR.dg_id=DG.dg_id 
					inner join doc_companies DC with(nolock) on Dg.dc_id=DC.dc_id where DR.dr_id=@drid)
			)
			AND not(PA_DOB between DATEADD(MM,-(65*12),@dtend) AND DATEADD(MM,-(5*12),@dtend))
			and (PFD.flag_id is null or PFD.flag_id <> 3) and (paext.comm_pref IS NULL OR paext.comm_pref <> 255)
			UNION
			SELECT 
			case when pad.pa_id is null then 0 ELSE pad.pa_id END NUMPATIENT,
			case when pa.pa_id > 0 THEN pa.pa_id ELSE 0 END DENOMPATIENT 
			FROM PATIENTS PA WITH(NOLOCK) 
			INNER JOIN prescriptions   p   with(nolock)    ON p.pa_id=PA.pa_id
			LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS paext with(nolock) on paext.pa_id=PA.pa_id
			LEFT OUTER JOIN patient_flag_details PFD WITH(NOLOCK) ON PA.pa_id=PFD.pa_id
			LEFT OUTER JOIN PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on pa.pa_id = pad.pa_id 
			AND pad.REC_TYPE = 3 and pad.rec_date between @DTSTART and @DTEND
			WHERE  
			PA.dg_id in 
			(select dg.dg_id from doc_groups dg where dc_id in 
				(select DG.dc_id from doctors DR with(nolock) 
					inner join doc_groups DG with(nolock) on DR.dg_id=DG.dg_id 
					inner join doc_companies DC with(nolock) on Dg.dc_id=DC.dc_id where DR.dr_id=@drid)
			)
			AND not(PA_DOB between DATEADD(MM,-(65*12),@dtend) AND DATEADD(MM,-(5*12),@dtend))
			and (PFD.flag_id is null or PFD.flag_id <> 3) and (paext.comm_pref IS NULL OR paext.comm_pref <> 255)
			SET NOCOUNT OFF;
			
			SELECT distinct DENOMPATIENT as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart 
			FROM @Temp r
			LEFT OUTER JOIN patients p with(nolock) on r.DENOMPATIENT=p.pa_id  
			WHERE DENOMPATIENT > 0 
		END
		IF @measureType = 15
		BEGIN
			SET NOCOUNT ON;  
				SELECT  DISTINCT a.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
				FROM PATIENT_EXTENDED_DETAILS A 
				LEFT OUTER JOIN patient_measure_compliance B ON A.PA_ID = B.pa_id 
				LEFT OUTER JOIN patients p with(nolock) on A.pa_id=p.pa_id  
				WHERE A.DR_ID = @DRID and a.pa_ref_date between @DTSTART and @DTEND  
			SET NOCOUNT OFF;
		END
		IF @measureType = 16
		BEGIN
			SET NOCOUNT ON;
				SELECT distinct B.pa_id as Patient,p.pa_first as FirstName,p.pa_last as LastName,p.pa_dob as DateOfBirth,p.pa_sex as sex,p.pa_address1 as Address1,p.pa_city as City,p.pa_state as [State],p.pa_zip as ZipCode,p.pa_ssn as chart
				FROM REFERRAL_MAIN B 
				LEFT OUTER JOIN PATIENT_MEASURE_COMPLIANCE A ON A.DR_ID = B.MAIN_DR_ID AND A.PA_ID = B.PA_ID AND A.REC_TYPE=1  AND A.REC_DATE BETWEEN @DTSTART AND @DTEND
				LEFT OUTER JOIN patients p with(nolock) on B.pa_id=p.pa_id  
				WHERE B.MAIN_DR_ID=@DRID AND B.REF_START_dATE BETWEEN @DTSTART AND @DTEND
			SET NOCOUNT OFF;
		END
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
