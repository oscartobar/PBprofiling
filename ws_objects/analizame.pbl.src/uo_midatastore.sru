$PBExportHeader$uo_midatastore.sru
forward
global type uo_midatastore from datastore
end type
end forward

global type uo_midatastore from datastore
end type
global uo_midatastore uo_midatastore

type variables
 
end variables

on uo_midatastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_midatastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;messagebox("Error db error",sqlerrtext)
end event

event itemerror;messagebox("Itemerrior",data)
end event

event error;messagebox("Error  ",errortext)
end event

