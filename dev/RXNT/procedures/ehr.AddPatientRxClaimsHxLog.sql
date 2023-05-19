SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	28-MAY-2019
Description			:	This procedure add the log for patient search claims hx
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[AddPatientRxClaimsHxLog] 
	@PatientId BIGINT,
	@DoctorId BIGINT,
	@LoggedInUserId BIGINT,
	@RequestType INT=NULL,
	@SelectedCoverageSource INT=NULL,
	@SelectedRxCardConsentType VARCHAR(1)=NULL,
	@SelectedClaimsPeriod TINYINT=NULL,
	@IsSuccess BIT,
	@Comments VARCHAR(500)=NULL,
	@HasPatientConsent BIT,
	@MakeLiveTransaction BIT,
	@IsDemoCompany BIT,
	@IsDemoPatient BIT,
	@TotalRxClaimsHxRecords	BIGINT,
	@FilteredRxClaimsHxRecords	INT,
	@StartDate	DATETIME,
	@EndDate	DATETIME
AS
BEGIN
 
  INSERT INTO [dbo].[patient_med_claims_hx_log]
           ([pa_id]
           ,[dr_id]
           ,[prim_dr_id]
           ,RequestType
           ,[SelectedCoverageSource]
           ,[SelectedRxCardConsentType]
           ,[SelectedClaimsPeriod]
           ,[IsSuccess]
           ,[Comments]
           ,HasPatientConsent
           ,MakeLiveTransaction
           ,IsDemoCompany
           ,IsDemoPatient
           ,TotalRxClaimsHxRecords
		   ,FilteredRxClaimsHxRecords
		   ,StartDate
		   ,EndDate
           ,[CreatedOn])
     VALUES
           (@PatientId
           ,@DoctorId 
           ,@LoggedInUserId 
           ,@RequestType
           ,@SelectedCoverageSource
           ,@SelectedRxCardConsentType
           ,@SelectedClaimsPeriod
           ,@IsSuccess
           ,@Comments
           ,@HasPatientConsent
           ,@MakeLiveTransaction
           ,@IsDemoCompany
           ,@IsDemoPatient
           ,@TotalRxClaimsHxRecords
           ,@FilteredRxClaimsHxRecords
           ,@StartDate
           ,@EndDate
           ,GETDATE())
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
