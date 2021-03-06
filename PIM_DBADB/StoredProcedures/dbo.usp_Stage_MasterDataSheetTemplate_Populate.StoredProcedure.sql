Create Procedure [dbo].[usp_Stage_MasterDataSheetTemplate_Populate]

as   



set nocount on

truncate table PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate

insert PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate(BatchID)
select ToolTip from MasterDataSheetColumns where ColumnName = 'BatchID'

-- Internal Comments
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Internal Comments] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Internal Comments'

-- Sold To Countries
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Sold To Countries] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Sold To Countries'

-- NP Product Code
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NP Product Code] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NP Product Code'

-- MCP Product Ref ID
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [MCP Product Ref ID] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'MCP Product Ref ID'

-- MCP SKU ID
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [MCP SKU ID] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'MCP SKU ID'

-- SKU Format
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [SKU Format] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'SKU Format'

-- NP Product SKUs
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NP Product SKUs] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NP Product SKUs'

-- NP SKU Description
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NP SKU Description] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NP SKU Description'

-- NP Virtual Sku (NP Web Code)
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NP Virtual Sku (NP Web Code)] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NP Virtual Sku (NP Web Code)'

-- Supplier Name
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Supplier Name] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Supplier Name'

-- Supplier ASI #
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Supplier ASI #] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Supplier ASI #'

-- Supplier Item #
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Supplier Item #] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Supplier Item #'

-- Supplier Product Sku
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Supplier Product Sku] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Supplier Product Sku'

-- Supplier Product Name
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Supplier Product Name] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Supplier Product Name'

-- Long Description
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Long Description] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Long Description'

-- Web Search Words
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Web Search Words] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Web Search Words'

-- Supplier Product Sku Description
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Supplier Product Sku Description] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Supplier Product Sku Description'

-- Product Link
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Link] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Link'

-- Category (Product Family)
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Category (Product Family)] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Category (Product Family)'

-- Subcategory
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Subcategory] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Subcategory'

-- Oracle Catalog Level 1
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Oracle Catalog Level 1] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Oracle Catalog Level 1'

-- Oracle Catalog Level 2
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Oracle Catalog Level 2] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Oracle Catalog Level 2'

-- Material
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Material] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Material'

-- Product Size: WIDTH
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Size: WIDTH] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Size: WIDTH'

-- Product Size: HEIGHT
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Size: HEIGHT] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Size: HEIGHT'

-- Product Size: DEPTH
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Size: DEPTH] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Size: DEPTH'

-- Product Size: UOM
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Size: UOM] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Size: UOM'

-- Product Size: Comments
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Size: Comments] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Size: Comments'

-- Capacity
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Capacity] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Capacity'

-- Capacity UOM
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Capacity UOM] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Capacity UOM'

-- Size
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Size] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Size'

-- Brand name
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Brand name] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Brand name'

-- Country of Origin
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Country of Origin] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Country of Origin'

-- Freight: Qty Per Box
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Freight: Qty Per Box] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Freight: Qty Per Box'

-- Freight: Box Weight
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Freight: Box Weight] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Freight: Box Weight'

-- Freight: Box Weight UOM
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Freight: Box Weight UOM] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Freight: Box Weight UOM'

-- Product Weight
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Weight] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Weight'

-- Product Weight: UOM
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Weight: UOM] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Weight: UOM'

-- TAT Min
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [TAT Min] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'TAT Min'

-- TAT Max
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [TAT Max] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'TAT Max'

-- Countries Eligible
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Countries Eligible] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Countries Eligible'

-- Image Path
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Image Path] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Image Path'

-- Product Video Link
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Product Video Link] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Product Video Link'

-- Attribute 1 Name
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 1 Name] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 1 Name'

-- Attribute 1 Options
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 1 Options] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 1 Options'

-- Attribute 1: Color Hex Values
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 1: Color Hex Values] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 1: Color Hex Values'

-- Attribute 2 Name
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 2 Name] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 2 Name'

-- Attribute 2 Options
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 2 Options] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 2 Options'

-- Attribute 2: Color Hex Values
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 2: Color Hex Values] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 2: Color Hex Values'

-- Attribute 3 Name
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 3 Name] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 3 Name'

-- Attribute 3 Options
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 3 Options] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 3 Options'

-- Attribute 3: Color Hex Values
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Attribute 3: Color Hex Values] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Attribute 3: Color Hex Values'

-- Refill Type
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Refill Type] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Refill Type'

-- Point Type
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Point Type] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Point Type'

-- Ink Type
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Ink Type] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Ink Type'

-- Ink Color
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Ink Color] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Ink Color'

-- Ink: Color Hex Values
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Ink: Color Hex Values] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Ink: Color Hex Values'

-- Art Template Path
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Art Template Path] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Art Template Path'

-- Imprint Area 1: Imprint Method
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1: Imprint Method] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1: Imprint Method'

-- Imprint Area 1: Location
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1: Location] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1: Location'

-- Imprint Area 1 Size: WIDTH
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1 Size: WIDTH] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1 Size: WIDTH'

