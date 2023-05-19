CREATE TABLE [cqm2022].[DoctorCQMCalcPop3CMS138v10_NQF0028] (
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

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS138v10_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
