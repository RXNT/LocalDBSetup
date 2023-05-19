CREATE TABLE [dbo].[company_forms] (
   [form_id] [int] NOT NULL
      IDENTITY (1,1),
   [form_file] [varchar](255) NOT NULL,
   [pres_id] [int] NOT NULL,
   [saved_date] [datetime] NULL,
   [send_date] [datetime] NULL,
   [response_type] [bit] NULL,
   [response_date] [datetime] NULL

   ,CONSTRAINT [PK__company_forms__51BBB4E8] PRIMARY KEY CLUSTERED ([form_id])
)


GO
