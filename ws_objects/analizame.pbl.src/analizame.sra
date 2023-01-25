$PBExportHeader$analizame.sra
$PBExportComments$Generated Application Object
forward
global type analizame from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_debug
end variables

global type analizame from application
string appname = "analizame"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 22.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "22.0.0.1892"
boolean manualsession = false
boolean unsupportedapierror = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
end type
global analizame analizame

on analizame.create
appname="analizame"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on analizame.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;time lt_ini,lt_fin
long ll_retorno
gs_debug = 'NO'

lt_ini = now()
uo_logica luo_logica
luo_logica = create uo_logica
ll_retorno = luo_logica.of_principal(100) 
if ll_retorno >= 0 then
	lt_fin = now()
	messagebox("Correcto","Inserto en "+ string(SecondsAfter (  lt_ini ,lt_fin)  ) + " Segundos")
else
	messagebox("Error","No pudo funcionar ")
end if

//open(w_inicial)
end event

