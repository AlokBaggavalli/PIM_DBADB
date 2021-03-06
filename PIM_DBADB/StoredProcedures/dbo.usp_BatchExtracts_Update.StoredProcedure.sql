CREATE Procedure [dbo].[usp_BatchExtracts_Update]
	@BatchID		varchar(10),
	@Type			varchar(50),
	@Extract		varchar(50)
	
as

set nocount on


declare @MinID		int

				

if @Extract in('2','6')
begin
	select @MinID =	(
						select MIN(ID)
						from BatchExtracts
						where BatchID = @BatchID
							and [Type] = @Type
							and [Status] in('1','5')
					)


	update BatchExtracts
	set [Status] = @Extract
	where ID = @MinID
end


if @Extract in('3','7')
begin
	select @MinID =	(
						select MIN(ID)
						from BatchExtracts
						where BatchID = @BatchID
							and [Type] = @Type
							and [Status] in('2','6')
					)


	update BatchExtracts
	set [Status] = @Extract,
		LastExtract = GETDATE()
	where ID = @MinID
end



if @Extract in('4','8')
begin
	select @MinID =	(
						select MIN(ID)
						from BatchExtracts
						where BatchID = @BatchID
							and [Type] = @Type
							and [Status] in('2','6')
					)


	update BatchExtracts
	set [Status] = @Extract,
		LastExtract = GETDATE()
	where ID = @MinID
end






GO
