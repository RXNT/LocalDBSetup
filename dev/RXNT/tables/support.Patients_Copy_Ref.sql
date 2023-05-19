CREATE TABLE [support].[Patients_Copy_Ref] (
   [CopyRef_Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [Old_PatID] [int] NOT NULL,
   [New_PatID] [int] NOT NULL,
   [Old_DGID] [int] NOT NULL,
   [New_DGID] [int] NOT NULL,
   [Old_DCID] [int] NOT NULL,
   [New_DCID] [int] NOT NULL,
   [CopyCompleted] [bit] NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastUpdatedOn] [datetime] NULL,
   [New_DRID] [bigint] NOT NULL,
   [Old_DRID] [bigint] NOT NULL

   ,CONSTRAINT [PK_Patients_Copy_Ref] PRIMARY KEY CLUSTERED ([CopyRef_Id])
)


GO
