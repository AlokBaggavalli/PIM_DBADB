Create Procedure [dbo].[usp_ImportTransfer_Driver]

as

set nocount on


begin tran



exec usp_ImportTransfer_Delete

if @@ERROR <> 0
begin
	GOTO ROLLIT
end



exec usp_ImportTransfer_Upsert

if @@ERROR <> 0
begin
	GOTO ROLLIT
end



COMMITIT:
commit

GOTO DONE



ROLLIT:
rollback



DONE:





GO