-- Imprint Area 1 Size: HEIGHT
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1 Size: HEIGHT] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1 Size: HEIGHT'

-- Imprint Area 1 Size: UOM
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1 Size: UOM] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1 Size: UOM'

-- Imprint Area 1: Included STD Colors
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1: Included STD Colors] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1: Included STD Colors'

-- Imprint Area 1: Max Colors
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1: Max Colors] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1: Max Colors'

-- Imprint Area 1: Color Options
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1: Color Options] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1: Color Options'

-- Imprint Area 1: Color Hex Values
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 1: Color Hex Values] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 1: Color Hex Values'

-- Imprint Area 2: Imprint Method
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 2: Imprint Method] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 2: Imprint Method'

-- Imprint Area 2: Location
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 2: Location] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 2: Location'

-- Imprint Area 2 Size: WIDTH
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 2 Size: WIDTH] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 2 Size: WIDTH'

-- Imprint Area 2 Size: HEIGHT
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 2 Size: HEIGHT] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 2 Size: HEIGHT'

-- Imprint Area 2 Size: UOM
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Imprint Area 2 Size: UOM] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Imprint Area 2 Size: UOM'

-- Currency
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Currency] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Currency'

-- Standard Catalog MOQ
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Standard Catalog MOQ] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Standard Catalog MOQ'

-- Net Item Cost at Catalog MOQ
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Net Item Cost at Catalog MOQ] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Net Item Cost at Catalog MOQ'

-- NPC Quote: Quantity 1
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Quantity 1] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Quantity 1'

-- NPC Quote: Net Item Cost 1
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Net Item Cost 1] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Net Item Cost 1'

-- NPC Quote: Quantity 2
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Quantity 2] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Quantity 2'

-- NPC Quote: Net Item Cost 2
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Net Item Cost 2] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Net Item Cost 2'

-- NPC Quote: Quantity 3
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Quantity 3] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Quantity 3'

-- NPC Quote: Net Item Cost 3
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Net Item Cost 3] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Net Item Cost 3'

-- NPC Quote: Quantity 4
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Quantity 4] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Quantity 4'

-- NPC Quote: Net Item Cost 4
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Net Item Cost 4] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Net Item Cost 4'

-- NPC Quote: Quantity 5
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Quantity 5] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Quantity 5'

-- NPC Quote: Net Item Cost 5
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Net Item Cost 5] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Net Item Cost 5'

-- NPC Quote: Quantity 6
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Quantity 6] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Quantity 6'

-- NPC Quote: Net Item Cost 6
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Net Item Cost 6] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Net Item Cost 6'

-- NPC Quote: Quantity 7
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Quantity 7] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Quantity 7'

-- NPC Quote: Net Item Cost 7
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NPC Quote: Net Item Cost 7] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NPC Quote: Net Item Cost 7'

-- Setup Cost: NPC Quote
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Setup Cost: NPC Quote] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Setup Cost: NPC Quote'

-- NEW ORDER Setup Cost: CAT STD NET
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [NEW ORDER Setup Cost: CAT STD NET] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'NEW ORDER Setup Cost: CAT STD NET'

-- Re-Order Setup Charge (Exact Artwork): NPC Quote - NET
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Re-Order Setup Charge (Exact Artwork): NPC Quote - NET] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Re-Order Setup Charge (Exact Artwork): NPC Quote - NET'

-- Addl Color Run Charge: NPC Quote - NET
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Addl Color Run Charge: NPC Quote - NET] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Addl Color Run Charge: NPC Quote - NET'

-- Addl Location Run Charge: NPC Quote - NET
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Addl Location Run Charge: NPC Quote - NET] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Addl Location Run Charge: NPC Quote - NET'

-- HTS Code
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [HTS Code] = ToolTip
from .MasterDataSheetColumns
where ColumnName = 'HTS Code'

-- Features: BPA Free
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Features: BPA Free] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Features: BPA Free'

-- Features: Eco Friendly
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Features: Eco Friendly] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Features: Eco Friendly'

-- Features: FDA Compliant
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Features: FDA Compliant] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Features: FDA Compliant'

-- Features: Lead Free
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Features: Lead Free] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Features: Lead Free'

-- Features: Prop 65 Label Required
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Features: Prop 65 Label Required] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Features: Prop 65 Label Required'

-- Features: Recyclable
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Features: Recyclable] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Features: Recyclable'

-- Features: Hazardous  Shipping
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Features: Hazardous  Shipping] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Features: Hazardous Shipping'

-- Hazardous Shipping Charge - NET
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Hazardous Shipping Charge - NET] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Hazardous Shipping Charge - NET'

-- Rush Production Available
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Rush Production Available] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Rush Production Available'

-- Rush TAT
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Rush TAT] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Rush TAT'

-- Rush Charge
update PIM_ETL_Stage.dbo.Stage_MasterDataSheetTemplate
set [Rush Charge] = ToolTip
from MasterDataSheetColumns
where ColumnName = 'Rush Charge'


GO
