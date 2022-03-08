CREATE Procedure [dbo].[usp_PopulateStageOracleSKUForExportByBatchID_Test]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output
as

set nocount on


declare @LocaleID			int,
		@Type				varchar(50),
		@MinID				int,
		@BatchStatus		int


						
						
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
								[TypeValue]						[nvarchar](50) NULL
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
			[TypeValue]	
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
			'Sku' as TypeValue
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
			[TypeValue]
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
			bep.Value as TypeValue
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
			bep.Value as TypeValue
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






 --Update Org Start
 --TNS
update t
set t.TNS = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.TNS_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'TNS'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'







-- PLM
update t
set t.PLM = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.PLM_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'PLM'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
		
		
		
-- IRL
update t
set t.IRL = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.IRL_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'IRL'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
		
		
		
-- PPC
update t
set t.PPC = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.PPC_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'PPC'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
		
	
		
-- NDC
update t
set t.NDC = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.NDC_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'NDC'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
		
		
		
-- SAN
update t
set t.SAN = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.SAN_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'SAN'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
	
		
		
-- ZCA
update t
set t.ZCA = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.ZCA_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'ZCA'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
		
		
		
-- ZPP
update t
set t.ZPP = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.ZPP_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'ZPP'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
		
		
		
-- ZAT
update t
set t.ZAT = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.ZAT_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'ZAT'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'
		
		
		
-- GER
update t
set t.GER = Case
				when isnull(pso.[Active],0) = 1
					then 'Y'
				else
					''
			End,
	t.GER_DEFAULT_SHIPPING = Case
								when (isnull(pso.[ShipOrgID],0) <> 0 and isnull(pso.[Active],0) = 1)
									then so.[Description]
								else
									''
							End
from #ProductSKU t
	join ProductShipOrgs pso
		on t.ProductID = pso.ProductID
	left join Orgs o
		on pso.OrgID = o.ID
	left join Orgs so
		on pso.ShipOrgID = so.ID
where o.Org = 'GER'
	and isnull(t.SALES_ACCOUNT,'') <> '1110-00-000-CA-0000'
	and t.TypeValue = 'Sku'

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
	t.GER_DEFAULT_SHIPPING = so.[Description]
from #ProductSKU t
	join Orgs so
		on so.Org = 'GER'
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




insert Stage_OracleSKUForExport
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
