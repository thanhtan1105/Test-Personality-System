USE [master]
GO
/****** Object:  Database [xmlDB]    Script Date: 8/10/16 14:14:13 ******/
CREATE DATABASE [xmlDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'xmlDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\xmlDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'xmlDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\xmlDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [xmlDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [xmlDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [xmlDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [xmlDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [xmlDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [xmlDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [xmlDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [xmlDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [xmlDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [xmlDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [xmlDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [xmlDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [xmlDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [xmlDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [xmlDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [xmlDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [xmlDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [xmlDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [xmlDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [xmlDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [xmlDB] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [xmlDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [xmlDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [xmlDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [xmlDB] SET RECOVERY FULL 
GO
ALTER DATABASE [xmlDB] SET  MULTI_USER 
GO
ALTER DATABASE [xmlDB] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [xmlDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [xmlDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [xmlDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [xmlDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [xmlDB]
GO
/****** Object:  Table [dbo].[tblAnswers]    Script Date: 8/10/16 14:14:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAnswers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contents] [nvarchar](50) NOT NULL,
	[date] [datetime] NOT NULL,
	[questionId] [int] NOT NULL,
	[username] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblAnswers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblGroup]    Script Date: 8/10/16 14:14:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGroup](
	[abbreviation] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](4000) NULL,
	[active] [bit] NULL,
	[atWork] [nvarchar](4000) NULL,
	[strength] [nvarchar](4000) NULL,
	[weakness] [nvarchar](4000) NULL,
 CONSTRAINT [PK_tblGroup_1] PRIMARY KEY CLUSTERED 
(
	[abbreviation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblQuestion]    Script Date: 8/10/16 14:14:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblQuestion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[date] [datetime] NULL,
	[username] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblQuestion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 8/10/16 14:14:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[groupName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[tblAnswers]  WITH CHECK ADD  CONSTRAINT [FK_tblAnswers_tblQuestion] FOREIGN KEY([questionId])
REFERENCES [dbo].[tblQuestion] ([id])
GO
ALTER TABLE [dbo].[tblAnswers] CHECK CONSTRAINT [FK_tblAnswers_tblQuestion]
GO
ALTER TABLE [dbo].[tblAnswers]  WITH CHECK ADD  CONSTRAINT [FK_tblAnswers_tblUsers] FOREIGN KEY([username])
REFERENCES [dbo].[tblUsers] ([username])
GO
ALTER TABLE [dbo].[tblAnswers] CHECK CONSTRAINT [FK_tblAnswers_tblUsers]
GO
ALTER TABLE [dbo].[tblQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tblQuestion_tblUsers] FOREIGN KEY([username])
REFERENCES [dbo].[tblUsers] ([username])
GO
ALTER TABLE [dbo].[tblQuestion] CHECK CONSTRAINT [FK_tblQuestion_tblUsers]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblGroup] FOREIGN KEY([groupName])
REFERENCES [dbo].[tblGroup] ([abbreviation])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblGroup]
GO
USE [master]
GO

