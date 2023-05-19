CREATE TABLE [dbo].[prescription_scriptguide] (
   [PRES_SGID] [int] NOT NULL
      IDENTITY (1,1),
   [PD_ID] [int] NOT NULL,
   [SG_ID] [int] NOT NULL,
   [IsTest] [tinyint] NOT NULL,
   [IsControl] [tinyint] NOT NULL

   ,CONSTRAINT [PK_prescription_scriptguide] PRIMARY KEY CLUSTERED ([PRES_SGID])
)


GO
