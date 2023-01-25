$PBExportHeader$exc_bad_entry.sru
forward
global type exc_bad_entry from throwable
end type
end forward

global type exc_bad_entry from throwable
string text = "You must use the two-letter postal code for the state name."
end type
global exc_bad_entry exc_bad_entry

on exc_bad_entry.create
call super::create
TriggerEvent( this, "constructor" )
end on

on exc_bad_entry.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

