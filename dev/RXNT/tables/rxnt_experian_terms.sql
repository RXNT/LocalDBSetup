CREATE TABLE [dbo].[rxnt_experian_terms] (
   [rxnt_experian_terms_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [terms_accepted] [bit] NOT NULL,
   [accepted_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_rxnt_experian_terms] PRIMARY KEY CLUSTERED ([rxnt_experian_terms_id])
)


GO
