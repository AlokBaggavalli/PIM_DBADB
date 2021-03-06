CREATE Procedure [dbo].[usp_UpdateImprint]

as

set nocount on

-- Get the HITT Supplier ID  -- ASINumber = 61125
declare @ASINumber			int,
		@SupplierID			int
		

set @ASINumber = 61125 -- HIT ASINumber

select @SupplierID = ID from Suppliers where ASINumber = @ASINumber





select	piac.*
into tmpProductImprintAreaColors_ToDelete
from ProductImprintAreaColors piac
	join
		(
			select	pia.ID as ProductImprintAreaID,
					pia.ProductID
			from ProductImprintAreas pia
				join 
					(
						select ID as ProductID
						from Products
						where SupplierID = @SupplierID
					) p
				on pia.ProductID = p.ProductID
		) t
	on piac.ProductID = t.ProductID
		and piac.ProductImprintAreaID = t.ProductImprintAreaID
		

alter table tmpProductImprintAreaColors_ToDelete
add Primary Key(ID)

select piact.* 
into tmpProductImprintAreaColorTranslations_ToDelete
from ProductImprintAreaColorTranslations piact
	join tmpProductImprintAreaColors_ToDelete t
		on piact.ProductID = t.ProductID
			and piact.ProductImprintAreaID = t.ProductImprintAreaID
			and piact.ProductImprintAreaColorID = t.ID
			
alter table tmpProductImprintAreaColorTranslations_ToDelete
add Primary Key(ID)


-- Start Deleting
delete piac
from dbo.ProductImprintAreaColors piac
	join dbo.tmpProductImprintAreaColors_ToDelete t
		on piac.ID = t.ID
		
delete piact
from dbo.ProductImprintAreaColorTranslations piact
	join dbo.tmpProductImprintAreaColorTranslations_ToDelete t
		on piact.ID = t.ID



		
-- Start Inserting
select	pia.ProductID,
		pia.ID as ProductImprintAreaID,
		v.HexCode,
		0 as [Default]
into dbo.tmpProductImprintAreaColors_ForInsert
from ProductImprintAreas pia
	join 
		(
			select ID as ProductID
			from Products
			where SupplierID = @SupplierID
		) p
	on pia.ProductID = p.ProductID
	join VendorImprintColors v
		on 1 = 1
			and v.ASINumber = @ASINumber
--where pia.ProductID = 1


alter table dbo.tmpProductImprintAreaColors_ForInsert
add UniqueID int identity(1,1) Primary Key


insert dbo.ProductImprintAreaColors(ProductID,ProductImprintAreaID,HexCode,[Default])
select ProductID,ProductImprintAreaID,HexCode,[Default]
from tmpProductImprintAreaColors_ForInsert


select	piac.ProductID,
		piac.ProductImprintAreaID,
		piac.ID as ProductImprintAreaColorID,
		l.ID as LocaleID,
		v.ColorName as Name
into dbo.tmpProductImprintAreaColorTranslations_ForInsert
from tmpProductImprintAreaColors_ForInsert t
	join dbo.ProductImprintAreaColors piac
		on t.ProductID = piac.ProductID
			and t.ProductImprintAreaID = piac.ProductImprintAreaID
			and t.HexCode = piac.HexCode
	join dbo.VendorImprintColors v
		on v.HexCode = piac.HexCode
			and v.ASINumber = @ASINumber
	join Locale l
		on l.LanguageCode = 'EN'
			and 1 = 1
	
alter table tmpProductImprintAreaColorTranslations_ForInsert
add UniqueID int identity(1,1) Primary Key
			
			
insert dbo.ProductImprintAreaColorTranslations(ProductID,ProductImprintAreaID,ProductImprintAreaColorID,LocaleID,Name)
select ProductID,ProductImprintAreaID,ProductImprintAreaColorID,LocaleID,Name
from dbo.tmpProductImprintAreaColorTranslations_ForInsert
GO
