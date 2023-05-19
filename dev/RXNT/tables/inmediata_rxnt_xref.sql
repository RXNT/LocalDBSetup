CREATE TABLE [dbo].[inmediata_rxnt_xref] (
   [rxnt_im_xref_id] [int] NOT NULL
      IDENTITY (1,1),
   [inmediata_entity_id] [varchar](35) NOT NULL,
   [dg_id] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_inmediata_rxnt_xref] PRIMARY KEY CLUSTERED ([rxnt_im_xref_id])
)


GO
