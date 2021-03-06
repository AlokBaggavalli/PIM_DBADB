CREATE Procedure [dbo].[usp_PopulateStageOracleSKUForExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output
as

set nocount on


declare @LocaleID			int,
		@Type				varchar(50),
		@MinID				int,
		@BatchStatus		int


Create Table #ShipDefaultHolder	(
									UniqueID					int identity(1,1) Primary Key,
									ProductID					int,
									OracleID					nvarchar(255),
									ProdFamily					nvarchar(60),
									Channel						nvarchar(10),
									ChannelID					int,
									ProductFamilyID				int,
									TNS							bit,
									PLM							bit,
									IRL							bit,
									JPN							bit,
									CZE							bit,
									TNS_U						varchar(10),
									TNSShipOrgID_U				int,
									TNSDefaultShipping_U		nvarchar(100),
									PLM_U						varchar(10),
									PLMShipOrgID_U				int,
									PLMDefaultShipping_U		nvarchar(100),
									IRL_U						varchar(10),
									IRLShipOrgID_U				int,
									IRLDefaultShipping_U		nvarchar(100),
									PPC_U						varchar(10),
									PPCShipOrgID_U				int,
									PPCDefaultShipping_U		nvarchar(100),
									NDC_U						varchar(10),
									NDCShipOrgID_U				int,
									NDCDefaultShipping_U		nvarchar(100),
									SAN_U						varchar(10),
									SANShipOrgID_U				int,
									SANDefaultShipping_U		nvarchar(100),
									ZCA_U						varchar(10),
									ZCAShipOrgID_U				int,
									ZCADefaultShipping_U		nvarchar(100),
									ZPP_U						varchar(10),
									ZPPShipOrgID_U				int,
									ZPPDefaultShipping_U		nvarchar(100),
									ZAT_U						varchar(10),
									ZATShipOrgID_U				int,
									ZATDefaultShipping_U		nvarchar(100),
									GER_U						varchar(10),
									GERShipOrgID_U				int,
									GERDefaultShipping_U		nvarchar(100),
									CZE_U						varchar(10),
									CZEShipOrgID_U				int,
									CZEDefaultShipping_U		nvarchar(100),
									JPN_U						varchar(10),
									JPNShipOrgID_U				int,
									JPNDefaultShipping_U		nvarchar(100)
								)
						
						
