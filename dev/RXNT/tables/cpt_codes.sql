CREATE TABLE [dbo].[cpt_codes] (
   [Code] [nvarchar](50) NOT NULL,
   [Description] [nvarchar](255) NOT NULL,
   [long_desc] [varchar](max) NULL,
   [created_at] [datetime] NULL,
   [updated_at] [datetime] NULL,
   [DataSource] [varchar](100) NULL,
   [ProcedureCodeTypeId] [bigint] NULL

   ,CONSTRAINT [PK_cpt_codes] PRIMARY KEY CLUSTERED ([Code])
)


GO
