CREATE TABLE [dbo].[pharmacies2] (
   [pharm_id] [int] NOT NULL,
   [pharm_phone] [varchar](30) NOT NULL,
   [pharm_phone_reception] [varchar](30) NOT NULL,
   [pharm_fax] [varchar](30) NOT NULL

   ,CONSTRAINT [PK_pharmacies2] PRIMARY KEY CLUSTERED ([pharm_id])
)


GO