Create Table #ProductSKU	(
								UniqueID						int identity(1,1) Primary Key,
								[ProductID]						int,
								[NEW_NPC_ITEM_NUM]				[nvarchar](100) NULL,
								[DESCRIPTION]					[nvarchar](250) NULL,
								[TARRIFF]						[nvarchar](100) NULL,
								[PROCESS]						[nvarchar](100) NULL,
								[COMMISSION_KEY]				[nvarchar](100) NULL,
								[ROYALTY_CODE]					[nvarchar](100) NULL,
								[ROYALTY_SUBCODE]				[nvarchar](100) NULL,
								[AVAILABLE_FOR_SALES_ORDER]		[nvarchar](100) NULL,
								[TNS]							[nvarchar](100) NULL,
								[TNS_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[PLM]							[nvarchar](100) NULL,
								[PLM_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[IRL]							[nvarchar](100) NULL,
								[IRL_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[PPC]							[nvarchar](100) NULL,
								[PPC_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[NDC]							[nvarchar](100) NULL,
								[NDC_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[SAN]							[nvarchar](100) NULL,
								[SAN_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[ZCA]							[nvarchar](100) NULL,
								[ZCA_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[ZPP]							[nvarchar](100) NULL,
								[ZPP_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[ZAT]							[nvarchar](100) NULL,
								[ZAT_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[GER]							[nvarchar](100) NULL,
								[GER_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[CZE]							[nvarchar](100) NULL,
								[CZE_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[JPN]							[nvarchar](100) NULL,
								[JPN_DEFAULT_SHIPPING]			[nvarchar](100) NULL,
								[CATEGORY_PF]					[nvarchar](100) NULL,
								[CATEGORY]						[nvarchar](100) NULL,
								[CATEGORY_INV]					[nvarchar](100) NULL,
								[ITEM_FAMILY]					[nvarchar](100) NULL,
								[ITEM_CLASS]					[nvarchar](100) NULL,
								[COST_OF_GOODS_ACCOUNT]			[nvarchar](100) NULL,
								[SALES_ACCOUNT]					[nvarchar](100) NULL,
								[SUBINVENTORY]					[nvarchar](100) NULL,
								[UNIT_OF_MEASURE]				[nvarchar](100) NULL,
								[MASTER_ITEM_TEMPLATE]			[nvarchar](100) NULL,
								[CATALOG_SEGMENT1]				[nvarchar](100) NULL,
								[CATALOG_SEGMENT2]				[nvarchar](100) NULL,
								[CATALOG_SEGMENT3]				[nvarchar](100) NULL,
								[CATALOG_SEGMENT4]				[nvarchar](100) NULL,
								[PRODUCT_CLASS]					[nvarchar](100) NULL,
								[PRODUCT_GROUPING_CODE]			[nvarchar](100) NULL,
								[PRODUCT_CODE]					[nvarchar](100) NULL,
								[SKU_CATEGORY]					[nvarchar](100) NULL,
								[PACK_SIZE]						[nvarchar](100) NULL,
								[INK_COLOR]						[nvarchar](100) NULL,
								[PRODUCT_COLOR]					[nvarchar](100) NULL,
								[BARREL_TYPE]					[nvarchar](100) NULL,
								[SKU_DESCRIPTION]				[nvarchar](100) NULL,
								[DECORATION_METHOD]				[nvarchar](100) NULL,
								[OTHER]							[nvarchar](100) NULL,
								[PRODUCT_FAMILY]				[nvarchar](100) NULL,
								[ATTRIBUTE1]					[nvarchar](100) NULL,
								[ATTRIBUTE2]					[nvarchar](100) NULL,
								[ATTRIBUTE3]					[nvarchar](100) NULL,
								[ATTRIBUTE4]					[nvarchar](100) NULL,
								[ATTRIBUTE5]					[nvarchar](100) NULL,
								[ATTRIBUTE6]					[nvarchar](100) NULL,
								[ATTRIBUTE7]					[nvarchar](100) NULL,
								[ATTRIBUTE8]					[nvarchar](100) NULL,
								[ATTRIBUTE9]					[nvarchar](100) NULL,
								[ATTRIBUTE10]					[nvarchar](100) NULL,
								[ATTRIBUTE11]					[nvarchar](100) NULL,
								[ATTRIBUTE12]					[nvarchar](100) NULL,
								[ATTRIBUTE13]					[nvarchar](100) NULL,
								[ATTRIBUTE14]					[nvarchar](100) NULL,
								[ATTRIBUTE15]					[nvarchar](100) NULL,
								[INVENTORY_ITEM_ID]				[nvarchar](100) NULL,
								[MASTER_ITEM_TEMPLATE_ID]		[nvarchar](100) NULL,
								[PRIMARY_UOM_CODE]				[nvarchar](100) NULL,
								[WEIGHT_UOM_CODE]				[nvarchar](100) NULL,
								[TNS_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[PLM_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[IRL_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[PPC_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[SAN_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[NDC_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[ZCA_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[ZPP_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[ZAT_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[GER_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[CZE_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[JPN_DEF_SHP_ORG_ID]			[nvarchar](100) NULL,
								[CATEGORY_1_SET_NAME]			[nvarchar](100) NULL,
								[CATEGORY_1_ID]					[nvarchar](100) NULL,
								[CATEGORY_2_SET_NAME]			[nvarchar](100) NULL,
								[CATEGORY_2_ID]					[nvarchar](100) NULL,
								[COST_OF_SALES_CCID]			[nvarchar](100) NULL,
								[SALES_CCID]					[nvarchar](100) NULL,
								[MINIMUM]						[nvarchar](100) NULL,
								[MAXIMUM]						[nvarchar](100) NULL,
								[VALIDATION_FLAG]				[nvarchar](100) NULL,
								[PROCESS_FLAG]					[nvarchar](100) NULL,
								[PRODUCT_DESCRIPTION]			[nvarchar](255) NULL,
								[SKU_LONG_DESCRIPTION]			[nvarchar](255) NULL,
								[PROP65_CHECK]					[nvarchar](10) NULL,
								[DEFAULT_BUYER]					[nvarchar](240) NULL,
								[LIST_PRICE]					[money]	NULL,
								[TypeValue]						[nvarchar](50) NULL,
								[DistChannel]					[nvarchar](100) NULL,
								[ProdFamily]					[nvarchar](60) NULL,
								[ProductFamilyID]				[int] NULL
						)

						
						
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '5'



select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @Type
						and [Status] in('2','6')
				)
				
				
select @BatchStatus = [Status] from BatchExtracts where ID = @MinID
			
							
if @BatchStatus = 2
begin
	insert #ProductSKU
	(
			[ProductID]						,
			[NEW_NPC_ITEM_NUM]				,
			[DESCRIPTION]					,
			[TARRIFF]						,
			[PROCESS]						,
			[COMMISSION_KEY]				,
			[ROYALTY_CODE]					,
			[ROYALTY_SUBCODE]				,
			[AVAILABLE_FOR_SALES_ORDER]		,
			[TNS]							,
			[TNS_DEFAULT_SHIPPING]			,
			[PLM]							,
			[PLM_DEFAULT_SHIPPING]			,
			[IRL]							,
			[IRL_DEFAULT_SHIPPING]			,
			[PPC]							,
			[PPC_DEFAULT_SHIPPING]			,
			[NDC]							,
			[NDC_DEFAULT_SHIPPING]			,
			[SAN]							,
			[SAN_DEFAULT_SHIPPING]			,
			[ZCA]							,
			[ZCA_DEFAULT_SHIPPING]			,
			[ZPP]							,
			[ZPP_DEFAULT_SHIPPING]			,
			[ZAT]							,
			[ZAT_DEFAULT_SHIPPING]			,
			[GER]							,
			[GER_DEFAULT_SHIPPING]			,
			[CZE]							,
			[CZE_DEFAULT_SHIPPING]			,
			[JPN]							,
			[JPN_DEFAULT_SHIPPING]			,
			[CATEGORY_PF]					,
			[CATEGORY]						,
			[CATEGORY_INV]					,
			[ITEM_FAMILY]					,
			[ITEM_CLASS]					,
			[COST_OF_GOODS_ACCOUNT]			,
			[SALES_ACCOUNT]					,
			[SUBINVENTORY]					,
			[UNIT_OF_MEASURE]				,
			[MASTER_ITEM_TEMPLATE]			,
			[CATALOG_SEGMENT1]				,
			[CATALOG_SEGMENT2]				,
			[CATALOG_SEGMENT3]				,
			[CATALOG_SEGMENT4]				,
			[PRODUCT_CLASS]					,
			[PRODUCT_GROUPING_CODE]			,
			[PRODUCT_CODE]					,
			[SKU_CATEGORY]					,
			[PACK_SIZE]						,
			[INK_COLOR]						,
			[PRODUCT_COLOR]					,
			[BARREL_TYPE]					,
			[SKU_DESCRIPTION]				,
			[DECORATION_METHOD]				,
			[OTHER]							,
			[PRODUCT_FAMILY]				,
			[ATTRIBUTE1]					,
			[ATTRIBUTE2]					,
			[ATTRIBUTE3]					,
			[ATTRIBUTE4]					,
			[ATTRIBUTE5]					,
			[ATTRIBUTE6]					,
			[ATTRIBUTE7]					,
			[ATTRIBUTE8]					,
			[ATTRIBUTE9]					,
			[ATTRIBUTE10]					,
			[ATTRIBUTE11]					,
			[ATTRIBUTE12]					,
			[ATTRIBUTE13]					,
			[ATTRIBUTE14]					,
			[ATTRIBUTE15]					,
			[INVENTORY_ITEM_ID]				,
			[MASTER_ITEM_TEMPLATE_ID]		,
			[PRIMARY_UOM_CODE]				,
			[WEIGHT_UOM_CODE]				,
			[TNS_DEF_SHP_ORG_ID]			,
			[PLM_DEF_SHP_ORG_ID]			,
			[IRL_DEF_SHP_ORG_ID]			,
			[PPC_DEF_SHP_ORG_ID]			,
			[SAN_DEF_SHP_ORG_ID]			,
			[NDC_DEF_SHP_ORG_ID]			,
			[ZCA_DEF_SHP_ORG_ID]			,
			[ZPP_DEF_SHP_ORG_ID]			,
			[ZAT_DEF_SHP_ORG_ID]			,
			[GER_DEF_SHP_ORG_ID]			,
			[CZE_DEF_SHP_ORG_ID]			,
			[JPN_DEF_SHP_ORG_ID]			,
			[CATEGORY_1_SET_NAME]			,
			[CATEGORY_1_ID]					,
			[CATEGORY_2_SET_NAME]			,
			[CATEGORY_2_ID]					,
			[COST_OF_SALES_CCID]			,
			[SALES_CCID]					,
			[MINIMUM]						,
			[MAXIMUM]						,
			[VALIDATION_FLAG]				,
			[PROCESS_FLAG]					,
			[PRODUCT_DESCRIPTION]			,
			[SKU_LONG_DESCRIPTION]			,
			[PROP65_CHECK]					,
			[DEFAULT_BUYER]					,
			[LIST_PRICE]					,
			[TypeValue]						,
			[DistChannel]					,
			[ProdFamily]					,
			[ProductFamilyID]
	)
	select	p.ID as ProductID,
			ps.OracleID as NEW_NPC_ITEM_NUM,
			ps.OracleDesc as [DESCRIPTION],
			case 
				when ps.OracleID like 'VDS%'
					then p.NPProductCode
				else
					p.TarriffCode
			end as TARRIFF,
			case 
				when ps.OracleID like 'VDS%'
					then 'VDS'
				else
					null
			end as PROCESS,
			1 as COMMISSION_KEY,
			ps.Royalty as ROYALTY_CODE,
			ps.RoyaltySub as ROYALTY_SUBCODE,
			'Y' as 'AVAILABLE_FOR_SALES_ORDER',
			'' as [TNS],
			'' as [TNS_DEFAULT_SHIPPING],
			'' as [PLM],
			'' as [PLM_DEFAULT_SHIPPING],
			'' as [IRL],
			'' as [IRL_DEFAULT_SHIPPING],
			'' as [PPC],
			'' as [PPC_DEFAULT_SHIPPING],
			'' as [NDC],
			'' as [NDC_DEFAULT_SHIPPING],
			'' as [SAN],
			'' as [SAN_DEFAULT_SHIPPING],
			'' as [ZCA],
			'' as [ZCA_DEFAULT_SHIPPING],
			'' as [ZPP],
			'' as [ZPP_DEFAULT_SHIPPING],
			'' as [ZAT],
			'' as [ZAT_DEFAULT_SHIPPING],
			'' as [GER],
			'' as [GER_DEFAULT_SHIPPING],
			'' as [CZE],
			'' as [CZE_DEFAULT_SHIPPING],
			'' as [JPN],
			'' as [JPN_DEFAULT_SHIPPING],
			case 
				when ps.OracleID not like 'VDS%' and ps.OracleID not like 'VEN%' and ISNULL(ps.ProdFamily,'') <> '' and ps.SkuFormatID <> 3
					then 'Product Family'
				else
					''
			end as CATEGORY_PF,
			case 
				when ps.OracleID not like 'VDS%' and ps.OracleID not like 'VEN%' and ISNULL(ps.ProdFamily,'') <> '' and ps.SkuFormatID <> 3
					then ps.ProdFamily
				else
					''
			end as CATEGORY,
			case 
				when ISNULL(p.OracleCategoryCode,'') <> ''
					then 'Inventory'
				else
					''
			end as CATEGORY_INV,
			case
				when CHARINDEX('.',ISNULL(p.OracleCategoryCode,'')) = 0
					then ''
				else
					Left(ISNULL(p.OracleCategoryCode,''),CHARINDEX('.',ISNULL(p.OracleCategoryCode,'')) - 1) 
			end as ITEM_FAMILY,
			case
				when CHARINDEX('.',ISNULL(p.OracleCategoryCode,'')) = 0
					then ''
				else
					Right(ISNULL(p.OracleCategoryCode,''),len(ISNULL(p.OracleCategoryCode,'')) - CHARINDEX('.',ISNULL(p.OracleCategoryCode,''))) 
			end as ITEM_CLASS,
			case
				when ps.SkuFormatID = 3
					then '1110-00-000-CA-0000'
				else
					p.CostOfGoodsAccount
			end as COST_OF_GOODS_ACCOUNT,
			case
				when ps.SkuFormatID = 3
					then '1110-00-000-CA-0000'
				else
					p.SalesAccount 
			end as SALES_ACCOUNT,
			'FGI' as SUBINVENTORY,
			'EACH' as UNIT_OF_MEASURE,
			--p.ItemUserTypeID as MASTER_ITEM_TEMPLATE,
			iut.[Description] as MASTER_ITEM_TEMPLATE,
			--p.OracleCatalog1 as CATALOG_SEGMENT1,
			--p.OracleCatalog2 as CATALOG_SEGMENT2,
			--p.OracleCatalog3 as CATALOG_SEGMENT3,
			--p.OracleCatalog4 as CATALOG_SEGMENT4,
			
			cc1.[Description] as CATALOG_SEGMENT1,
			cc2.[Description] as CATALOG_SEGMENT2,
			cc3.[Description] as CATALOG_SEGMENT3,
			cc4.[Description] as CATALOG_SEGMENT4,
			
			pc.Class as PRODUCT_CLASS,
			p.GroupingCode as PRODUCT_GROUPING_CODE,
			p.NPProductCode as PRODUCT_CODE,
			'' as SKU_CATEGORY,
			ps.PackSize as PACK_SIZE,
			ps.InkColor as INK_COLOR,
			ps.ProdColor as PRODUCT_COLOR,
			ps.BarrelType as BARREL_TYPE,
			'' as SKU_DESCRIPTION,
			ps.DecoMethod as DECORATION_METHOD,
			'' as OTHER,
			'' as PRODUCT_FAMILY,
			'' as ATTRIBUTE1,
			'' as ATTRIBUTE2,
			'' as ATTRIBUTE3,
			'' as ATTRIBUTE4,
			'' as ATTRIBUTE5,
			'' as ATTRIBUTE6,
			'' as ATTRIBUTE7,
			'' as ATTRIBUTE8,
			'' as ATTRIBUTE9,
			'' as ATTRIBUTE10,
			'' as ATTRIBUTE11,
			'' as ATTRIBUTE12,
			'' as ATTRIBUTE13,
			'' as ATTRIBUTE14,
			'' as ATTRIBUTE15,
			'' as INVENTORY_ITEM_ID,
			'' as MASTER_ITEM_TEMPLATE_ID,
			'' as PRIMARY_UOM_CODE,
			'' as WEIGHT_UOM_CODE,
			'' as TNS_DEF_SHP_ORG_ID,
			'' as PLM_DEF_SHP_ORG_ID,
			'' as IRL_DEF_SHP_ORG_ID,
			'' as PPC_DEF_SHP_ORG_ID,
			'' as SAN_DEF_SHP_ORG_ID,
			'' as NDC_DEF_SHP_ORG_ID,
			'' as ZCA_DEF_SHP_ORG_ID,
			'' as ZPP_DEF_SHP_ORG_ID,
			'' as ZAT_DEF_SHP_ORG_ID,
			'' as GER_DEF_SHP_ORG_ID,
			'' as CZE_DEF_SHP_ORG_ID,
			'' as JPN_DEF_SHP_ORG_ID,
			'' as CATEGORY_1_SET_NAME,
			'' as CATEGORY_1_ID,
			'' as CATEGORY_2_SET_NAME,
			'' as CATEGORY_2_ID,
			'' as COST_OF_SALES_CCID,
			'' as SALES_CCID,
			'' as MINIMUM,
			'' as MAXIMUM,
			'' as VALIDATION_FLAG,
			'' as PROCESS_FLAG,
			ptran.NPProductName as PRODUCT_DESCRIPTION,
			p.PatentInfo as SKU_LONG_DESCRIPTION,
			Case
				when p.Features like '%Prop 65%'
					then 'Y'
				else
					'N'
			End as PROP65_CHECK,
			NULL AS [DEFAULT_BUYER],
			NULL AS [LIST_PRICE],
			'Sku' as TypeValue,
			ps.DistChannel,
			ps.ProdFamily,
			ps.ProductFamilyID
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				--and pb.ChannelID = 1 -- NADM Only (Take all Channel For Oracle SKU)
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductSKUs ps
			ON p.ID = ps.ProductID
				--and ps.Active = 1 -- Obsolete (Field has been removed)
		left join ItemUserTypes iut
			on p.ItemUserTypeID = iut.ID
			
			
		left join CategoryCodes cc1
			on p.OracleCatalog1 = cc1.ID
		left join CategoryCodes cc2
			on p.OracleCatalog2 = cc2.ID
		left join CategoryCodes cc3
			on p.OracleCatalog3 = cc3.ID
		left join CategoryCodes cc4
			on p.OracleCatalog4 = cc4.ID
			
		left join Classes pc
			on p.Class = pc.ID
		left join ProductTranslations ptran
			on p.ID = ptran.ProductID
				and ptran.LocaleID = 12
				and pb.ChannelID = ptran.ChannelID
	where be.[Status] = '2'
		and be.ID = @MinID
	order by p.ID
end



if @BatchStatus = 6
begin
	insert #ProductSKU
	(
			[ProductID]						,
			[NEW_NPC_ITEM_NUM]				,
			[DESCRIPTION]					,
			[TARRIFF]						,
			[PROCESS]						,
			[COMMISSION_KEY]				,
			[ROYALTY_CODE]					,
			[ROYALTY_SUBCODE]				,
			[AVAILABLE_FOR_SALES_ORDER]		,
			[TNS]							,
			[TNS_DEFAULT_SHIPPING]			,
			[PLM]							,
			[PLM_DEFAULT_SHIPPING]			,
			[IRL]							,
			[IRL_DEFAULT_SHIPPING]			,
			[PPC]							,
			[PPC_DEFAULT_SHIPPING]			,
			[NDC]							,
			[NDC_DEFAULT_SHIPPING]			,
			[SAN]							,
			[SAN_DEFAULT_SHIPPING]			,
			[ZCA]							,
			[ZCA_DEFAULT_SHIPPING]			,
			[ZPP]							,
			[ZPP_DEFAULT_SHIPPING]			,
			[ZAT]							,
			[ZAT_DEFAULT_SHIPPING]			,
			[GER]							,
			[GER_DEFAULT_SHIPPING]			,
			[CZE]							,
			[CZE_DEFAULT_SHIPPING]			,
			[JPN]							,
			[JPN_DEFAULT_SHIPPING]			,
			[CATEGORY_PF]					,
			[CATEGORY]						,
			[CATEGORY_INV]					,
			[ITEM_FAMILY]					,
			[ITEM_CLASS]					,
			[COST_OF_GOODS_ACCOUNT]			,
			[SALES_ACCOUNT]					,
			[SUBINVENTORY]					,
			[UNIT_OF_MEASURE]				,
			[MASTER_ITEM_TEMPLATE]			,
			[CATALOG_SEGMENT1]				,
			[CATALOG_SEGMENT2]				,
			[CATALOG_SEGMENT3]				,
			[CATALOG_SEGMENT4]				,
			[PRODUCT_CLASS]					,
			[PRODUCT_GROUPING_CODE]			,
			[PRODUCT_CODE]					,
			[SKU_CATEGORY]					,
			[PACK_SIZE]						,
			[INK_COLOR]						,
			[PRODUCT_COLOR]					,
			[BARREL_TYPE]					,
			[SKU_DESCRIPTION]				,
			[DECORATION_METHOD]				,
			[OTHER]							,
			[PRODUCT_FAMILY]				,
			[ATTRIBUTE1]					,
			[ATTRIBUTE2]					,
			[ATTRIBUTE3]					,
			[ATTRIBUTE4]					,
			[ATTRIBUTE5]					,
			[ATTRIBUTE6]					,
			[ATTRIBUTE7]					,
			[ATTRIBUTE8]					,
			[ATTRIBUTE9]					,
			[ATTRIBUTE10]					,
			[ATTRIBUTE11]					,
			[ATTRIBUTE12]					,
			[ATTRIBUTE13]					,
			[ATTRIBUTE14]					,
			[ATTRIBUTE15]					,
			[INVENTORY_ITEM_ID]				,
			[MASTER_ITEM_TEMPLATE_ID]		,
			[PRIMARY_UOM_CODE]				,
			[WEIGHT_UOM_CODE]				,
			[TNS_DEF_SHP_ORG_ID]			,
			[PLM_DEF_SHP_ORG_ID]			,
			[IRL_DEF_SHP_ORG_ID]			,
			[PPC_DEF_SHP_ORG_ID]			,
			[SAN_DEF_SHP_ORG_ID]			,
			[NDC_DEF_SHP_ORG_ID]			,
			[ZCA_DEF_SHP_ORG_ID]			,
			[ZPP_DEF_SHP_ORG_ID]			,
			[ZAT_DEF_SHP_ORG_ID]			,
			[GER_DEF_SHP_ORG_ID]			,
			[CZE_DEF_SHP_ORG_ID]			,
			[JPN_DEF_SHP_ORG_ID]			,
			[CATEGORY_1_SET_NAME]			,
			[CATEGORY_1_ID]					,
			[CATEGORY_2_SET_NAME]			,
			[CATEGORY_2_ID]					,
			[COST_OF_SALES_CCID]			,
			[SALES_CCID]					,
			[MINIMUM]						,
			[MAXIMUM]						,
			[VALIDATION_FLAG]				,
			[PROCESS_FLAG]					,
			[PRODUCT_DESCRIPTION]			,
			[SKU_LONG_DESCRIPTION]			,
			[PROP65_CHECK]					,
			[DEFAULT_BUYER]					,
			[LIST_PRICE]					,
			[TypeValue]						,
			[DistChannel]					,
			[ProdFamily]					,
			[ProductFamilyID]
	)
	select	p.ID as ProductID,
			ps.OracleID as NEW_NPC_ITEM_NUM,
			ps.OracleDesc as [DESCRIPTION],
			case 
				when ps.OracleID like 'VDS%'
					then p.NPProductCode
				else
					p.TarriffCode
			end as TARRIFF,
			case 
				when ps.OracleID like 'VDS%'
					then 'VDS'
				else
					null
			end as PROCESS,
			1 as COMMISSION_KEY,
			ps.Royalty as ROYALTY_CODE,
			ps.RoyaltySub as ROYALTY_SUBCODE,
			'Y' as 'AVAILABLE_FOR_SALES_ORDER',
			'' as [TNS],
			'' as [TNS_DEFAULT_SHIPPING],
			'' as [PLM],
			'' as [PLM_DEFAULT_SHIPPING],
			'' as [IRL],
			'' as [IRL_DEFAULT_SHIPPING],
			'' as [PPC],
			'' as [PPC_DEFAULT_SHIPPING],
			'' as [NDC],
			'' as [NDC_DEFAULT_SHIPPING],
			'' as [SAN],
			'' as [SAN_DEFAULT_SHIPPING],
			'' as [ZCA],
			'' as [ZCA_DEFAULT_SHIPPING],
			'' as [ZPP],
			'' as [ZPP_DEFAULT_SHIPPING],
			'' as [ZAT],
			'' as [ZAT_DEFAULT_SHIPPING],
			'' as [GER],
			'' as [GER_DEFAULT_SHIPPING],	
			'' as [CZE],
			'' as [CZE_DEFAULT_SHIPPING],
			'' as [JPN],
			'' as [JPN_DEFAULT_SHIPPING],
			case 
				when ps.OracleID not like 'VDS%' and ps.OracleID not like 'VEN%' and ISNULL(ps.ProdFamily,'') <> '' and ps.SkuFormatID <> 3
					then 'Product Family'
				else
					''
			end as CATEGORY_PF,
			case 
				when ps.OracleID not like 'VDS%' and ps.OracleID not like 'VEN%' and ISNULL(ps.ProdFamily,'') <> '' and ps.SkuFormatID <> 3
					then ps.ProdFamily
				else
					''
			end as CATEGORY,
			case 
				when ISNULL(p.OracleCategoryCode,'') <> ''
					then 'Inventory'
				else
					''
			end as CATEGORY_INV,
			case
				when CHARINDEX('.',ISNULL(p.OracleCategoryCode,'')) = 0
					then ''
				else
					Left(ISNULL(p.OracleCategoryCode,''),CHARINDEX('.',ISNULL(p.OracleCategoryCode,'')) - 1) 
			end as ITEM_FAMILY,
			case
				when CHARINDEX('.',ISNULL(p.OracleCategoryCode,'')) = 0
					then ''
				else
					Right(ISNULL(p.OracleCategoryCode,''),len(ISNULL(p.OracleCategoryCode,'')) - CHARINDEX('.',ISNULL(p.OracleCategoryCode,''))) 
			end as ITEM_CLASS,
			case
				when ps.SkuFormatID = 3
					then '1110-00-000-CA-0000'
				else
					p.CostOfGoodsAccount
			end as COST_OF_GOODS_ACCOUNT,
			case
				when ps.SkuFormatID = 3
					then '1110-00-000-CA-0000'
				else
					p.SalesAccount 
			end as SALES_ACCOUNT,
			'FGI' as SUBINVENTORY,
			'EACH' as UNIT_OF_MEASURE,
			--p.ItemUserTypeID as MASTER_ITEM_TEMPLATE,
			iut.[Description] as MASTER_ITEM_TEMPLATE,
			--p.OracleCatalog1 as CATALOG_SEGMENT1,
			--p.OracleCatalog2 as CATALOG_SEGMENT2,
			--p.OracleCatalog3 as CATALOG_SEGMENT3,
			--p.OracleCatalog4 as CATALOG_SEGMENT4,
			
			cc1.[Description] as CATALOG_SEGMENT1,
			cc2.[Description] as CATALOG_SEGMENT2,
			cc3.[Description] as CATALOG_SEGMENT3,
			cc4.[Description] as CATALOG_SEGMENT4,
			
			pc.Class as PRODUCT_CLASS,
			p.GroupingCode as PRODUCT_GROUPING_CODE,
			p.NPProductCode as PRODUCT_CODE,
			'' as SKU_CATEGORY,
			ps.PackSize as PACK_SIZE,
			ps.InkColor as INK_COLOR,
			ps.ProdColor as PRODUCT_COLOR,
			ps.BarrelType as BARREL_TYPE,
			'' as SKU_DESCRIPTION,
			ps.DecoMethod as DECORATION_METHOD,
			'' as OTHER,
			'' as PRODUCT_FAMILY,
			'' as ATTRIBUTE1,
			'' as ATTRIBUTE2,
			'' as ATTRIBUTE3,
			'' as ATTRIBUTE4,
			'' as ATTRIBUTE5,
			'' as ATTRIBUTE6,
			'' as ATTRIBUTE7,
			'' as ATTRIBUTE8,
			'' as ATTRIBUTE9,
			'' as ATTRIBUTE10,
			'' as ATTRIBUTE11,
			'' as ATTRIBUTE12,
			'' as ATTRIBUTE13,
			'' as ATTRIBUTE14,
			'' as ATTRIBUTE15,
			'' as INVENTORY_ITEM_ID,
			'' as MASTER_ITEM_TEMPLATE_ID,
			'' as PRIMARY_UOM_CODE,
			'' as WEIGHT_UOM_CODE,
			'' as TNS_DEF_SHP_ORG_ID,
			'' as PLM_DEF_SHP_ORG_ID,
			'' as IRL_DEF_SHP_ORG_ID,
			'' as PPC_DEF_SHP_ORG_ID,
			'' as SAN_DEF_SHP_ORG_ID,
			'' as NDC_DEF_SHP_ORG_ID,
			'' as ZCA_DEF_SHP_ORG_ID,
			'' as ZPP_DEF_SHP_ORG_ID,
			'' as ZAT_DEF_SHP_ORG_ID,
			'' as GER_DEF_SHP_ORG_ID,
			'' as CZE_DEF_SHP_ORG_ID,
			'' as JPN_DEF_SHP_ORG_ID,
			'' as CATEGORY_1_SET_NAME,
			'' as CATEGORY_1_ID,
			'' as CATEGORY_2_SET_NAME,
			'' as CATEGORY_2_ID,
			'' as COST_OF_SALES_CCID,
			'' as SALES_CCID,
			'' as MINIMUM,
			'' as MAXIMUM,
			'' as VALIDATION_FLAG,
			'' as PROCESS_FLAG,
			ptran.NPProductName as PRODUCT_DESCRIPTION,
			p.PatentInfo as SKU_LONG_DESCRIPTION,
			Case
				when p.Features like '%Prop 65%'
					then 'Y'
				else
					'N'
			End as PROP65_CHECK,
			null as DEFAULT_BUYER,
			null as LIST_PRICE,
			bep.Value as TypeValue,
			ps.DistChannel,
			ps.ProdFamily,
			ps.ProductFamilyID
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				--and pb.ChannelID = 1 -- NADM Only (Take all Channel For Oracle SKU)
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductSKUs ps
			ON p.ID = ps.ProductID
				--and ps.Active = 1 -- Obsolete (Field has been removed)
		left join ItemUserTypes iut
			on p.ItemUserTypeID = iut.ID
			
			
		left join CategoryCodes cc1
			on p.OracleCatalog1 = cc1.ID
		left join CategoryCodes cc2
			on p.OracleCatalog2 = cc2.ID
		left join CategoryCodes cc3
			on p.OracleCatalog3 = cc3.ID
		left join CategoryCodes cc4
			on p.OracleCatalog4 = cc4.ID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[SkuID] = ps.ID
				
		left join Classes pc
			on p.Class = pc.ID
		left join ProductTranslations ptran
			on p.ID = ptran.ProductID
				and ptran.LocaleID = 12
				and pb.ChannelID = ptran.ChannelID
	where be.[Status] = '6'
		and be.ID = @MinID
		
	union

	select	p.ID as ProductID,
			pfcc.Component as NEW_NPC_ITEM_NUM,
			pfcc.[Description] as [DESCRIPTION],
			null as TARRIFF,
			null as PROCESS,
			null as COMMISSION_KEY,
			null as ROYALTY_CODE,
			null as ROYALTY_SUBCODE,	
			null as 'AVAILABLE_FOR_SALES_ORDER',
			'Y' as [TNS],
			'Tennessee' as [TNS_DEFAULT_SHIPPING],
			'Y' as [PLM],
			'Pluma Nacional' as [PLM_DEFAULT_SHIPPING],
			'Y' as [IRL],
			'Ireland' as [IRL_DEFAULT_SHIPPING],
			null as [PPC],
			null as [PPC_DEFAULT_SHIPPING],
			null as [NDC],
			null as [NDC_DEFAULT_SHIPPING],
			null as [SAN],
			null as [SAN_DEFAULT_SHIPPING],
			null as [ZCA],
			null as [ZCA_DEFAULT_SHIPPING],
			null as [ZPP],
			null as [ZPP_DEFAULT_SHIPPING],
			null as [ZAT],
			null as [ZAT_DEFAULT_SHIPPING],
			'Y' as [GER],
			'Germany' as [GER_DEFAULT_SHIPPING],
			'Y' as [CZE],
			'Czech Republic' as [CZE_DEFAULT_SHIPPING],	
			'Y' as [JPN],
			'Kisarazu' as [JPN_DEFAULT_SHIPPING],	
			null as CATEGORY_PF,
			null as CATEGORY,
			'Inventory' as CATEGORY_INV,
			left(ic.Category,CHARINDEX('.',ic.Category) - 1) as ITEM_FAMILY,
			right(ic.Category,len(ic.Category) - charindex('.',ic.Category)) as ITEM_CLASS,			
			'6020-MO-MSC-CA-0000' as COST_OF_GOODS_ACCOUNT,
			'5210-MO-MSC-CA-0000' as SALES_ACCOUNT,
			null as SUBINVENTORY,
			skm.[Description] as UNIT_OF_MEASURE,
			'NPC PURCHASED ITEMS' as MASTER_ITEM_TEMPLATE,		
			null as CATALOG_SEGMENT1,
			null as CATALOG_SEGMENT2,
			null as CATALOG_SEGMENT3,
			null as CATALOG_SEGMENT4,
			null as PRODUCT_CLASS,
			null as PRODUCT_GROUPING_CODE,
			null as PRODUCT_CODE,
			null as SKU_CATEGORY,
			null as PACK_SIZE,
			null as INK_COLOR,
			null as PRODUCT_COLOR,
			null as BARREL_TYPE,
			null as SKU_DESCRIPTION,
			null as DECORATION_METHOD,
			null as OTHER,
			null as PRODUCT_FAMILY,
			null as ATTRIBUTE1,
			null as ATTRIBUTE2,
			null as ATTRIBUTE3,
			null as ATTRIBUTE4,
			null as ATTRIBUTE5,
			null as ATTRIBUTE6,
			null as ATTRIBUTE7,
			null as ATTRIBUTE8,
			null as ATTRIBUTE9,
			null as ATTRIBUTE10,
			null as ATTRIBUTE11,
			null as ATTRIBUTE12,
			null as ATTRIBUTE13,
			null as ATTRIBUTE14,
			null as ATTRIBUTE15,
			null as INVENTORY_ITEM_ID,
			null as MASTER_ITEM_TEMPLATE_ID,
			null as PRIMARY_UOM_CODE,
			null as WEIGHT_UOM_CODE,
			null as TNS_DEF_SHP_ORG_ID,
			null as PLM_DEF_SHP_ORG_ID,
			null as IRL_DEF_SHP_ORG_ID,
			null as PPC_DEF_SHP_ORG_ID,
			null as SAN_DEF_SHP_ORG_ID,
			null as NDC_DEF_SHP_ORG_ID,
			null as ZCA_DEF_SHP_ORG_ID,
			null as ZPP_DEF_SHP_ORG_ID,
			null as ZAT_DEF_SHP_ORG_ID,
			null as GER_DEF_SHP_ORG_ID,
			null as CZE_DEF_SHP_ORG_ID,
			null as JPN_DEF_SHP_ORG_ID,
			null as CATEGORY_1_SET_NAME,
			null as CATEGORY_1_ID,
			null as CATEGORY_2_SET_NAME,
			null as CATEGORY_2_ID,
			null as COST_OF_SALES_CCID,
			null as SALES_CCID,
			null as MINIMUM,
			null as MAXIMUM,
			null as VALIDATION_FLAG,
			null as PROCESS_FLAG,
			null as PRODUCT_DESCRIPTION,
			null as SKU_LONG_DESCRIPTION,
			'N' as PROP65_CHECK,
			mb.Buyer as DEFAULT_BUYER,
			pfmc.ItemCost as LIST_PRICE,
			bep.Value as TypeValue,
			null as DistChannel,
			null as ProdFamily,
			null as ProductFamilyID
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				--and pb.ChannelID = 1 -- NADM Only (Take all Channel For Oracle SKU)
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Value] = 'Component'
		join dbo.ProductFOBCostComponents pfcc
			on bep.ProductID = pfcc.ProductID
				and bep.[Description] = pfcc.Component
		left join dbo.InventoryCategories ic
			on pfcc.InventoryCategoryID = ic.ID
		left join dbo.SkuUOM skm
			on pfcc.UOMID = skm.ID
		left join dbo.ProductFOBMaterialCosts pfmc
			on pfcc.ProductFobMaterialCostsID = pfmc.ID
		left join dbo.MaterialBuyers mb
			on pfmc.BuyerID = mb.ID
	where be.[Status] = '6'
		and be.ID = @MinID
end



-- Vendor Org Update
update #ProductSKU
set TNS = 'Y',
	TNS_DEFAULT_SHIPPING = 'ZCA - NPC Drop Ship',
	PPC = 'Y',
	PPC_DEFAULT_SHIPPING = 'ZPP - PPC Drop Ship',
	ZCA = 'Y',
	ZPP = 'Y'
where NEW_NPC_ITEM_NUM like 'VDS%'
	and isnull(SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and TypeValue = 'Sku'


update #ProductSKU
set IRL = 'Y',
	IRL_DEFAULT_SHIPPING = 'Ireland'
where NEW_NPC_ITEM_NUM like 'VEN%'
	and isnull(SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and TypeValue = 'Sku'


-- Update Org Start
insert #ShipDefaultHolder
	(
		ProductID,
		OracleID,
		ProdFamily,
		Channel,
		ChannelID,
		ProductFamilyID,
		TNS,
		PLM,
		IRL,
		JPN,
		CZE,
		TNS_U,
		TNSShipOrgID_U,
		TNSDefaultShipping_U,
		PLM_U,
		PLMShipOrgID_U,
		PLMDefaultShipping_U,
		IRL_U,
		IRLShipOrgID_U,
		IRLDefaultShipping_U,
		PPC_U,
		PPCShipOrgID_U,
		PPCDefaultShipping_U,
		NDC_U,
		NDCShipOrgID_U,
		NDCDefaultShipping_U,
		SAN_U,
		SANShipOrgID_U,
		SANDefaultShipping_U,
		ZCA_U,
		ZCAShipOrgID_U,
		ZCADefaultShipping_U,
		ZPP_U,
		ZPPShipOrgID_U,
		ZPPDefaultShipping_U,
		ZAT_U,
		ZATShipOrgID_U,
		ZATDefaultShipping_U,
		GER_U,
		GERShipOrgID_U,
		GERDefaultShipping_U,
		CZE_U,
		CZEShipOrgID_U,
		CZEDefaultShipping_U,
		JPN_U,
		JPNShipOrgID_U,
		JPNDefaultShipping_U
	)
select	m.ProductID,
		m.OracleID,
		m.ProdFamily,
		m.Channel,
		m.ChannelID,
		m.ProductFamilyID,
		m.TNS,
		m.PLM,
		m.IRL,
		m.JPN,
		m.CZE,
		0 as TNS_U,
		'' as TNSShipOrgID_U,
		'' as TNSDefaultShipping_U,
		0 as PLM_U,
		'' as PLMShipOrgID_U,
		'' as PLMDefaultShipping_U,
		0 as IRL_U,
		'' as IRLShipOrgID_U,
		'' as IRLDefaultShipping_U,
		0 as PPC_U,
		'' as PPChipOrgID_U,
		'' as PPCDefaultShipping_U,
		0 as NDC_U,
		'' as NDCShipOrgID_U,
		'' as NDCDefaultShipping_U,
		0 as SAN_U,
		'' as SANShipOrgID_U,
		'' as SANDefaultShipping_U,
		0 as ZCA_U,
		'' as ZCAShipOrgID_U,
		'' as ZCADefaultShipping_U,
		0 as ZPP_U,
		'' as ZPPShipOrgID_U,
		'' as ZPPDefaultShipping_U,
		0 as ZAT_U,
		'' as ZATShipOrgID_U,
		'' as ZATDefaultShipping_U,
		0 as GER_U,
		'' as GERShipOrgID_U,
		'' as GERDefaultShipping_U,
		0 as CZE_U,
		'' as CZEShipOrgID_U,
		'' as CZEDefaultShipping_U,
		0 as JPN_U,
		'' as JPNShipOrgID_U,
		'' as JPNDefaultShipping_U
from
	(
		select	ps.ProductID,
				ps.[NEW_NPC_ITEM_NUM] as OracleID,
				--ps.OracleDesc,
				ps.ProdFamily,
				--ps.DistChannel,
				dc.Channel,
				dc.ID as ChannelID,
				ps.ProductFamilyID,
				case
					when isnull(pfc.TNS,0) > 0
						then 1
					else
						0
				end TNS,
				case
					when isnull(pfc.PLM,0) > 0
						then 1
					else
						0
				end PLM,
				case
					when isnull(pfc.IRL,0) > 0
						then 1
					else
						0
				end IRL,
				case
					when isnull(pfc.JPN,0) > 0
						then 1
					else
						0
				end JPN,
				case
					when isnull(pfc.CZE,0) > 0
						then 1
					else
						0
				end CZE
		from #ProductSKU ps
			join DistributionChannels dc
				on ps.DistChannel like '%' + dc.Channel + '%'
			join ProductFamilyChannels pfc
				on ps.ProductID = pfc.ProductID
					and ps.ProductFamilyID = pfc.ProductFamilyID
					and dc.ID = pfc.ChannelID
					and ISNULL(ps.ProdFamily,'') <> ''
		where isnull(ps.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
			and ps.TypeValue = 'Sku'
			and ps.NEW_NPC_ITEM_NUM not like 'VDS%'
			and ps.NEW_NPC_ITEM_NUM not like 'VEN%'
	) m



-- TNS
update m
set m.TNS_U = o.Tns,
	m.TNSShipOrgID_U = o.TnsShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Tns,0) > 0
	and m.TNS_U = 0
	
update m
set m.PLM_U = o.Plm,
	m.PLMShipOrgID_U = o.PlmShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Plm,0) > 0
	and m.PLM_U = 0
	
update m
set m.IRL_U = o.Irl,
	m.IRLShipOrgID_U = o.IrlShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Irl,0) > 0
	and m.IRL_U = 0
	
update m
set m.PPC_U = o.Ppc,
	m.PPCShipOrgID_U = o.PpcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Ppc,0) > 0
	and m.PPC_U = 0
	
update m
set m.NDC_U = o.Ndc,
	m.NDCShipOrgID_U = o.NdcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Ndc,0) > 0
	and m.NDC_U = 0
	
update m
set m.SAN_U = o.San,
	m.SANShipOrgID_U = o.SanShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.San,0) > 0
	and m.SAN_U = 0
	
update m
set m.ZCA_U = o.Zca,
	m.ZCAShipOrgID_U = o.ZcaShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Zca,0) > 0
	and m.ZCA_U = 0
	
update m
set m.ZPP_U = o.Zpp,
	m.ZPPShipOrgID_U = o.ZppShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Zpp,0) > 0
	and m.ZPP_U = 0
	
update m
set m.ZAT_U = o.Zat,
	m.ZATShipOrgID_U = o.ZatShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Zat,0) > 0
	and m.ZAT_U = 0
	
update m
set m.GER_U = o.Ger,
	m.GERShipOrgID_U = o.GerShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Ger,0) > 0
	and m.GER_U = 0
	
	
update m
set m.CZE_U = o.Cze,
	m.CZEShipOrgID_U = o.CzeShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Cze,0) > 0
	and m.CZE_U = 0
	
	
update m
set m.JPN_U = o.Jpn,
	m.JPNShipOrgID_U = o.JpnShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.TNS = o.OrgTns
			and m.TNS > 0
where isnull(o.Jpn,0) > 0
	and m.JPN_U = 0



-- PLM
update m
set m.TNS_U = o.Tns,
	m.TNSShipOrgID_U = o.TnsShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Tns,0) > 0
	and m.TNS_U = 0

update m
set m.PLM_U = o.Plm,
	m.PLMShipOrgID_U = o.PlmShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Plm,0) > 0
	and m.PLM_U = 0

update m
set m.IRL_U = o.Irl,
	m.IRLShipOrgID_U = o.IrlShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Irl,0) > 0
	and m.IRL_U = 0
	
update m
set m.PPC_U = o.Ppc,
	m.PPCShipOrgID_U = o.PpcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Ppc,0) > 0
	and m.PPC_U = 0
	
update m
set m.NDC_U = o.Ndc,
	m.NDCShipOrgID_U = o.NdcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Ndc,0) > 0
	and m.NDC_U = 0
	
update m
set m.SAN_U = o.San,
	m.SANShipOrgID_U = o.SanShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.San,0) > 0
	and m.SAN_U = 0
	
update m
set m.ZCA_U = o.Zca,
	m.ZCAShipOrgID_U = o.ZcaShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Zca,0) > 0
	and m.ZCA_U = 0
	
update m
set m.ZPP_U = o.Zpp,
	m.ZPPShipOrgID_U = o.ZppShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Zpp,0) > 0
	and m.ZPP_U = 0
	
update m
set m.ZAT_U = o.Zat,
	m.ZATShipOrgID_U = o.ZatShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Zat,0) > 0
	and m.ZAT_U = 0
	
update m
set m.GER_U = o.Ger,
	m.GERShipOrgID_U = o.GerShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Ger,0) > 0
	and m.GER_U = 0
	
	
update m
set m.CZE_U = o.Cze,
	m.CZEShipOrgID_U = o.CzeShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Cze,0) > 0
	and m.CZE_U = 0
	
	
