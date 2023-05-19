CREATE TABLE [dbo].[doc_fav_vitals] (
   [docId] [int] NOT NULL,
   [vitalsId] [int] NOT NULL,
   [vitalsCheck] [bit] NOT NULL,
   [vitalsText] [varchar](50) NOT NULL

   ,CONSTRAINT [pk_favVitals] PRIMARY KEY CLUSTERED ([docId], [vitalsId], [vitalsCheck])
)


GO
