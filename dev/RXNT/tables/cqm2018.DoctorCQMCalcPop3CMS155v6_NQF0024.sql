CREATE TABLE [cqm2018].[DoctorCQMCalcPop3CMS155v6_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS155v6_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
