$PBExportHeader$pbtutor.sra
$PBExportComments$Generated MDI Application Object
forward
global type pbtutor from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
n_pbtutor_connectservice gnv_connect
end variables

global type pbtutor from application
string appname = "pbtutor"
string appruntimeversion = "22.0.0.1892"
end type
global pbtutor pbtutor

on pbtutor.create
appname="pbtutor"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbtutor.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//*-----------------------------------------------------------------*/
//*    open:  Application Open Script:
//            1) Opens frame window
//*-----------------------------------------------------------------*/

/*  This prevents double toolbars  */
this.ToolBarFrameTitle = "MDI Application Toolbar"
this.ToolBarSheetTitle = "MDI Application Toolbar"

/*  Open MDI frame window  */
Open ( w_pbtutor_frame )
end event

event close;//Application Close script:
//		Disconnect from the database
if isvalid(gnv_connect) then
	gnv_connect.of_DisconnectDB ( )
end if
end event

