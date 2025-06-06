SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[workspaces]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[workspaces](
	[workspace_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[dt] [datetime] NOT NULL,
 CONSTRAINT [PK_workspaces] PRIMARY KEY CLUSTERED 
(
	[workspace_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_workspaces] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Workspace ID' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'workspaces', @level2type=N'COLUMN', @level2name=N'workspace_id'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Workspace name' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'workspaces', @level2type=N'COLUMN', @level2name=N'name'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'When was this workspace created' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'workspaces', @level2type=N'COLUMN', @level2name=N'dt'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[posts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[posts](
	[post_id] [int] IDENTITY(1,1) NOT NULL,
	[content] [text] NOT NULL,
	[dt] [datetime] NOT NULL,
	[workspace_id] [int] NULL,
 CONSTRAINT [PK_posts] PRIMARY KEY CLUSTERED 
(
	[post_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Post ID' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'posts', @level2type=N'COLUMN', @level2name=N'post_id'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Post HTML content' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'posts', @level2type=N'COLUMN', @level2name=N'content'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'When was this posted' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'posts', @level2type=N'COLUMN', @level2name=N'dt'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'All of the posts in the bulletin board system' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'posts'

GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_posts_workspaces]') AND parent_object_id = OBJECT_ID(N'[dbo].[posts]'))
ALTER TABLE [dbo].[posts]  WITH CHECK ADD  CONSTRAINT [FK_posts_workspaces] FOREIGN KEY([workspace_id])
REFERENCES [dbo].[workspaces] ([workspace_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Workspace a post belongs to' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'posts', @level2type=N'CONSTRAINT', @level2name=N'FK_posts_workspaces'

