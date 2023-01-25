$PBExportHeader$exc_low_number.sru
forward
global type exc_low_number from throwable
end type
end forward

global type exc_low_number from throwable
string text = "Percentage too low. Only one customer in this state. Notify regional sales manager..."
end type
global exc_low_number exc_low_number

on exc_low_number.create
call super::create
TriggerEvent( this, "constructor" )
end on

on exc_low_number.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

