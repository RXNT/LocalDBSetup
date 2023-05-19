CREATE TABLE [dbo].[prescription_sendws_partner_log] (
   [entry_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [log_text] [varchar](2000) NOT NULL,
   [entry_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_prescription_sendws_partner_log] PRIMARY KEY CLUSTERED ([entry_id])
)


GO
