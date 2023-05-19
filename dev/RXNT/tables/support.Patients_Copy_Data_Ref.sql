CREATE TABLE [support].[Patients_Copy_Data_Ref] (
   [CopyDataRef_Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [CopyRef_Id] [bigint] NULL,
   [Type] [varchar](30) NULL,
   [CreatedOn] [datetime] NULL,
   [Old_DataRef_Id] [bigint] NULL,
   [New_DataRef_Id] [bigint] NULL,
   [Is_Copied] [bit] NULL

   ,CONSTRAINT [PK_Patients_Copy_Data_Ref] PRIMARY KEY CLUSTERED ([CopyDataRef_Id])
)


GO
