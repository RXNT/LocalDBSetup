CREATE TABLE [dbo].[ins_carriers] (
   [ic_id] [int] NOT NULL
      IDENTITY (1,1),
   [ic_name] [varchar](80) NOT NULL

   ,CONSTRAINT [PK_ins_carriers] PRIMARY KEY NONCLUSTERED ([ic_id])
)


GO
