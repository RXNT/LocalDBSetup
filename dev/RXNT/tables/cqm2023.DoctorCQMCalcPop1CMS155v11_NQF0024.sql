CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS155v11_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS155v11_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