update m
set m.JPN_U = o.Jpn,
	m.JPNShipOrgID_U = o.JpnShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.PLM = o.OrgPlm
			and m.PLM > 0
where isnull(o.Jpn,0) > 0
	and m.JPN_U = 0
	
	
-- IRL
update m
set m.TNS_U = o.Tns,
	m.TNSShipOrgID_U = o.TnsShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Tns,0) > 0
	and m.TNS_U = 0

update m
set m.PLM_U = o.Plm,
	m.PLMShipOrgID_U = o.PlmShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Plm,0) > 0
	and m.PLM_U = 0

update m
set m.IRL_U = o.Irl,
	m.IRLShipOrgID_U = o.IrlShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Irl,0) > 0
	and m.IRL_U = 0
	
update m
set m.PPC_U = o.Ppc,
	m.PPCShipOrgID_U = o.PpcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Ppc,0) > 0
	and m.PPC_U = 0
	
update m
set m.NDC_U = o.Ndc,
	m.NDCShipOrgID_U = o.NdcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Ndc,0) > 0
	and m.NDC_U = 0
	
update m
set m.SAN_U = o.San,
	m.SANShipOrgID_U = o.SanShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.San,0) > 0
	and m.SAN_U = 0
	
update m
set m.ZCA_U = o.Zca,
	m.ZCAShipOrgID_U = o.ZcaShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Zca,0) > 0
	and m.ZCA_U = 0
	
