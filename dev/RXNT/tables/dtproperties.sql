CREATE TABLE [dbo].[dtproperties] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [objectid] [int] NULL,
   [property] [varchar](64) NOT NULL,
   [value] [varchar](255) NULL,
   [lvalue] [image] NULL,
   [version] [int] NOT NULL,
   [uvalue] [nvarchar](255) NULL

   ,CONSTRAINT [pk_dtproperties] PRIMARY KEY CLUSTERED ([id], [property])
)


GO
