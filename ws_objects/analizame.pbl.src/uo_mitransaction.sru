$PBExportHeader$uo_mitransaction.sru
forward
global type uo_mitransaction from transaction
end type
end forward

global type uo_mitransaction from transaction
end type
global uo_mitransaction uo_mitransaction

on uo_mitransaction.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mitransaction.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

