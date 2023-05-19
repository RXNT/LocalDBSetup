CREATE TABLE [cqm2023].[PatientRiskCategoryOrAssessmentCodes] (
   [RiskCategoryOrAssessmentCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [RiskCategoryOrAssessmentId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientRiskCategoryOrAssessmentCodes] PRIMARY KEY CLUSTERED ([RiskCategoryOrAssessmentCodeId])
)


GO
