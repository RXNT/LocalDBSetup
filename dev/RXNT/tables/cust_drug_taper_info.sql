CREATE TABLE [dbo].[cust_drug_taper_info] (
   [cdti_id] [int] NOT NULL
      IDENTITY (1,1),
   [cust_id] [int] NOT NULL,
   [drugid] [int] NOT NULL,
   [Dose] [varchar](50) NULL,
   [Sig] [varchar](210) NULL,
   [Days] [int] NULL,
   [Hrs] [int] NULL,
   [CreatedBy] [varchar](200) NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [varchar](200) NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cust_drug_taper_info] PRIMARY KEY CLUSTERED ([cdti_id])
)


GO
