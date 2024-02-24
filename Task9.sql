
create database [ShopDb]

use [ShopDb]

select getdate()
select getutcdate()



create table [dbo].[Sizes](
  [Id] int primary key identity(1,1), 
  [Name] nvarchar(100) not null,
  [SmallName] varchar(10) not null,
  [CreatedAt] datetime not null default getdate(),
  [CreatedBy] int not null,
  [LastModifiedAt] datetime,
  [LastModifiedBy] int,
  [DeletedAt] datetime,
  [DeletedBy] int
)


create table [dbo].[Colors](
    [Id] int identity(1,1), 
    [Name] nvarchar(100) not null,
	[HexCode] varchar(9)
)



alter table [dbo].[Colors]
add [CreatedAt] datetime not null,
[CreatedBy] int not null,
[LastModifiedAt] datetime,
[LastModifiedBy] int,
[DeletedAt] datetime,
[DeletedBy] int;

alter table [dbo].[Colors]
drop column [DeletedBy]


alter table [dbo].[Colors]
add constraint PK_Colors primary key(Id)

alter table [dbo].[Colors]
drop constraint PK_Colors


alter table [dbo].[Colors]
add constraint DF_Colors_CreatedAt default getdate() for CreatedAt



create table [dbo].[Brands](
  [Id] int primary key identity(1,1), 
  [Name] nvarchar(100) not null,
  [CreatedAt] datetime not null default getdate(),
  [CreatedBy] int not null,
  [LastModifiedAt] datetime,
  [LastModifiedBy] int,
  [DeletedAt] datetime,
  [DeletedBy] int
)


create table [dbo].[Products](
   [Id] int primary key identity(1,1),
   [Name] nvarchar(200) not null,
   [Slug] varchar(200) not null,
   [BrandId] int not null,
   [CreatedAt] datetime not null default getdate(),
   [CreatedBy] int not null,
   [LastModifiedAt] datetime,
   [LastModifiedBy] int,
   [DeletedAt] datetime,
   [DeletedBy] int
)


alter table [dbo].[Products]
add constraint FK_Products_Brands FOREIGN KEY([BrandId]) REFERENCES [dbo].[Brands]([Id])


create table [Categories](
[Id] int primary key identity(1,1),
[ParentId] int,
[Name] nvarchar(100),
[CreatedAt] datetime,
[CreatedBy] int,
[LastModifiedAt] datetime,
[LastModifiedBy] int,
[DeletedAt] datetime default getdate(),
[DeletedBy] int)


alter table [dbo].[Products]
add [CategoryId] int not null,
[Description] nvarchar(100) not null,
[ShortDescription] varchar(100),
[Rate] float,
[StockKeepingUnit] nvarchar(100);


alter table [dbo].[Products]
add constraint FK_Products_Categories FOREIGN KEY([CategoryId]) REFERENCES [dbo].[Categories]([Id])

create table SpecificationValues(
[SpecificationId] int ,
[ProductId] int,
[Value] nvarchar(100)
 CONSTRAINT PK_SpecificationValues PRIMARY KEY ([ProductId],[SpecificationId])

)

  drop table  SpecificationValues


alter table [dbo].[SpecificationValues]
add constraint FK_SpecificationValues_Products FOREIGN KEY([ProductId]) REFERENCES [dbo].[Products]([Id])

create table ProductImages(
[Id] int primary key identity(1,1),
[Name] nvarchar(100),
[IsMain] bit,
[ProductId] int
)
alter table [dbo].[ProductImages]
add constraint FK_ProductImages_Products FOREIGN KEY([ProductId]) REFERENCES [dbo].[Products]([Id])

alter table [dbo].[Categories]
add constraint FK_Categories_Products FOREIGN KEY([ParentId]) REFERENCES [dbo].[Categories]([Id])


create table Specifications(
[Id] int primary key identity(1,1),
[Name] nvarchar(100),
 [CreatedAt] datetime not null default getdate(),
  [CreatedBy] int not null,
  [LastModifiedAt] datetime,
  [LastModifiedBy] int,
  [DeletedAt] datetime,
  [DeletedBy] int
  )


alter table [dbo].[SpecificationValues]
add constraint FK_SpecificationValues_Specifications FOREIGN KEY([SpecificationId]) REFERENCES [dbo].[Specifications]([Id])


create table BlogPosts(
[Id] int primary key identity(1,1),
[Title] nvarchar(100),
 [CreatedAt] datetime not null default getdate(),
  [CreatedBy] int not null,
  [LastModifiedAt] datetime,
  [LastModifiedBy] int,
  [CategoryId] int,
  [DeletedAt] datetime,
  [DeletedBy] int,
  [Slug] nvarchar(100),
[Body] nvarchar(100),
[ImagePath] nvarchar(100) not null,
[PublishedAt] datetime,
  [PublishedBy] int,
  )

  --drop table BlogPosts

  alter table [dbo].[BlogPosts]
add constraint FK_BlogPosts_Categories FOREIGN KEY([CategoryId]) REFERENCES [dbo].[Categories]([Id])




