CREATE TABLE [dbo].[CQM_Codes] (
   [CQM_Code_Id] [int] NOT NULL,
   [code] [varchar](100) NOT NULL,
   [code_type] [varchar](20) NOT NULL,
   [NQF_id] [varchar](10) NOT NULL,
   [IsActive] [bit] NOT NULL,
   [IsExclude] [bit] NOT NULL,
   [criteria] [smallint] NOT NULL,
   [criteriatype] [varchar](10) NOT NULL,
   [version] [int] NOT NULL,
   [value_set_oid] [varchar](50) NULL,
   [code_system_oid] [varchar](50) NULL

   ,CONSTRAINT [PK_CQM_Codes] PRIMARY KEY CLUSTERED ([CQM_Code_Id])
)


GO
