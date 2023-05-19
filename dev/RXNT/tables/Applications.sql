CREATE TABLE [dbo].[Applications] (
   [ApplicationID] [bigint] NOT NULL
      IDENTITY (1,1),
   [Name] [nvarchar](50) NOT NULL,
   [Descrption] [nvarchar](250) NULL,
   [ApplicationTypeID] [int] NOT NULL,
   [ApplicationVersionID] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime] NULL,
   [InactivatedBy] [bigint] NULL,
   [IsDefault] [bit] NOT NULL

   ,CONSTRAINT [AK_Applications_Column] UNIQUE NONCLUSTERED ([Name])
   ,CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED ([ApplicationID])
)


GO
