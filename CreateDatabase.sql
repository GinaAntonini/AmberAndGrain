USE [master]
GO
/****** Object:  Database [AmberAndGrain]    Script Date: 4/3/2018 6:32:08 PM ******/
CREATE DATABASE [AmberAndGrain]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AmberAndGrain', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AmberAndGrain.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AmberAndGrain_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AmberAndGrain_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AmberAndGrain] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AmberAndGrain].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AmberAndGrain] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AmberAndGrain] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AmberAndGrain] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AmberAndGrain] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AmberAndGrain] SET ARITHABORT OFF 
GO
ALTER DATABASE [AmberAndGrain] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AmberAndGrain] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AmberAndGrain] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AmberAndGrain] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AmberAndGrain] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AmberAndGrain] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AmberAndGrain] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AmberAndGrain] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AmberAndGrain] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AmberAndGrain] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AmberAndGrain] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AmberAndGrain] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AmberAndGrain] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AmberAndGrain] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AmberAndGrain] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AmberAndGrain] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AmberAndGrain] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AmberAndGrain] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AmberAndGrain] SET  MULTI_USER 
GO
ALTER DATABASE [AmberAndGrain] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AmberAndGrain] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AmberAndGrain] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AmberAndGrain] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AmberAndGrain] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AmberAndGrain] SET QUERY_STORE = OFF
GO
USE [AmberAndGrain]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [AmberAndGrain]
GO
/****** Object:  Table [dbo].[Batches]    Script Date: 4/3/2018 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Batches](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RecipeId] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateBarrelled] [datetime] NULL,
	[NumberOfBarrels] [int] NULL,
	[DateBottled] [datetime] NULL,
	[NumberOfBottles] [int] NULL,
	[Cooker] [varchar](250) NOT NULL,
	[PricePerBottle] [money] NULL,
	[NumberOfBottlesLeft] [int] NULL,
 CONSTRAINT [PK_Batches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 4/3/2018 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NOT NULL,
	[NumberOfBottles] [int] NOT NULL,
	[DateOfOrder] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipes]    Script Date: 4/3/2018 6:32:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[PercentWheat] [decimal](18, 2) NOT NULL,
	[PercentCorn] [decimal](18, 2) NOT NULL,
	[BarrelAge] [int] NOT NULL,
	[BarrelMaterial] [varchar](50) NOT NULL,
	[Creator] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_DateOfOrder]  DEFAULT (getdate()) FOR [DateOfOrder]
GO
ALTER TABLE [dbo].[Batches]  WITH CHECK ADD  CONSTRAINT [FK_Batches_Recipes] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipes] ([Id])
GO
ALTER TABLE [dbo].[Batches] CHECK CONSTRAINT [FK_Batches_Recipes]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Batches] FOREIGN KEY([BatchId])
REFERENCES [dbo].[Batches] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Batches]
GO
USE [master]
GO
ALTER DATABASE [AmberAndGrain] SET  READ_WRITE 
GO
