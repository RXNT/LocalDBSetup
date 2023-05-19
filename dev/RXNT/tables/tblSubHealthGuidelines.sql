CREATE TABLE [dbo].[tblSubHealthGuidelines] (
   [sub_rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [rule_id] [int] NOT NULL,
   [type] [tinyint] NOT NULL,
   [numeric_value] [decimal](10,2) NULL,
   [string_value] [varchar](255) NULL,
   [is_neg] [bit] NULL,
   [string_value2] [varchar](255) NULL

   ,CONSTRAINT [PK_tblSubHealthGuidelines] PRIMARY KEY CLUSTERED ([sub_rule_id])
)

CREATE NONCLUSTERED INDEX [IX_tblSubHealthGuidelines] ON [dbo].[tblSubHealthGuidelines] ([is_neg])

GO
