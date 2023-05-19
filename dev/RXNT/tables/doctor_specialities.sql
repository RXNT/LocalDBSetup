CREATE TABLE [dbo].[doctor_specialities] (
   [speciality_id] [int] NOT NULL
      IDENTITY (1,1),
   [speciality] [varchar](255) NULL

   ,CONSTRAINT [PK_doctor_specialities] PRIMARY KEY CLUSTERED ([speciality_id])
)


GO
