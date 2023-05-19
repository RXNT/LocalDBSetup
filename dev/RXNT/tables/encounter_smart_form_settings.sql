CREATE TABLE [dbo].[encounter_smart_form_settings] (
   [smart_form_set_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [form_id] [varchar](125) NOT NULL,
   [form_name] [varchar](500) NOT NULL,
   [date_added] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_encounter_smart_form_settings] PRIMARY KEY CLUSTERED ([smart_form_set_id])
)


GO
