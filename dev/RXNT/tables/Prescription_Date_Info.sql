CREATE TABLE [dbo].[Prescription_Date_Info] (
   [PDt_Id] [int] NOT NULL
      IDENTITY (1,1),
   [dtStartDate] [datetime] NULL,
   [dtEndDate] [datetime] NULL,
   [CreatedBy] [varchar](200) NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [varchar](200) NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL,
   [pd_id] [int] NOT NULL

   ,CONSTRAINT [PK_Prescription_Date_Info] PRIMARY KEY CLUSTERED ([PDt_Id])
)


GO
