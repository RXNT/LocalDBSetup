CREATE TABLE [dbo].[pres_form] (
   [pres_authform_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [bit] NULL,
   [visit_date] [datetime] NULL,
   [drug_name] [varchar](100) NULL

   ,CONSTRAINT [PK_pres_form] PRIMARY KEY CLUSTERED ([pres_authform_id])
)


GO