update m
set m.ZPP_U = o.Zpp,
	m.ZPPShipOrgID_U = o.ZppShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Zpp,0) > 0
	and m.ZPP_U = 0
	
update m
set m.ZAT_U = o.Zat,
	m.ZATShipOrgID_U = o.ZatShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Zat,0) > 0
	and m.ZAT_U = 0
	
update m
set m.GER_U = o.Ger,
	m.GERShipOrgID_U = o.GerShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Ger,0) > 0
	and m.GER_U = 0
	

update m
set m.CZE_U = o.Cze,
	m.CZEShipOrgID_U = o.CzeShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Cze,0) > 0
	and m.CZE_U = 0
	
	
update m
set m.JPN_U = o.Jpn,
	m.JPNShipOrgID_U = o.JpnShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.IRL = o.OrgIrl
			and m.IRL > 0
where isnull(o.Jpn,0) > 0
	and m.JPN_U = 0
	
	
-- JPN
update m
set m.TNS_U = o.Tns,
	m.TNSShipOrgID_U = o.TnsShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Tns,0) > 0
	and m.TNS_U = 0

update m
set m.PLM_U = o.Plm,
	m.PLMShipOrgID_U = o.PlmShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Plm,0) > 0
	and m.PLM_U = 0

