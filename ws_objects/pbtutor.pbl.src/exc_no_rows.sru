$PBExportHeader$exc_no_rows.sru
forward
global type exc_no_rows from throwable
end type
end forward

global type exc_no_rows from throwable
string text = "No rows were returned from the database. If you typed or selected a state code in the drop-down list box and the database connection has not been closed, either the state you entered has no customers or you entered the state code incorrectly."
end type
global exc_no_rows exc_no_rows

on exc_no_rows.create
call super::create
TriggerEvent( this, "constructor" )
end on

on exc_no_rows.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

