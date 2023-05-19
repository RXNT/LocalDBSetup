SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kalimuthu S
-- Create date: 26th November 2018
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetStageIVDenominatorPatient] 
	@dr_id INT, 
	@dtstart DATE, 
	@dtend DATE, 
	@MeasureCode VARCHAR(3),
	@dg_id INT = NULL  
AS
BEGIN

	IF (@dg_id = 0)
	BEGIN
		set @dg_id = null
	END
	
	IF @MeasureCode<>''
	BEGIN
		IF @MeasureCode='DFQ'
			BEGIN
				SELECT
					pat.pa_id as Patient,
					pat.pa_first as FirstName,
					pat.pa_last as LastName,
					pat.pa_dob as DateOfBirth,
					pat.pa_sex as sex,
					pat.pa_address1 as Address1,
					pat.pa_city as City,
					pat.pa_state as [State],
					pat.pa_zip as ZipCode,
					pat.pa_ssn as chart  
				FROM prescriptions p  WITH(NOLOCK)
				INNER JOIN prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
				INNER JOIN RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
				LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pa_id
				WHERE ((@dg_id IS NULL and p.dr_id = @dr_id) OR (@dg_id IS NOT NULL AND p.dg_id=@dg_id)) 
				AND p.pres_void = 0 AND
				p.pres_approved_date BETWEEN @dtstart and @dtend
			END
		
		IF @MeasureCode='PTE'
		BEGIN
			SELECT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart  
			FROM prescriptions p WITH(NOLOCK) 
			INNER JOIN prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
			INNER JOIN RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
			LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pa_id
			WHERE ((@dg_id IS NULL and p.dr_id = @dr_id) OR (@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			p.pres_void = 0 and
			RV.MED_REF_DEA_CD not in (2,3,4,5) and 
			p.pres_approved_date between @dtstart and @dtend
		END
		
		IF @MeasureCode='CPM'
		BEGIN
			select DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart 
			from prescriptions p  WITH(NOLOCK)
			LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pa_id
			where 
			((@dg_id IS NULL and p.dr_id = @dr_id) OR(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			p.pres_delivery_method > 2 
			and p.pres_approved_date between @dtstart and @dtend
		END
		
		IF @MeasureCode='CPL'
		BEGIN
			select DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart 
			from lab_main p  WITH(NOLOCK)
			LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pat_id
			where 
			((@dg_id IS NULL and p.dr_id = @dr_id) OR
			(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			p.type='Lab'
			and p.message_date between @dtstart and @dtend
		END
		
		IF @MeasureCode='CPR'
		BEGIN
			select  DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart 
			from lab_main p  WITH(NOLOCK)
			LEFT JOIN patients pat WITH(NOLOCK) ON pat.pa_id=p.pat_id
			where 
			((@dg_id IS NULL and p.dr_id = @dr_id) OR
			(@dg_id IS NOT NULL AND p.dg_id=@dg_id)) AND
			p.type='Image'
			and p.message_date between @dtstart and @dtend
		END
		
		IF @MeasureCode='DCP'
		BEGIN 
			SELECT DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart 
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
			WHERE 1=1 
			AND ((@dg_id IS NULL and enc.dr_id = @dr_id) OR
			(@dg_id IS NOT NULL AND pat.dg_id=@dg_id))
			AND enc.enc_date BETWEEN @dtstart and @dtend    
			AND enc.type_of_visit = 'OFICE'    
			AND	enc.issigned = 1    
		END
		
		IF @MeasureCode='PAE'
		BEGIN
			SELECT DISTINCT
				pat.pa_id as Patient,
				pat.pa_first as FirstName,
				pat.pa_last as LastName,
				pat.pa_dob as DateOfBirth,
				pat.pa_sex as sex,
				pat.pa_address1 as Address1,
				pat.pa_city as City,
				pat.pa_state as [State],
				pat.pa_zip as ZipCode,
				pat.pa_ssn as chart  
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id 
			WHERE  1=1  
			AND ((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id))  
			AND enc.enc_date BETWEEN @dtstart and @dtend
			AND	enc.issigned = 1   
		END
		
		IF @MeasureCode='VDT'
		BEGIN
			SELECT DISTINCT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart 
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
			WHERE 1=1 
			AND ((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
			AND enc.enc_date BETWEEN @dtstart AND @dtend    
			AND enc.type_of_visit = 'OFICE'    
			AND	enc.issigned = 1 
		END
		
		IF @MeasureCode='SEM'
		BEGIN 
			SELECT  DISTINCT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart 
			FROM enchanced_encounter enc WITH(NOLOCK)
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id 
			INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
			WHERE 
			((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
			AND enc.enc_date BETWEEN @dtstart AND @dtend
			AND enc.issigned=1  
		END
		
		IF @MeasureCode='PPD'
		BEGIN 
			SELECT  DISTINCT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart 
			FROM enchanced_encounter enc WITH(NOLOCK)
			INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id 
			WHERE 
			((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
			AND enc.enc_date BETWEEN @dtstart AND @dtend
			AND enc.issigned=1
		END
		
		IF @MeasureCode='HIE'
		BEGIN   
			WITH PATIENT_REFERRALS AS    
			(    
				SELECT  rm.pa_id AS patient_id, rm.main_dr_id AS dr_id, rm.ref_id   
				FROM  referral_main  rm  WITH(NOLOCK)    
				INNER JOIN patients pat WITH(NOLOCK) ON   rm.pa_id=pat.pa_id
				WHERE 
				((@dg_id IS  NULL AND rm.main_dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
				AND rm.ref_start_date BETWEEN @dtstart AND @dtend  
				GROUP BY rm.pa_id, rm.main_dr_id , rm.ref_id  
			)
			
			SELECT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart    
			FROM  PATIENT_REFERRALS pen  WITH(NOLOCK)  
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = pen.patient_id 
		END
		
		IF @MeasureCode='ESR'
		BEGIN
			SELECT DISTINCT
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart   
			FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
			WHERE 1=1 
			AND ((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
			AND ref.pa_ext_ref = 1 AND
			CAST(ref.pa_ref_date AS DATE) BETWEEN @dtstart AND @dtend     
			AND ref.pa_ref_name_details  IS NOT  NULL
		END
		
		IF @MeasureCode='MDR'
		BEGIN
			SELECT DISTINCT 
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart   
			FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
			WHERE 1=1 AND
			((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id)) 
			AND ref.pa_ext_ref = 1 
			AND CAST(ref.pa_ref_date AS DATE) BETWEEN @dtstart AND @dtend    
			AND ref.pa_ref_name_details  IS NOT  NULL
		END

		IF @MeasureCode='CLR'
		BEGIN

			SELECT 
				pat.pa_id AS Patient,
				pat.pa_first AS FirstName,
				pat.pa_last AS LastName,
				pat.pa_dob AS DateOfBirth,
				pat.pa_sex AS sex,
				pat.pa_address1 AS Address1,
				pat.pa_city AS City,
				pat.pa_state AS [State],
				pat.pa_zip AS ZipCode,
				pat.pa_ssn AS chart  
			from patient_external_ccd_reconciliation_info rec WITH(NOLOCK)
			inner join  dbo.patient_extended_details ref WITH(NOLOCK) 
			ON ref.pa_id = rec.pa_id
			INNER JOIN dbo.patients pat  WITH(NOLOCK) ON pat.pa_id  = rec.pa_id  
			WHERE 1=1
			AND ((@dg_id IS  NULL AND rec.dr_id = @dr_id) OR (@dg_id IS NOT  NULL
			AND rec.dg_id=@dg_id)) 
			AND ref.pa_ext_ref = 1 AND CAST(rec.date_added AS DATE) 
			BETWEEN @dtstart AND @dtend
			AND ref.pa_ref_name_details  IS NOT  NULL	  
		END
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