update m
set m.IRL_U = o.Irl,
	m.IRLShipOrgID_U = o.IrlShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Irl,0) > 0
	and m.IRL_U = 0
	
update m
set m.PPC_U = o.Ppc,
	m.PPCShipOrgID_U = o.PpcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Ppc,0) > 0
	and m.PPC_U = 0
	
update m
set m.NDC_U = o.Ndc,
	m.NDCShipOrgID_U = o.NdcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Ndc,0) > 0
	and m.NDC_U = 0
	
update m
set m.SAN_U = o.San,
	m.SANShipOrgID_U = o.SanShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.San,0) > 0
	and m.SAN_U = 0
	
update m
set m.ZCA_U = o.Zca,
	m.ZCAShipOrgID_U = o.ZcaShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Zca,0) > 0
	and m.ZCA_U = 0
	
update m
set m.ZPP_U = o.Zpp,
	m.ZPPShipOrgID_U = o.ZppShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Zpp,0) > 0
	and m.ZPP_U = 0
	
update m
set m.ZAT_U = o.Zat,
	m.ZATShipOrgID_U = o.ZatShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Zat,0) > 0
	and m.ZAT_U = 0
	
update m
set m.GER_U = o.Ger,
	m.GERShipOrgID_U = o.GerShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Ger,0) > 0
	and m.GER_U = 0
	
	
