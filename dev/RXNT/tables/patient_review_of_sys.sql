CREATE TABLE [dbo].[patient_review_of_sys] (
   [ros_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [csymptoms] [varchar](225) NOT NULL,
   [eyes] [varchar](225) NOT NULL,
   [ent] [varchar](225) NOT NULL,
   [cardiovascular] [varchar](225) NOT NULL,
   [gastro] [varchar](225) NOT NULL,
   [genito] [varchar](225) NOT NULL,
   [musco] [varchar](225) NOT NULL,
   [integ] [varchar](225) NOT NULL,
   [neuro] [varchar](225) NOT NULL,
   [psych] [varchar](225) NOT NULL,
   [endocrine] [varchar](225) NOT NULL,
   [lymph] [varchar](225) NOT NULL,
   [allergic] [varchar](225) NOT NULL,
   [respiratory] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_review_of_sys] PRIMARY KEY CLUSTERED ([ros_id])
)


GO
