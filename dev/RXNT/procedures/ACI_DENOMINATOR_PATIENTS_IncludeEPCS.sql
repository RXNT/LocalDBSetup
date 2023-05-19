SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	16-DEC-2017
Description			:	ACI Denominator Patients
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [dbo].[ACI_DENOMINATOR_PATIENTS_IncludeEPCS]
	@dr_id INT, 
	@dg_id INT=NULL, 
	@reporting_start_date date, 
	@reporting_end_date date, 
	@MeasureCode Varchar(3) 
AS
BEGIN
	SET @reporting_end_date = DATEADD(day, 1, @reporting_end_date )
	DECLARE @DENOMINATOR_PATIENTS TABLE 
	(
		PatientId BIGINT
	);
	IF @MeasureCode<>''
	BEGIN
		
		IF @MeasureCode = 'PPD'
		BEGIN
		IF @dg_id IS  NULL
			BEGIN
				INSERT INTO @DENOMINATOR_PATIENTS
				SELECT enc.patient_id as DenomPatient 
				FROM enchanced_encounter enc WITH(NOLOCK)
				WHERE 
				enc.dr_id = @dr_id AND
				enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
				AND enc.issigned=1  
				AND enc.type_of_visit = 'OFICE'  
				GROUP BY enc.patient_id
			END
		ELSE
			BEGIN
				INSERT INTO @DENOMINATOR_PATIENTS
				SELECT  enc.patient_id as DenomPatient 
				FROM enchanced_encounter enc WITH(NOLOCK)
				INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
				WHERE 
				doc.dg_id=@dg_id AND
				enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
				AND enc.issigned=1 
				AND enc.type_of_visit = 'OFICE'  
				GROUP BY enc.patient_id
			END;
				  select 
			   pa_id as Patient,
			   pa_first as FirstName,
			   pa_last as LastName,
			   pat.pa_dob as DateOfBirth,
			   pa_sex as sex,
			   pa_address1 as Address1,
			   pa_city as City,
			   pa_state as [State],
			   pa_zip as ZipCode,
			   pa_ssn as chart
			   from  dbo.Patients    PAT  with(nolock) where 1=1
			   AND pat.pa_id in 
			   ( 
					select distinct 
					dp.PatientId from @DENOMINATOR_PATIENTS dp
			   )	
		END
		IF @MeasureCode = 'EPR'
		BEGIN
	IF @dg_id IS  NULL
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		select p.pa_id AS DenomPatient
		from prescriptions p 
		inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
		inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
		where 
		p.dr_id = @dr_id AND
		p.pres_void = 0 and
		p.pres_approved_date between @reporting_start_date and @reporting_end_date
	END
	ELSE
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		select p.pa_id AS DenomPatient
		from prescriptions p 
		inner join prescription_details pd with(nolock) on pd.pres_id = p.pres_id
		inner join RMIID1 RV with(nolock) on RV.MEDID = pd.ddid
		where  
		p.dg_id=@dg_id AND
		p.pres_void = 0 and
		p.pres_approved_date between @reporting_start_date and @reporting_end_date
	END
			
			   select 
			   pa_id as Patient,
			   pa_first as FirstName,
			   pa_last as LastName,
			   pat.pa_dob as DateOfBirth,
			   pa_sex as sex,
			   pa_address1 as Address1,
			   pa_city as City,
			   pa_state as [State],
			   pa_zip as ZipCode,
			   pa_ssn as chart
			   from  dbo.Patients    PAT  with(nolock)
			   INNER JOIN @DENOMINATOR_PATIENTS dp ON PAT.pa_id=dp.PatientId		
		END
		
		IF @MeasureCode= 'VDT'
			BEGIN
			IF @dg_id IS  NULL
			BEGIN
				INSERT INTO @DENOMINATOR_PATIENTS
				SELECT  enc.patient_id AS PatientId  
				FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
				WHERE 1=1 
				AND	enc.dr_id = @dr_id
				AND enc.enc_date BETWEEN @reporting_start_date and @reporting_end_date    
				AND enc.type_of_visit = 'OFICE'    
				AND	enc.issigned = 1 
				GROUP BY enc.patient_id
			END
			ELSE
			BEGIN
				INSERT INTO @DENOMINATOR_PATIENTS
				SELECT enc.patient_id AS PatientId  
				FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
				INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
				WHERE 1=1 
				AND	pat.dg_id = @dg_id 
				AND enc.enc_date BETWEEN @reporting_start_date and @reporting_end_date    
				AND enc.type_of_visit = 'OFICE'    
				AND	enc.issigned = 1 
				GROUP BY enc.patient_id
			END;
				
				SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM @DENOMINATOR_PATIENTS DP
				left join patients p on p.pa_id=DP.PatientId
			END	
			IF @MeasureCode= 'DCP'
			BEGIN
				IF @dg_id IS  NULL
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT  DISTINCT enc.patient_id AS PatientId  
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			WHERE 1=1 
			AND enc.dr_id = @dr_id
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date    
			AND enc.type_of_visit = 'OFICE'    
			AND	enc.issigned = 1  
		END
	ELSE
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT  DISTINCT enc.patient_id AS PatientId  
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
			WHERE 1=1 
			AND pat.dg_id=@dg_id
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date    
			AND enc.type_of_visit = 'OFICE'    
			AND	enc.issigned = 1  
		END;
				SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM @DENOMINATOR_PATIENTS DP 
				left join patients p on p.pa_id=DP.PatientId
			END
			IF @MeasureCode= 'RIC'
			BEGIN
			 
	WITH PETIENT_ENCOUNTERS AS    
	(  
		SELECT enc.patient_id, enc.dr_id, MAX(enc.enc_date) as last_encounter_date,pat.pa_dob      
		FROM dbo.enchanced_encounter enc WITH(NOLOCK)      
		INNER JOIN dbo.patients pat WITH(NOLOCK) ON pat.pa_id=enc.patient_id     
		INNER JOIN referral_main   rm   with(nolock) on rm.pa_id   = pat.pa_id 
		WHERE 1=1
		AND   enc.dr_id  = @dr_id    
		AND   enc.enc_date between @reporting_start_date and @reporting_end_date    
		AND   enc.type_of_visit = 'OFICE'    
		AND	  enc.issigned = 1
		and   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
		GROUP BY  enc.patient_id, enc.dr_id ,pat.pa_dob  
	),
	DENOMINATOR_PATIENTS AS    
	(   
		SELECT pen.patient_id as DenomPatient   
		FROM  PETIENT_ENCOUNTERS   pen  with(nolock)    
		INNER JOIN dbo.patients    pat  with(nolock) on pat.pa_id  = pen.patient_id  
		INNER JOIN referral_main   rm   with(nolock) on rm.pa_id   = pat.pa_id  
		where  1=1  
		group by pen.patient_id    
	)
					SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM DENOMINATOR_PATIENTS DP 
				left join patients p on p.pa_id=DP.DenomPatient
			END
			IF @MeasureCode= 'HIE'
			BEGIN
				IF @dg_id IS  NULL
				BEGIN
					INSERT INTO @DENOMINATOR_PATIENTS
					select  rm.pa_id as PatientId
					from  referral_main  rm  with(nolock)    
					where  1=1 
					AND rm.main_dr_id=@dr_id 
					AND   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
					group by rm.pa_id
				END
				ELSE
				BEGIN
					select  rm.pa_id as PatientId
					from  referral_main  rm  with(nolock)    
					INNER JOIN patients pat WITH(NOLOCK) ON   rm.pa_id=pat.pa_id
					where  1=1 
					AND pat.dg_id=@dg_id 
					and   rm.ref_start_date between @reporting_start_date and @reporting_end_date  
					group by rm.pa_id
				END;
				SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM @DENOMINATOR_PATIENTS DP 
				left join patients p on p.pa_id=DP.PatientId
			END		
			IF @MeasureCode= 'PAE'
			BEGIN
				IF @dg_id IS  NULL
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT enc.patient_id AS PatientId 
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			WHERE  1=1  
			AND	enc.dr_id = @dr_id
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date  
			AND	enc.issigned = 1 
			AND enc.type_of_visit = 'OFICE'  
			GROUP BY  enc.patient_id
		END
	ELSE
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT DISTINCT enc.patient_id AS PatientId 
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id 
			WHERE  1=1  
			AND	pat.dg_id = @dg_id 
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date  
			AND	enc.issigned = 1
			AND enc.type_of_visit = 'OFICE'  
		END;
				
				SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM @DENOMINATOR_PATIENTS DP 
				left join patients p on p.pa_id=DP.PatientId
			END	
			
			IF @MeasureCode= 'MDR'
			BEGIN
				
	IF @dg_id IS  NULL
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		SELECT DISTINCT pat.pa_id PatientId
		FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
		WHERE 1=1 
		AND ref.dr_id = @dr_id 
		AND ref.pa_ext_ref = 1 
		AND CAST(ref.pa_ref_date AS DATE) BETWEEN @reporting_start_DATE AND @reporting_end_DATE    
		AND ref.pa_ref_name_details  IS NOT  NULL
	END
	ELSE
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		SELECT DISTINCT pat.pa_id PatientId
		FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
		WHERE 1=1 AND
		pat.dg_id=@dg_id
		AND ref.pa_ext_ref = 1 
		AND CAST(ref.pa_ref_date AS DATE) BETWEEN @reporting_start_DATE AND @reporting_end_DATE    
		AND ref.pa_ref_name_details  IS NOT  NULL
	END;
				
				SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM @DENOMINATOR_PATIENTS DP 
				left join patients p on p.pa_id=DP.PatientId
			END	
			IF @MeasureCode= 'SEM'
			BEGIN
				WITH DENOMINATOR_PATIENTS AS    
				(    
				  	SELECT DISTINCT enc.patient_id as PatientId 
				  FROM enchanced_encounter enc WITH(NOLOCK)
				  INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
				  WHERE 
				  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR
				  (@dg_id IS NOT NULL AND doc.dg_id=@dg_id)) AND
				  enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
				  AND enc.issigned=1  	
				  AND enc.type_of_visit = 'OFICE'  
				)
				
				SELECT 
					p.pa_id AS Patient,
					p.pa_first AS FirstName,
					p.pa_last AS LastName,
					p.pa_dob AS DateOfBirth,
					p.pa_sex AS sex,
					p.pa_address1 AS Address1,
					p.pa_city AS City,
					p.pa_state AS [State],
					p.pa_zip AS ZipCode,
					p.pa_ssn AS chart  
				FROM DENOMINATOR_PATIENTS DP with(nolock)
				left join patients p on p.pa_id=DP.PatientId
			END	
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
