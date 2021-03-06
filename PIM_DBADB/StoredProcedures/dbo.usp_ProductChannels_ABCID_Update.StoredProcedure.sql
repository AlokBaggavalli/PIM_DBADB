Create Procedure [dbo].[usp_ProductChannels_ABCID_Update]

as

set nocount on


update ProductChannels
set ABCID = null,
	ABCChanged = null,
	ChangedBy = null
where ABCID is not null




update m
set m.ABCID = z.ABCID,
	m.ABCChanged = GETDATE(),
	m.ChangedBy = 'Weekly Process'
from ProductChannels m
	join
		(
			select	pc.ID,
					pc.ProductID,
					pc.ChannelID,
					t.ABCCode,
					ac.ID as ABCID
			from ProductChannels pc
				join PIM_ETL_Stage.dbo.Stage_ABCCalculation t
					on pc.ProductID = t.ProductID
						and pc.ChannelID = t.ChannelID
				left join ABCcodes ac
					on t.ABCCode = ac.[Description]
		) z
	on m.ID = z.ID

GO
