CREATE TABLE [dbo].[patient_hpi_template] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [location] [varchar](255) NOT NULL,
   [severity] [tinyint] NOT NULL,
   [duration] [varchar](50) NOT NULL,
   [signs] [varchar](1000) NOT NULL,
   [symptoms] [varchar](1000) NOT NULL,
   [note] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_patient_hpi_template] PRIMARY KEY CLUSTERED ([history_id])
)


GO
