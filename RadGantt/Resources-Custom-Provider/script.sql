SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanttDependencies](
  [ID] [int] IDENTITY(1,1) NOT NULL,
  [PredecessorID] [int] NOT NULL,
  [SuccessorID] [int] NOT NULL,
  [Type] [int] NOT NULL,
 CONSTRAINT [PK_GanttDependencies] PRIMARY KEY CLUSTERED 
(
  [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanttResourceAssignments](
  [ID] [int] IDENTITY(1,1) NOT NULL,
  [TaskID] [int] NOT NULL,
  [ResourceID] [int] NOT NULL,
  [Units] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_GanttResourceAssignments] PRIMARY KEY CLUSTERED 
(
  [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanttResources](
  [ID] [int] IDENTITY(1,1) NOT NULL,
  [Name] [nvarchar](50) NOT NULL,
  [Color] [nchar](10) NULL,
 CONSTRAINT [PK_GanttResources] PRIMARY KEY CLUSTERED 
(
  [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanttTasks](
  [ID] [int] IDENTITY(1,1) NOT NULL,
  [ParentID] [int] NULL,
  [OrderID] [int] NOT NULL,
  [Title] [ntext] NULL,
  [Start] [datetime] NOT NULL,
  [End] [datetime] NOT NULL,
  [PercentComplete] [decimal](5, 2) NOT NULL,
  [Expanded] [bit] NULL,
  [Summary] [bit] NOT NULL CONSTRAINT [DF_GanttTasks_Summary]  DEFAULT ((0)),
 CONSTRAINT [PK_GanttTasks] PRIMARY KEY CLUSTERED 
(
  [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[GanttTasks]  WITH CHECK ADD  CONSTRAINT [FK_GanttTasks_GanttTasks] FOREIGN KEY([ParentID])
REFERENCES [dbo].[GanttTasks] ([ID])
GO
ALTER TABLE [dbo].[GanttTasks] CHECK CONSTRAINT [FK_GanttTasks_GanttTasks]
GO

GO
SET IDENTITY_INSERT [dbo].[GanttResources] ON 
GO
INSERT [dbo].[GanttResources] ([ID], [Name], [Color]) VALUES (1, N'Resource 1', N'#f44336   ')
GO
INSERT [dbo].[GanttResources] ([ID], [Name], [Color]) VALUES (2, N'Resource 2', N'#880e4f   ')
GO
INSERT [dbo].[GanttResources] ([ID], [Name], [Color]) VALUES (3, N'Resource 3', N'#880e4f   ')
GO
SET IDENTITY_INSERT [dbo].[GanttResources] OFF
GO