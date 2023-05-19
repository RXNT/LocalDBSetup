SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchMessagesInRegistry]
  @drid BIGINT,  
  @patientid BIGINT,
  @ExportAll int,
  @firstName varchar(50)=null,
  @vacName VARCHAR(100)=null,
  @lastName VARCHAR(50)=null,
  @export_start_date DATE=null,
  @export_end_date DATE=null,
  @admin_start_date DATE=null,
  @admin_end_date DATE=null,
  @dr_id BIGINT=0,
  @dg_id BIGINT=0,
  @status varchar(20)=null
AS
BEGIN

DECLARE @temp TABLE(
Id BIGINT IDENTITY(1,1),
vac_rec_id BIGINT,
pat_id BIGINT,
PatientName varchar(50),
Provider varchar(50),
vac_name VARCHAR(MAX),
[Status] VARCHAR(20),
[exportedDate] DATE,
vac_dt_admin DATE
)
	IF @ExportAll=1
	BEGIN
		INSERT INTO @temp
			SELECT vq.[vac_rec_id],vq.pat_id,P.pa_last+','+P.PA_FIRST as PatientName, D.DR_FIRST_NAME+' '+D.DR_LAST_NAME as Provider
				,vr.vac_name,
				CASE WHEN vq.isIncluded=1 AND vq.exportedDate IS NULL 
					THEN 'Pending'
				ELSE 'Completed'
				END AS [Status]
				,vq.[exportedDate], vr.vac_dt_admin  
			FROM [dbo].[tblVaccinationQueue]   vq with(nolock)
			INNER JOIN tblVaccinationRecord    vr with(nolock) ON vq.vac_rec_id=vr.vac_rec_id
			INNER JOIN tblVaccines             v with(nolock) ON v.vac_id=vr.vac_id
			INNER JOIN patients                p with(nolock) ON p.pa_id=vq.pat_id
			INNER JOIN doctors                 D ON D.dr_id= vq.dr_id
			INNER JOIN doc_groups              DG with(nolock) on D.dg_id=DG.dg_id AND D.DR_ENABLED = 1
			WHERE  
			vq.isIncluded=1  
			AND (@firstName='' OR P.PA_FIRST LIKE '%'+@firstName+'%')
			AND (@lastName='' OR P.pa_last LIKE '%'+@lastName+'%')
			AND (@vacName='' OR vr.vac_name LIKE '%'+@vacName+'%')
			--AND (@status='' OR [Status] LIKE '%'+@status+'%')
		   AND(@export_start_date IS NULL OR vq.exportedDate>=@export_start_date)
		   AND(@export_end_date IS NULL OR vq.exportedDate<=@export_end_date)
		   AND (@admin_start_date IS NULL OR vr.vac_dt_admin>=@admin_start_date)
		   AND(@admin_end_date IS NULL OR vr.vac_dt_admin<=@admin_end_date)
		   AND vq.vac_rec_id=vr.vac_rec_id AND vr.vac_id=v.vac_id 		      
           AND D.loginlock = 0 and D.lowusage_lock = 0 AND 
           (
				D.billing_enabled=0 
				OR
				(D.billing_enabled=1 and D.billingDate > getdate())
			)
			AND D.DG_ID = @dg_id  
			AND (D.dr_id = @dr_id OR @dr_id = 0)
			ORDER BY [Status],vq.vac_rec_id,vq.exportedDate
			IF @status='Pending'
			BEGIN
	  SELECT TOP(75) * FROM @temp where [Status]='Pending'		
	  END
	  ELSE IF @status='Completed'
	    BEGIN
	  SELECT TOP(75) * FROM @temp where [Status]='Completed'	
	  END
	  ELSE 
	  BEGIN
	  SELECT TOP(75) * FROM @temp	
	  END
	END
	ELSE
	BEGIN
		SELECT vq.[vac_rec_id]
			,vr.vac_name,     
			CASE WHEN vq.isIncluded=1 AND vq.exportedDate IS NULL
				THEN 'Pending'
			ELSE 'Completed'
			END AS [Status]
			,vq.[exportedDate],
			vr.vac_dt_admin
		FROM [dbo].[tblVaccinationQueue]     vq WITH(NOLOCK)
		INNER JOIN tblVaccinationRecord      vr WITH(NOLOCK) ON vq.vac_rec_id = vr.vac_rec_id
		INNER JOIN tblVaccines               v  WITH(NOLOCK) ON vr.vac_id = v.vac_id
		WHERE  
		vq.isIncluded=1 AND  
		vq.dr_id=@drid  AND  
		vq.pat_id=@patientid 
		ORDER BY [Status],vq.vac_rec_id,vq.exportedDate
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
