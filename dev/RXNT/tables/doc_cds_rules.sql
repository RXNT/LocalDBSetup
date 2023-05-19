CREATE TABLE [dbo].[doc_cds_rules] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [rule_xml] [xml] NOT NULL,
   [is_Active] [bit] NULL,
   [NAME] [varchar](100) NOT NULL,
   [Description] [varchar](1000) NOT NULL,
   [Reference] [varchar](1000) NOT NULL,
   [Information] [varchar](1000) NOT NULL
)


GO
