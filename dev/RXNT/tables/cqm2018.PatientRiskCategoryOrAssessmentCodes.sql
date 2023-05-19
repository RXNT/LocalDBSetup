CREATE TABLE [cqm2018].[PatientRiskCategoryOrAssessmentCodes] (
   [RiskCategoryOrAssessmentCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [RiskCategoryOrAssessmentId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientRiskCategoryOrAssessmentCodes] PRIMARY KEY CLUSTERED ([RiskCategoryOrAssessmentCodeId])
)


GO
