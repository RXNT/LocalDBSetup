CREATE TABLE [dbo].[USED_DISK] (
   [UsID] [int] NOT NULL
      IDENTITY (1,1),
   [Dbname] [varchar](20) NULL,
   [SizeDb] [varchar](20) NULL,
   [UnlockDB] [varchar](20) NULL,
   [Data] [datetime] NULL

   ,CONSTRAINT [PK__USED_DIS__BD21E37F273C368E] PRIMARY KEY CLUSTERED ([UsID])
)


GO
