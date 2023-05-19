CREATE TABLE [dbo].[patient_med_claims_hx_log] (
   [id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [prim_dr_id] [bigint] NOT NULL,
   [RequestType] [int] NULL,
   [SelectedCoverageSource] [int] NULL,
   [SelectedRxCardConsentType] [varchar](1) NULL,
   [SelectedClaimsPeriod] [tinyint] NULL,
   [IsSuccess] [bit] NOT NULL,
   [Comments] [varchar](500) NULL,
   [HasPatientConsent] [bit] NULL,
   [MakeLiveTransaction] [bit] NULL,
   [IsDemoCompany] [bit] NULL,
   [IsDemoPatient] [bit] NULL,
   [TotalRxClaimsHxRecords] [bigint] NULL,
   [FilteredRxClaimsHxRecords] [int] NULL,
   [StartDate] [datetime] NULL,
   [EndDate] [datetime] NULL,
   [CreatedOn] [datetime] NULL

   ,CONSTRAINT [PK_patient_med_claims_hx_log] PRIMARY KEY CLUSTERED ([id])
)


GO