update m
set m.CZE_U = o.Cze,
	m.CZEShipOrgID_U = o.CzeShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Cze,0) > 0
	and m.CZE_U = 0
	
	
update m
set m.JPN_U = o.Jpn,
	m.JPNShipOrgID_U = o.JpnShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.JPN = o.OrgJpn
			and m.JPN > 0
where isnull(o.Jpn,0) > 0
	and m.JPN_U = 0
	
	
	
-- CZE
update m
set m.TNS_U = o.Tns,
	m.TNSShipOrgID_U = o.TnsShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Tns,0) > 0
	and m.TNS_U = 0

update m
set m.PLM_U = o.Plm,
	m.PLMShipOrgID_U = o.PlmShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Plm,0) > 0
	and m.PLM_U = 0

update m
set m.IRL_U = o.Irl,
	m.IRLShipOrgID_U = o.IrlShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Irl,0) > 0
	and m.IRL_U = 0
	
update m
set m.PPC_U = o.Ppc,
	m.PPCShipOrgID_U = o.PpcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Ppc,0) > 0
	and m.PPC_U = 0
	
update m
set m.NDC_U = o.Ndc,
	m.NDCShipOrgID_U = o.NdcShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Ndc,0) > 0
	and m.NDC_U = 0
	
update m
set m.SAN_U = o.San,
	m.SANShipOrgID_U = o.SanShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.San,0) > 0
	and m.SAN_U = 0
	
update m
set m.ZCA_U = o.Zca,
	m.ZCAShipOrgID_U = o.ZcaShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Zca,0) > 0
	and m.ZCA_U = 0
	
update m
set m.ZPP_U = o.Zpp,
	m.ZPPShipOrgID_U = o.ZppShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Zpp,0) > 0
	and m.ZPP_U = 0
	
update m
set m.ZAT_U = o.Zat,
	m.ZATShipOrgID_U = o.ZatShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Zat,0) > 0
	and m.ZAT_U = 0
	
update m
set m.GER_U = o.Ger,
	m.GERShipOrgID_U = o.GerShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Ger,0) > 0
	and m.GER_U = 0
	
	
update m
set m.CZE_U = o.Cze,
	m.CZEShipOrgID_U = o.CzeShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Cze,0) > 0
	and m.CZE_U = 0
	
	
update m
set m.JPN_U = o.Jpn,
	m.JPNShipOrgID_U = o.JpnShippingOrgId
from #ShipDefaultHolder m
	join OrgToShipOrgAssignments o
		on m.ChannelID = o.ChannelId
			and m.CZE = o.OrgCze
			and m.CZE > 0
where isnull(o.Jpn,0) > 0
	and m.JPN_U = 0
	


-- Default ShipOrg Update
-- TNS
update m
set m.TNSDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on m.TNSShipOrgID_U = o.ID
where isnull(TNSShipOrgID_U,0) > 0

-- PLM
update m
set m.PLMDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.PLMShipOrgID_U,0) = o.ID
where isnull(PLMShipOrgID_U,0) > 0

-- IRL
update m
set m.IRLDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.IRLShipOrgID_U,0) = o.ID
where isnull(IRLShipOrgID_U,0) > 0

-- PPC
update m
set m.PPCDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.PPCShipOrgID_U,0) = o.ID
where isnull(PPCShipOrgID_U,0) > 0

-- NDC
update m
set m.NDCDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.NDCShipOrgID_U,0) = o.ID
where isnull(NDCShipOrgID_U,0) > 0

-- SAN
update m
set m.SANDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.SANShipOrgID_U,0) = o.ID
where isnull(SANShipOrgID_U,0) > 0

-- ZCA
update m
set m.ZCADefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.ZCAShipOrgID_U,0) = o.ID
where isnull(ZCAShipOrgID_U,0) > 0

-- ZPP
update m
set m.ZPPDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.ZPPShipOrgID_U,0) = o.ID
where isnull(ZPPShipOrgID_U,0) > 0

-- ZAT
update m
set m.ZATDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.ZATShipOrgID_U,0) = o.ID
where isnull(ZATShipOrgID_U,0) > 0

-- GER
update m
set m.GERDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.GERShipOrgID_U,0) = o.ID
where isnull(GERShipOrgID_U,0) > 0


-- CZE
update m
set m.CZEDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.CZEShipOrgID_U,0) = o.ID
where isnull(CZEShipOrgID_U,0) > 0


-- JPN
update m
set m.JPNDefaultShipping_U = o.[Description]
from #ShipDefaultHolder m
	join Orgs o
		on isnull(m.JPNShipOrgID_U,0) = o.ID
where isnull(JPNShipOrgID_U,0) > 0



-- Final Update on Org	
-- TNS		
update ps
set ps.TNS = case when sh.TNS_U = 1 then 'Y' else '' end,
	ps.TNS_DEF_SHP_ORG_ID = sh.TNSShipOrgID_U,
	ps.TNS_DEFAULT_SHIPPING = sh.TNSDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.TNS_U,0) > 0 
	and isnull(ps.TNS,'') = ''

