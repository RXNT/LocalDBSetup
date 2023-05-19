CREATE TABLE [dbo].[prescription_pharm_actions] (
   [presc_action_id] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_id] [int] NOT NULL,
   [pharm_user_id] [int] NOT NULL,
   [action_date] [smalldatetime] NOT NULL,
   [action_val] [int] NOT NULL,
   [pres_id] [int] NOT NULL,
   [detail_text] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_prescription_pharm_actions] PRIMARY KEY CLUSTERED ([presc_action_id])
)


GO
