CREATE TABLE [dbo].[dr_custom_message_subtypes] (
   [subtypeid] [int] NOT NULL,
   [typeid] [int] NOT NULL,
   [name] [varchar](50) NULL

   ,CONSTRAINT [PK_dr_custom_message_subtypes] PRIMARY KEY CLUSTERED ([subtypeid])
)


GO