-- PLM	
update ps
set ps.PLM = case when sh.PLM_U = 1 then 'Y' else '' end,
	ps.PLM_DEF_SHP_ORG_ID = sh.PLMShipOrgID_U,
	ps.PLM_DEFAULT_SHIPPING = sh.PLMDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.PLM_U,0) > 0 
	and isnull(ps.PLM,'') = ''

-- IRL	
update ps
set ps.IRL = case when sh.IRL_U = 1 then 'Y' else '' end,
	ps.IRL_DEF_SHP_ORG_ID = sh.IRLShipOrgID_U,
	ps.IRL_DEFAULT_SHIPPING = sh.IRLDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.IRL_U,0) > 0 
	and isnull(ps.IRL,'') = ''

-- PPC
update ps
set ps.PPC = case when sh.PPC_U = 1 then 'Y' else '' end,
	ps.PPC_DEF_SHP_ORG_ID = sh.PPCShipOrgID_U,
	ps.PPC_DEFAULT_SHIPPING = sh.PPCDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.PPC_U,0) > 0 
	and isnull(ps.PPC,'') = ''

-- NDC
update ps
set ps.NDC = case when sh.NDC_U = 1 then 'Y' else '' end,
	ps.NDC_DEF_SHP_ORG_ID = sh.NDCShipOrgID_U,
	ps.NDC_DEFAULT_SHIPPING = sh.NDCDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.NDC_U,0) > 0 
	and isnull(ps.NDC,'') = ''

-- SAN
update ps
set ps.SAN = case when sh.SAN_U = 1 then 'Y' else '' end,
	ps.SAN_DEF_SHP_ORG_ID = sh.SANShipOrgID_U,
	ps.SAN_DEFAULT_SHIPPING = sh.SANDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.SAN_U,0) > 0 		
	and isnull(ps.SAN,'') = ''

-- ZCA
update ps
set ps.ZCA = case when sh.ZCA_U = 1 then 'Y' else '' end,
	ps.ZCA_DEF_SHP_ORG_ID = sh.ZCAShipOrgID_U,
	ps.ZCA_DEFAULT_SHIPPING = sh.ZCADefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.ZCA_U,0) > 0
	and isnull(ps.ZCA,'') = ''

-- ZPP
update ps
set ps.ZPP = case when sh.ZPP_U = 1 then 'Y' else '' end,
	ps.ZPP_DEF_SHP_ORG_ID = sh.ZPPShipOrgID_U,
	ps.ZPP_DEFAULT_SHIPPING = sh.ZPPDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.ZPP_U,0) > 0 	
	and isnull(ps.ZPP,'') = ''

-- ZAT
update ps
set ps.ZAT = case when sh.ZAT_U = 1 then 'Y' else '' end,
	ps.ZAT_DEF_SHP_ORG_ID = sh.ZATShipOrgID_U,
	ps.ZAT_DEFAULT_SHIPPING = sh.ZATDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.ZAT_U,0) > 0 	
	and isnull(ps.ZAT,'') = ''

-- GER
update ps
set ps.GER = case when sh.GER_U = 1 then 'Y' else '' end,
	ps.GER_DEF_SHP_ORG_ID = sh.GERShipOrgID_U,
	ps.GER_DEFAULT_SHIPPING = sh.GERDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.GER_U,0) > 0 	
	and isnull(ps.GER,'') = ''
	
	
-- CZE
update ps
set ps.CZE = case when sh.CZE_U = 1 then 'Y' else '' end,
	ps.CZE_DEF_SHP_ORG_ID = sh.CZEShipOrgID_U,
	ps.CZE_DEFAULT_SHIPPING = sh.CZEDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.CZE_U,0) > 0 	
	and isnull(ps.CZE,'') = ''
	
	
-- JPN
update ps
set ps.JPN = case when sh.JPN_U = 1 then 'Y' else '' end,
	ps.JPN_DEF_SHP_ORG_ID = sh.JPNShipOrgID_U,
	ps.JPN_DEFAULT_SHIPPING = sh.JPNDefaultShipping_U
from #ProductSKU ps
	join #ShipDefaultHolder sh
		on ps.ProductID = sh.ProductID
			and ps.NEW_NPC_ITEM_NUM = sh.OracleID
			and ps.ProductFamilyID = sh.ProductFamilyID
			and ps.DistChannel like '%' + sh.Channel + '%'
where isnull(sh.JPN_U,0) > 0 	
	and isnull(ps.JPN,'') = ''


-- Update Org End



-- Added this for Sample Only

 --TNS
update t
set t.TNS = 'Y',
	t.TNS_DEFAULT_SHIPPING = so.[Description]
from #ProductSKU t
	join Orgs so
		on so.Org = 'TNS'
where isnull(t.SALES_ACCOUNT,'') = '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'


 --PLM
update t
set t.PLM = 'Y',
	t.PLM_DEFAULT_SHIPPING = so.[Description]
from #ProductSKU t
	join Orgs so
		on so.Org = 'PLM'
where isnull(t.SALES_ACCOUNT,'') = '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'


 --IRL
update t
set t.IRL = 'Y',
	t.IRL_DEFAULT_SHIPPING = so.[Description]
from #ProductSKU t
	join Orgs so
		on so.Org = 'IRL'
where isnull(t.SALES_ACCOUNT,'') = '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'


 --GER
update t
set t.GER = 'Y',
	t.GER_DEFAULT_SHIPPING = 'Germany'
from #ProductSKU t
where isnull(t.SALES_ACCOUNT,'') = '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
	
	
 --CZE
update t
set t.CZE = 'Y',
	t.CZE_DEFAULT_SHIPPING = 'Czech Republic'
from #ProductSKU t
where isnull(t.SALES_ACCOUNT,'') = '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
	
	
 --JPN
update t
set t.JPN = 'Y',
	t.JPN_DEFAULT_SHIPPING = 'Kisarazu'
from #ProductSKU t
where isnull(t.SALES_ACCOUNT,'') = '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'


-- End Sample





if exists	(
				select * 
				from #ProductSKU
				where	(
							ISNULL(PRODUCT_CODE,'') = ''
							or
							ISNULL(MASTER_ITEM_TEMPLATE,'') = ''
							or
							ISNULL(COST_OF_GOODS_ACCOUNT,'') = ''
							or
							ISNULL(SALES_ACCOUNT,'') = ''
							or
							ISNULL(CATALOG_SEGMENT1,'') = ''
							or
							ISNULL(CATEGORY_INV,'') = ''
							or
							ISNULL([DESCRIPTION],'') = ''
						)
					and TypeValue = 'Sku'
			)
begin
	select @ExtractCompleted = '4'
end
else
begin
	select @ExtractCompleted = '3'
end


if exists	(
				select top 1 *
				from
					(
						select	TNS	as OrgEnable,
								TNS_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	PLM	as OrgEnable,
								PLM_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	IRL	as OrgEnable,
								IRL_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	PPC	as OrgEnable,
								PPC_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	NDC	as OrgEnable,
								NDC_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	SAN	as OrgEnable,
								SAN_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	ZCA	as OrgEnable,
								ZCA_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	ZPP	as OrgEnable,
								ZPP_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	ZAT	as OrgEnable,
								ZAT_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	GER	as OrgEnable,
								GER_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	CZE	as OrgEnable,
								CZE_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
						union
						select	JPN	as OrgEnable,
								JPN_DEFAULT_SHIPPING as ShipOrg
						from #ProductSKU
						where TypeValue = 'Sku'
					) z
				where ISNULL(OrgEnable,'') <> '' 
					and ISNULL(ShipOrg,'') <> ''
			)
begin
	select @ExtractCompleted = '3'
end
else
begin
	select @ExtractCompleted = '4'
end


if exists	(
				select	top 1 *
				from #ProductSKU
					where TypeValue = 'Sku' and PRODUCT_CODE not in
						(
							select	PRODUCT_CODE	
							from #ProductSKU
							where TypeValue = 'Sku' and ISNULL(NEW_NPC_ITEM_NUM,'') <> ''
							group by PRODUCT_CODE
						)
			)
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '4'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '8'
	end
end
else
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '3'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '7'
	end
end


-- Check Component
if @BatchStatus = 6
begin

-- Step-1: Check if the duplicate rows has all the values and consider the highest LIST_PRICE.
	;with CTE as (Select *, Row_number()Over(Partition by ProductID, NEW_NPC_ITEM_NUM Order by LIST_PRICE Desc) Seq
					from #ProductSKU
					where TypeValue = 'Component'
					and (
								ISNULL([Description],'') <> ''
								or
								ISNULL(UNIT_OF_MEASURE,'') <> ''
								or
								ISNULL(CATEGORY_INV,'') <> ''
								or
								ISNULL(DEFAULT_BUYER,'') <> ''
								or
								LIST_PRICE is not null
							)
				 )
				 Delete from CTE where Seq > 1

	-- Step-2: Consider highest LIST_PRICE rows from duplicates where any of the columns doesn't have the values.
	;with CTE as (Select *, Row_number()Over(Partition by ProductID, NEW_NPC_ITEM_NUM Order by LIST_PRICE Desc) Seq
					from #ProductSKU
					where TypeValue = 'Component'
					and (
								ISNULL([Description],'') = ''
								or
								ISNULL(UNIT_OF_MEASURE,'') = ''
								or
								ISNULL(CATEGORY_INV,'') = ''
								or
								ISNULL(DEFAULT_BUYER,'') = ''
								or
								LIST_PRICE is null
							)
				 )
				 Delete from CTE where Seq > 1

	if exists	(
					select *
					from #ProductSKU
					where TypeValue = 'Component'
						and (
								ISNULL([Description],'') = ''
								or
								ISNULL(UNIT_OF_MEASURE,'') = ''
								or
								ISNULL(CATEGORY_INV,'') = ''
								or
								ISNULL(DEFAULT_BUYER,'') = ''
								or
								LIST_PRICE is null
							)
				)
		begin
			select @ExtractCompleted = '8'
		end
		else
		begin
			select @ExtractCompleted = '7'
		end
