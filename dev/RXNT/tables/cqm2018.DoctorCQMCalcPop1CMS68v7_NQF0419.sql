CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS68v7_NQF0419] (
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
   [DenomExceptions] [bit] NULL,
   [DatePerformed] [date] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS68v7_NQF0419] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
