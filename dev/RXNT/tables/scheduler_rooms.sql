CREATE TABLE [dbo].[scheduler_rooms] (
   [room_id] [int] NOT NULL
      IDENTITY (1,1),
   [room_name] [varchar](50) NOT NULL,
   [dg_id] [int] NOT NULL,
   [is_active] [bit] NOT NULL

   ,CONSTRAINT [PK_scheduler_rooms] PRIMARY KEY CLUSTERED ([room_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[scheduler_rooms] ([dg_id], [is_active])

GO
