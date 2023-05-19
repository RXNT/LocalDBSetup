CREATE TABLE [dbo].[partner_allergy_transmittals] (
   [at_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NOT NULL,
   [allergy_type] [int] NOT NULL,
   [operation] [char](2) NOT NULL,
   [partner_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL

   ,CONSTRAINT [PK_partner_allergy_transmittals] PRIMARY KEY CLUSTERED ([at_id])
)


GO
