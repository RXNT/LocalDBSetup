CREATE TABLE [dbo].[patient_profile_headers] (
   [HeaderID] [int] NOT NULL
      IDENTITY (1,1),
   [HeaderText] [varchar](225) NOT NULL,
   [OrderId] [tinyint] NOT NULL

   ,CONSTRAINT [PK_patient_profile_headers] PRIMARY KEY CLUSTERED ([HeaderID])
)


GO
