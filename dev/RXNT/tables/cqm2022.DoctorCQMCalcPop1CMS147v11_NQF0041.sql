CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] (
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

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS147v11_NQF0041] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
