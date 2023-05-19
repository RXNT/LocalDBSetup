CREATE TABLE [dbo].[prescription_taper_info] (
   [pt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [Dose] [varchar](50) NULL,
   [Sig] [varchar](210) NULL,
   [Days] [int] NULL,
   [Hrs] [int] NULL,
   [CreatedBy] [varchar](200) NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [varchar](200) NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_prescription_taper_info] PRIMARY KEY CLUSTERED ([pt_id])
)


GO
