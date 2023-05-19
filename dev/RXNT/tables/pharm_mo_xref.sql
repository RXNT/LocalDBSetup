CREATE TABLE [dbo].[pharm_mo_xref] (
   [pharm_mo_indx] [int] NOT NULL
      IDENTITY (1,1),
   [pharmacy_id] [int] NOT NULL

   ,CONSTRAINT [PK_pharm_mo_xref] PRIMARY KEY CLUSTERED ([pharm_mo_indx])
)


GO
