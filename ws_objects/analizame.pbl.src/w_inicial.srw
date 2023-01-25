$PBExportHeader$w_inicial.srw
forward
global type w_inicial from window
end type
type cb_1 from commandbutton within w_inicial
end type
type dw_1 from datawindow within w_inicial
end type
end forward

global type w_inicial from window
integer width = 2533
integer height = 1408
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_inicial w_inicial

forward prototypes
public function integer wf_asignar_todos ()
end prototypes

public function integer wf_asignar_todos ();long ll_max,ll_filas
string ls_telefonos[]

ll_max =dw_1.rowcount()


for ll_filas= 1 to ll_max
	ls_telefonos[ ll_filas ] = '222'
next

//dw_1.Object.phone.Primary =ls_telefonos[]
dw_1.Object.phone[1,ll_max] =ls_telefonos[]

return 0
end function

event open;// Profile demo-demo
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=PostgreSQL35W;UID=demo;PWD=demo',DisableBind=1,StaticBind=0"
connect;
if sqlca.sqlcode = 0 then
	dw_1.settransobject( sqlca)
	dw_1.retrieve()
end if

end event

on w_inicial.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_inicial.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_inicial
integer x = 869
integer y = 812
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "asignar"
end type

event clicked;parent.wf_asignar_todos( )
end event

type dw_1 from datawindow within w_inicial
integer x = 41
integer y = 80
integer width = 2034
integer height = 560
integer taborder = 10
string title = "none"
string dataobject = "d_contacto"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