end


if @BatchStatus = 6
begin
	if exists	(
					select NEW_NPC_ITEM_NUM
					from #ProductSKU
					where TypeValue = 'Component'
					group by NEW_NPC_ITEM_NUM
					having COUNT(*) > 1
				)
		begin
			select @ExtractCompleted = '8'
		end
end




insert PIM_ETL_STAGE.dbo.Stage_OracleSKUForExport
(
   [NEW_NPC_ITEM_NUM]
  ,[DESCRIPTION]
  ,[TARRIFF]
  ,[PROCESS]
  ,[COMMISSION_KEY]
  ,[ROYALTY_CODE]
  ,[ROYALTY_SUBCODE]
  ,[AVAILABLE_FOR_SALES_ORDER]
  ,[TNS]
  ,[TNS_DEFAULT_SHIPPING]
  ,[PLM]
  ,[PLM_DEFAULT_SHIPPING]
  ,[IRL]
  ,[IRL_DEFAULT_SHIPPING]
  ,[PPC]
  ,[PPC_DEFAULT_SHIPPING]
  ,[NDC]
  ,[NDC_DEFAULT_SHIPPING]
  ,[SAN]
  ,[SAN_DEFAULT_SHIPPING]
  ,[ZCA]
  ,[ZCA_DEFAULT_SHIPPING]
  ,[ZPP]
  ,[ZPP_DEFAULT_SHIPPING]
  ,[ZAT]
  ,[ZAT_DEFAULT_SHIPPING]
  ,[GER]
  ,[GER_DEFAULT_SHIPPING]
  ,[CZE]
  ,[CZE_DEFAULT_SHIPPING]
  ,[JPN]
  ,[JPN_DEFAULT_SHIPPING]
  ,[CATEGORY_PF]
  ,[CATEGORY]
  ,[CATEGORY_INV]
  ,[ITEM_FAMILY]
  ,[ITEM_CLASS]
  ,[COST_OF_GOODS_ACCOUNT]
  ,[SALES_ACCOUNT]
  ,[SUBINVENTORY]
  ,[UNIT_OF_MEASURE]
  ,[MASTER_ITEM_TEMPLATE]
  ,[CATALOG_SEGMENT1]
  ,[CATALOG_SEGMENT2]
  ,[CATALOG_SEGMENT3]
  ,[CATALOG_SEGMENT4]
  ,[PRODUCT_CLASS]
  ,[PRODUCT_GROUPING_CODE]
  ,[PRODUCT_CODE]
  ,[SKU_CATEGORY]
  ,[PACK_SIZE]
  ,[INK_COLOR]
  ,[PRODUCT_COLOR]
  ,[BARREL_TYPE]
  ,[SKU_DESCRIPTION]
  ,[DECORATION_METHOD]
  ,[OTHER]
  ,[PRODUCT_FAMILY]
  ,[ATTRIBUTE1]
  ,[ATTRIBUTE2]
  ,[ATTRIBUTE3]
  ,[ATTRIBUTE4]
  ,[ATTRIBUTE5]
  ,[ATTRIBUTE6]
  ,[ATTRIBUTE7]
  ,[ATTRIBUTE8]
  ,[ATTRIBUTE9]
  ,[ATTRIBUTE10]
  ,[ATTRIBUTE11]
  ,[ATTRIBUTE12]
  ,[ATTRIBUTE13]
  ,[ATTRIBUTE14]
  ,[ATTRIBUTE15]
  ,[INVENTORY_ITEM_ID]
  ,[MASTER_ITEM_TEMPLATE_ID]
  ,[PRIMARY_UOM_CODE]
  ,[WEIGHT_UOM_CODE]
  ,[TNS_DEF_SHP_ORG_ID]
  ,[PLM_DEF_SHP_ORG_ID]
  ,[IRL_DEF_SHP_ORG_ID]
  ,[PPC_DEF_SHP_ORG_ID]
  ,[SAN_DEF_SHP_ORG_ID]
  ,[NDC_DEF_SHP_ORG_ID]
  ,[ZCA_DEF_SHP_ORG_ID]
  ,[ZPP_DEF_SHP_ORG_ID]
  ,[ZAT_DEF_SHP_ORG_ID]
  ,[GER_DEF_SHP_ORG_ID]
  ,[CZE_DEF_SHP_ORG_ID]
  ,[JPN_DEF_SHP_ORG_ID]
  ,[CATEGORY_1_SET_NAME]
  ,[CATEGORY_1_ID]
  ,[CATEGORY_2_SET_NAME]
  ,[CATEGORY_2_ID]
  ,[COST_OF_SALES_CCID]
  ,[SALES_CCID]
  ,[MINIMUM]
  ,[MAXIMUM]
  ,[VALIDATION_FLAG]
  ,[PROCESS_FLAG]
  ,[BatchID]
  ,[PRODUCT_DESCRIPTION]
  ,[SKU_LONG_DESCRIPTION]
  ,[PROP65_CHECK]
  ,[DEFAULT_BUYER]
  ,[LIST_PRICE]
  ,[TypeValue]
)
select 
   [NEW_NPC_ITEM_NUM]
  ,[DESCRIPTION]
  ,[TARRIFF]
  ,[PROCESS]
  ,[COMMISSION_KEY]
  ,[ROYALTY_CODE]
  ,[ROYALTY_SUBCODE]
  ,[AVAILABLE_FOR_SALES_ORDER]
  ,[TNS]
  ,[TNS_DEFAULT_SHIPPING]
  ,[PLM]
  ,[PLM_DEFAULT_SHIPPING]
  ,[IRL]
  ,[IRL_DEFAULT_SHIPPING]
  ,[PPC]
  ,[PPC_DEFAULT_SHIPPING]
  ,[NDC]
  ,[NDC_DEFAULT_SHIPPING]
  ,[SAN]
  ,[SAN_DEFAULT_SHIPPING]
  ,[ZCA]
  ,[ZCA_DEFAULT_SHIPPING]
  ,[ZPP]
  ,[ZPP_DEFAULT_SHIPPING]
  ,[ZAT]
  ,[ZAT_DEFAULT_SHIPPING]
  ,[GER]
  ,[GER_DEFAULT_SHIPPING]
  ,[CZE]
  ,[CZE_DEFAULT_SHIPPING]
  ,[JPN]
  ,[JPN_DEFAULT_SHIPPING]
  ,[CATEGORY_PF]
  ,[CATEGORY]
  ,[CATEGORY_INV]
  ,[ITEM_FAMILY]
  ,[ITEM_CLASS]
  ,[COST_OF_GOODS_ACCOUNT]
  ,[SALES_ACCOUNT]
  ,[SUBINVENTORY]
  ,[UNIT_OF_MEASURE]
  ,[MASTER_ITEM_TEMPLATE]
  ,[CATALOG_SEGMENT1]
  ,[CATALOG_SEGMENT2]
  ,[CATALOG_SEGMENT3]
  ,[CATALOG_SEGMENT4]
  ,[PRODUCT_CLASS]
  ,[PRODUCT_GROUPING_CODE]
  ,[PRODUCT_CODE]
  ,[SKU_CATEGORY]
  ,[PACK_SIZE]
  ,[INK_COLOR]
  ,[PRODUCT_COLOR]
  ,[BARREL_TYPE]
  ,[SKU_DESCRIPTION]
  ,[DECORATION_METHOD]
  ,[OTHER]
  ,[PRODUCT_FAMILY]
  ,[ATTRIBUTE1]
  ,[ATTRIBUTE2]
  ,[ATTRIBUTE3]
  ,[ATTRIBUTE4]
  ,[ATTRIBUTE5]
  ,[ATTRIBUTE6]
  ,[ATTRIBUTE7]
  ,[ATTRIBUTE8]
  ,[ATTRIBUTE9]
  ,[ATTRIBUTE10]
  ,[ATTRIBUTE11]
  ,[ATTRIBUTE12]
  ,[ATTRIBUTE13]
  ,[ATTRIBUTE14]
  ,[ATTRIBUTE15]
  ,[INVENTORY_ITEM_ID]
  ,[MASTER_ITEM_TEMPLATE_ID]
  ,[PRIMARY_UOM_CODE]
  ,[WEIGHT_UOM_CODE]
  ,[TNS_DEF_SHP_ORG_ID]
  ,[PLM_DEF_SHP_ORG_ID]
  ,[IRL_DEF_SHP_ORG_ID]
  ,[PPC_DEF_SHP_ORG_ID]
  ,[SAN_DEF_SHP_ORG_ID]
  ,[NDC_DEF_SHP_ORG_ID]
  ,[ZCA_DEF_SHP_ORG_ID]
  ,[ZPP_DEF_SHP_ORG_ID]
  ,[ZAT_DEF_SHP_ORG_ID]
  ,[GER_DEF_SHP_ORG_ID]
  ,[CZE_DEF_SHP_ORG_ID]
  ,[JPN_DEF_SHP_ORG_ID]
  ,[CATEGORY_1_SET_NAME]
  ,[CATEGORY_1_ID]
  ,[CATEGORY_2_SET_NAME]
  ,[CATEGORY_2_ID]
  ,[COST_OF_SALES_CCID]
  ,[SALES_CCID]
  ,[MINIMUM]
  ,[MAXIMUM]
  ,[VALIDATION_FLAG]
  ,[PROCESS_FLAG] 
  ,@BatchID
  ,[PRODUCT_DESCRIPTION]
  ,[SKU_LONG_DESCRIPTION]
  ,[PROP65_CHECK]
  ,[DEFAULT_BUYER]
  ,[LIST_PRICE]
  ,[TypeValue]
from #ProductSKU
order by UniqueID



























GO
