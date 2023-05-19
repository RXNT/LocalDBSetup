CREATE TABLE [dbo].[HMriskfactors] (
   [RF_ID] [int] NOT NULL,
   [RF_Name] [nvarchar](255) NULL,
   [RF_Description] [nvarchar](255) NULL,
   [RF_Type] [nvarchar](255) NULL,
   [ApplicableICDs] [nvarchar](255) NULL

   ,CONSTRAINT [PK_HMriskfactors] PRIMARY KEY CLUSTERED ([RF_ID])
)


GO
