CREATE TABLE [dbo].[CQM_Codes_V4] (
   [CQM_Code_Id] [int] NOT NULL,
   [code] [varchar](100) NOT NULL,
   [code_type] [varchar](10) NOT NULL,
   [NQF_id] [varchar](10) NOT NULL,
   [IsActive] [bit] NOT NULL,
   [IsExclude] [bit] NOT NULL,
   [criteria] [smallint] NOT NULL,
   [criteriatype] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_CQM_Codes_V4] PRIMARY KEY CLUSTERED ([CQM_Code_Id])
)


GO
