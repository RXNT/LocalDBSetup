CREATE TABLE [dbo].[NQF_Codes] (
   [NQF_Code_Id] [int] NOT NULL,
   [code] [varchar](100) NOT NULL,
   [code_type] [varchar](10) NOT NULL,
   [NQF_id] [varchar](10) NOT NULL,
   [IsActive] [bit] NOT NULL,
   [IsExclude] [bit] NOT NULL,
   [criteria] [smallint] NOT NULL,
   [criteriatype] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_NQF_Codes] PRIMARY KEY CLUSTERED ([NQF_Code_Id])
)


GO
