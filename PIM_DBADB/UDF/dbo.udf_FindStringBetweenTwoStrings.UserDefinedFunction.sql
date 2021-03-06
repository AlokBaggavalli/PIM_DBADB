Create Function [dbo].[udf_FindStringBetweenTwoStrings]
(
	@Text		varchar(3000),
	@Start		varchar(500),
	@End		varchar(500)
)

RETURNS TABLE

AS

RETURN
--declare @text varchar(1000)
--set @text ='<div class="text-center"><span  class="font-bold font-italic">Keep yourself warm and dry in the stands with this surface washable fleece stadium blanket.</span><br> </div>Promote your brand to prospects while they support their favourite sports teams with this fleece stadium blanket available in popular colours.'

--declare @start varchar(100)
--set @start = '<div class="text-center"><span  class="font-bold font-italic">'

--declare @end varchar(100)
--set @end = '</span><br> </div>'

select @text text_to_search
, substring( LEFT(@text, charindex(@end, @text)-1), CHARINDEX(@start, @text) + len(@start), LEN(@text))   result
GO
