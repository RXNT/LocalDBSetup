CREATE TABLE [dbo].[tblHealthGuidelinesTemplatesFields] (
   [FieldId] [int] NOT NULL,
   [DisplayName] [varchar](50) NULL,
   [Tag] [varchar](50) NULL,
   [ParentFieldId] [int] NULL,
   [FieldGroupID] [int] NULL

   ,CONSTRAINT [PK__tblHealt__C8B6FF073826CB6E] PRIMARY KEY CLUSTERED ([FieldId])
)


GO
