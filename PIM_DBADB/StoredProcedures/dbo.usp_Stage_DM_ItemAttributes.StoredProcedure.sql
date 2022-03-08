CREATE Procedure [dbo].[usp_Stage_DM_ItemAttributes]

as

set nocount on

Truncate Table Stage_DM_ItemAttributes



insert Stage_DM_ItemAttributes
(
	SEGMENT1					,
	ITEM_ID						,
	PRODUCT_FAMILY				,
	PRODUCT_FAMILY_DESC			,
	PRODUCT_CODE				,
	PRODUCT_CODE_DESC			,
	PRODUCT_GROUP				,
	PRODUCT_GROUP_DESC			,
	PRODUCT_CLASS				,
	PRODUCT_CLASS_DESC			,
	PACK_SIZE					,
	INK_COLOR					,
	PRODUCT_COLOR				,
	LICENSE_TYPE				,
	OTHER						,
	DECORATION					,
	PRODUCT_SEGMENT				,
	PRODUCT_CATEGORY			,
	MATERIAL					,
	FINISH						,
	BRAND						,
	FUNCTIONN					,
	SKU_DESCRIPTION				
)
select	--ps.ID as SKUID,
		--ps.ProductID,
		ps.OracleID as SEGMENT1,
		ps.OracleInventoryItemID as ITEM_ID,
		pf.Family as PRODUCT_FAMILY,
		pf.[Version] as PRODUCT_FAMILY_DESC,
		p.NPProductCode as PRODUCT_CODE,
		p.NPProductCode as PRODUCT_CODE_DESC,
		p.GroupingCode as PRODUCT_GROUP,
		p.GroupingCode as PRODUCT_GROUP_DESC,
		c.Class as PRODUCT_CLASS,
		c.Class as PRODUCT_CLASS_DESC,
		NULL as PACK_SIZE,
		ink.InkColor as INK_COLOR,
		isnull(prodcolor.ProductColor,barrelcolor.BarrelColor) as PRODUCT_COLOR,
		NULL as LICENSE_TYPE,
		NULL as OTHER,
		ps.DecoMethod as DECORATION,
		cc1.[Description] as PRODUCT_SEGMENT,
		cc2.[Description] as PRODUCT_CATEGORY,
		pt.Material as MATERIAL,
		NULL as FINISH,
		p.BrandedName as BRAND,
		NULL as FUNCTIONN,
		ps.OracleDesc as SKU_DESCRIPTION
from ProductSKUs ps (nolock)
	left join Products p (nolock)
		on ps.ProductID = p.ID
	left join ProductTranslations pt (nolock)
		on p.ID = pt.ProductID
			and pt.LocaleID = 12
	left join ProductFamilys pf (nolock)
		on ps.ProductFamilyID = pf.ID
	left join
		(
			select	psa.ID,
					psa.ProductSkuID,
					psa.AttributeID,
					psa.Value as InkColor
			from ProductSkuAttributes psa (nolock)
				join ProductAttributeTranslations pat (nolock)
					on psa.ProductID = pat.ProductID
						and psa.AttributeID = pat.ProductAttributeID
						and pat.LocaleID = 12
						and pat.Name = 'Ink'
		) ink
	on ps.ID = ink.ProductSkuID
	left join
		(
			select	psa.ID,
					psa.ProductSkuID,
					psa.AttributeID,
					psa.Value as ProductColor
			from ProductSkuAttributes psa (nolock)
				join ProductAttributeTranslations pat (nolock)
					on psa.ProductID = pat.ProductID
						and psa.AttributeID = pat.ProductAttributeID
						and pat.LocaleID = 12
						and pat.Name = 'Product'
		) prodcolor
	on ps.ID = prodcolor.ProductSkuID
	left join
		(
			select	psa.ID,
					psa.ProductSkuID,
					psa.AttributeID,
					psa.Value as BarrelColor
			from ProductSkuAttributes psa (nolock)
				join ProductAttributeTranslations pat (nolock)
					on psa.ProductID = pat.ProductID
						and psa.AttributeID = pat.ProductAttributeID
						and pat.LocaleID = 12
						and pat.Name = 'Barrel'
		) barrelcolor
	on ps.ID = barrelcolor.ProductSkuID
	left join
		(
			select	RelatedProductID
			from dbo.ProductAccessories (nolock)
			where RelationTypeID = 2
		) rel
	on p.ID = rel.RelatedProductID
	left join CategoryCodes cc1 (nolock)
		on p.OracleCatalog1 = cc1.ID
	left join CategoryCodes cc2 (nolock)
		on p.OracleCatalog2 = cc2.ID
	left join Classes c (nolock)
		on p.Class = c.ID
where isnull(ps.OracleID,'') <> ''
	and rel.RelatedProductID is null
	and 
		(
			p.ProcessStatus not in (1,2) 
			and 
			p.ItemStatus not in (1,2,4,9,10,11)
		)
		

delete t
from Stage_DM_ItemAttributes t
	join
		(
			select	SEGMENT1,
					MIN(UniqueID) MinUniqueID
			from Stage_DM_ItemAttributes
			where SEGMENT1 like 'VDS%' or SEGMENT1 like 'VEN%'
			group by SEGMENT1
			having COUNT(*) > 1
		) d
	on t.SEGMENT1 = d.SEGMENT1
		and t.UniqueID <> d.MinUniqueID



-- Code to manipulate some data
update Stage_DM_ItemAttributes
set PRODUCT_CODE = 'VDS',
	PRODUCT_CODE_DESC = 'VDS'
where SEGMENT1 like 'VDS%'


update Stage_DM_ItemAttributes
set PRODUCT_CODE = 'VEN',
	PRODUCT_CODE_DESC = 'VEN'
where SEGMENT1 like 'VEN%'


update Stage_DM_ItemAttributes
set PRODUCT_GROUP = 'VDS',
	PRODUCT_GROUP_DESC = 'VDS'
where SEGMENT1 like 'VDS%'
	or SEGMENT1 like 'VEN%'
	
	
update Stage_DM_ItemAttributes
set PRODUCT_CLASS = 'VEN',
	PRODUCT_CLASS_DESC = 'VEN'
where SEGMENT1 like 'VDS%'
	or SEGMENT1 like 'VEN%'
	
	
update Stage_DM_ItemAttributes
set PRODUCT_CODE = 'ACC',
	PRODUCT_CODE_DESC = 'ACC'
where SEGMENT1 like 'ACC%'
	or SEGMENT1 like '70-ACC%'


GO
