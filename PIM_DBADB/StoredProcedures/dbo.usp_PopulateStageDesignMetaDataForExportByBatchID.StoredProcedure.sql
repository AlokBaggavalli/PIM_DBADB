CREATE Procedure [dbo].[usp_PopulateStageDesignMetaDataForExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output
	
as

set nocount on

declare @LocaleID				int,
		@Type					varchar(50),
		@MinID					int,
		@BatchStatus			int


set @LocaleID = 12 -- LOCALE=en_US
set @Type = '1'



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
	set @ExtractCompleted = '3'
end

if @BatchStatus = 6
begin
	set @ExtractCompleted = '7'
end



if @BatchStatus = 2
begin
	insert PIM_ETL_STAGE.dbo.Stage_DesignMetadataForExport
		(
			[FileName]
		  ,[ImprintTemplate]
		  ,[ImprintTemplateName]
		  ,[ImprintDesignCode]
		  ,[ImprintFont]
		  ,[ImprintColor]
		  ,[ImprintOrientation]
		  ,[ImprintLineSpacing]
		  ,[ImprintOutline]
		  ,[ImprintOutlineColor]
		  ,[ImprintTextboxWidth]
		  ,[ImprintTextboxHeight]
		  ,[ImprintTextboxXLocationCenter]
		  ,[ImprintTextboxYLocationCenter]
		  ,[ImprintVerticalText]
		  ,[AlphaChannelImprint]
		  ,[AllowColorChoice]
		  ,[PresentationFormat]
		  ,[ProductionFormat]
		  ,[ProductionOutputRes]
		  ,[ProductionOutputColorSpace]
		  ,[ImprintMaxPointSize]
		  ,[ImprintTextRotation]
		)
	select	[FileName],
			Template as ImprintTemplate,
			TempName as ImprintTemplateName,
			ImpDesignCode as ImprintDesignCode,
			Font as ImprintFont,
			Color as ImprintColor,
			Orient as ImprintOrientation,
			LineSpace as ImprintLineSpacing,
			Outline as ImprintOutline,
			OutlineColor as ImprintOutlineColor,
			TextboxWidth as ImprintTextboxWidth,
			TexboxHeight as ImprintTextboxHeight,
			TextboxXLoc as ImprintTextboxXLocationCenter,
			TextboxYLoc as ImprintTextboxYLocationCenter,
			VerticalText as ImprintVerticalText,
			AlphaChannel as AlphaChannelImprint,
			AllowColor as AllowColorChoice,
			PresFormat as PresentationFormat,
			ProdFormat as ProductionFormat,
			ProdOutputRes as ProductionOutputRes,
			ProdOutputColor as ProductionOutputColorSpace,
			ImpMaxPoint as ImprintMaxPointSize,
			TextRotation as ImprintTextRotation
	from dbo.Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.ProductDesigns pd
			on pd.ProductID = p.ID
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
	where be.[Status] = '2'
		and be.ID = @MinID
	order by p.ID
end


if @BatchStatus = 6
begin
	insert PIM_ETL_STAGE.dbo.Stage_DesignMetadataForExport
		(
			[FileName]
		  ,[ImprintTemplate]
		  ,[ImprintTemplateName]
		  ,[ImprintDesignCode]
		  ,[ImprintFont]
		  ,[ImprintColor]
		  ,[ImprintOrientation]
		  ,[ImprintLineSpacing]
		  ,[ImprintOutline]
		  ,[ImprintOutlineColor]
		  ,[ImprintTextboxWidth]
		  ,[ImprintTextboxHeight]
		  ,[ImprintTextboxXLocationCenter]
		  ,[ImprintTextboxYLocationCenter]
		  ,[ImprintVerticalText]
		  ,[AlphaChannelImprint]
		  ,[AllowColorChoice]
		  ,[PresentationFormat]
		  ,[ProductionFormat]
		  ,[ProductionOutputRes]
		  ,[ProductionOutputColorSpace]
		  ,[ImprintMaxPointSize]
		  ,[ImprintTextRotation]
		)
	select	[FileName],
			Template as ImprintTemplate,
			TempName as ImprintTemplateName,
			ImpDesignCode as ImprintDesignCode,
			Font as ImprintFont,
			Color as ImprintColor,
			Orient as ImprintOrientation,
			LineSpace as ImprintLineSpacing,
			Outline as ImprintOutline,
			OutlineColor as ImprintOutlineColor,
			TextboxWidth as ImprintTextboxWidth,
			TexboxHeight as ImprintTextboxHeight,
			TextboxXLoc as ImprintTextboxXLocationCenter,
			TextboxYLoc as ImprintTextboxYLocationCenter,
			VerticalText as ImprintVerticalText,
			AlphaChannel as AlphaChannelImprint,
			AllowColor as AllowColorChoice,
			PresFormat as PresentationFormat,
			ProdFormat as ProductionFormat,
			ProdOutputRes as ProductionOutputRes,
			ProdOutputColor as ProductionOutputColorSpace,
			ImpMaxPoint as ImprintMaxPointSize,
			TextRotation as ImprintTextRotation
	from dbo.Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.ProductDesigns pd
			on pd.ProductID = p.ID
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[DesignID] = pd.ID
	where be.[Status] = '6'
		and be.ID = @MinID
	order by p.ID
end




GO
