CREATE TABLE [erx].[RxFillRequestsInfo] (
   [FillReqInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [FillReqId] [int] NOT NULL,
   [Type] [varchar](7) NOT NULL,
   [DrugName] [varchar](125) NULL,
   [DrugNDC] [varchar](11) NULL,
   [DrugForm] [varchar](3) NULL,
   [DrugStrength] [varchar](70) NULL,
   [DrugStrengthUnits] [varchar](3) NULL,
   [Qty1] [varchar](35) NULL,
   [Qty1Units] [varchar](50) NULL,
   [Qty1Enum] [tinyint] NULL,
   [Qty2] [varchar](35) NULL,
   [Qty2Units] [varchar](50) NULL,
   [Qty2Enum] [tinyint] NULL,
   [Dosage1] [varchar](140) NULL,
   [Dosage2] [varchar](70) NULL,
   [DaysSupply] [int] NULL,
   [Date1] [smalldatetime] NULL,
   [Date1Enum] [tinyint] NULL,
   [Date2] [smalldatetime] NULL,
   [Date2Enum] [tinyint] NULL,
   [Date3] [smalldatetime] NULL,
   [Date3Enum] [tinyint] NULL,
   [SubstitutionCode] [tinyint] NULL,
   [VoidComments] [varchar](255) NULL,
   [VoidCode] [smallint] NULL,
   [Comments1] [varchar](210) NULL,
   [Comments2] [varchar](70) NULL,
   [Comments3] [varchar](70) NULL,
   [DrugStrengthCode] [varchar](15) NULL,
   [DrugStrengthSourceCode] [varchar](3) NULL,
   [DrugFormCode] [varchar](15) NULL,
   [DrugFormSourceCode] [varchar](3) NULL,
   [Qty1UnitsPotencyCode] [varchar](15) NULL,
   [Qty2UnitsPotencyCode] [varchar](15) NULL,
   [DocInfoText] [varchar](5000) NULL,
   [Refills] [varchar](35) NULL,
   [RefillsType] [tinyint] NULL,
   [PharmId] [bigint] NULL,
   [FullReqMessage] [xml] NULL

   ,CONSTRAINT [PK_RxFillRequestsInfo] PRIMARY KEY CLUSTERED ([FillReqInfoId])
)


GO
