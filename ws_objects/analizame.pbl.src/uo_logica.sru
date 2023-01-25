$PBExportHeader$uo_logica.sru
forward
global type uo_logica from nonvisualobject
end type
end forward

global type uo_logica from nonvisualobject
end type
global uo_logica uo_logica

type variables
string is_arreglo[]
uo_mitransaction SQLCA2
uo_midatastore ids_datos  


end variables

forward prototypes
public function long of_max_contactos ()
public function integer of_activar_trace ()
public function integer of_asignar_expresion_columna_dv ()
public function integer of_asignar_expresion_data_dv ()
public function integer of_asignar_x_metodo_dv ()
public function integer of_asignar_columna_con_arreglo_mv ()
public function integer of_asignar_expresion_columna_mv ()
public function integer of_asignar_columna_con_arreglo_dv ()
public function integer of_asignar_expresion_data_mv ()
public function integer of_asignar_x_metodo_mv ()
public subroutine of_asignar_1_item ()
public function integer of_insert_sql (long al_registros, long al_max)
public function integer of_insertar_contactos (long al_registros)
public function long of_principal (long al_registros)
public function long of_cursor (integer ai_ini, integer ai_fin)
public function long of_traer_datos (integer ai_ini, integer ai_fin)
end prototypes

public function long of_max_contactos ();long ll_max

select max(id) 
into :ll_max
from public.contact  using sqlca2;

return ll_max
end function

public function integer of_activar_trace ();ErrorReturn le_err
integer li_key
TimerKind ltk_kind

ltk_kind = Clock!
  
// Open the trace file and return an error message
// if the open fails
le_err = TraceOpen( "miarchivo.pbp", ltk_kind )
IF le_err <> Success! THEN 
   messagebox("Grave", 'No se pudo crear el archivo de trace')
   RETURN -1
END IF

// Enable trace activities. Enabling ActLine!
// enables ActRoutine! implicitly
TraceEnableActivity(ActESQL!)
TraceEnableActivity(ActUser!)
TraceEnableActivity(ActError!)
TraceEnableActivity(ActLine!)
TraceEnableActivity(ActObjectCreate!)
TraceEnableActivity(ActObjectDestroy!)
TraceEnableActivity(ActGarbageCollect!)

TraceEnableActivity(ActTrace!)
TraceEnableActivity(ActLine!)
		
TraceBegin("Trace_block_1")
// first block of code to be traced
// this block has the label Trace_block_1


TraceEnd()

// disable trace activities not needed for
// second block
TraceDisableActivity(ActLine! )
TraceDisableActivity(ActObjectCreate!)
TraceDisableActivity(ActObjectDestroy!)
TraceDisableActivity(ActGarbageCollect!)

TraceBegin("Trace_block_2")
// second block of code to be traced


TraceEnd()
TraceClose()

end function

public function integer of_asignar_expresion_columna_dv ();long ll_filas,ll_max
string ls_uid
datetime ldt_fecha

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ids_datos.Object.phone[ ll_filas ] = string(ll_filas)
next


return 0
end function

public function integer of_asignar_expresion_data_dv ();long ll_filas,ll_max,ll_ultima
string ls_uid
datetime ldt_fecha

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ids_datos.Object.Data[ ll_filas,9 ] = string(ll_filas)
next


return 0
end function

public function integer of_asignar_x_metodo_dv ();long ll_filas,ll_max
string ls_uid
datetime ldt_fecha

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ids_datos.setitem(ll_filas,"phone",string(ll_filas))
next


return 0
end function

public function integer of_asignar_columna_con_arreglo_mv ();long ll_max,ll_filas
string ls_telefonos[]

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ls_telefonos[ ll_filas ] = '3102111111'
next

ids_datos.Object.phone[1,ll_max] =ls_telefonos[]

return 0
end function

public function integer of_asignar_expresion_columna_mv ();long ll_filas,ll_max
string ls_uid
datetime ldt_fecha

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ids_datos.Object.phone[ ll_filas ] = '3102111111'
next


return 0
end function

public function integer of_asignar_columna_con_arreglo_dv ();long ll_max,ll_filas
string ls_telefonos[]

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ls_telefonos[ ll_filas ] =string(ll_filas)
next

ids_datos.Object.phone[1,ll_max] =ls_telefonos[]

return 0
end function

public function integer of_asignar_expresion_data_mv ();long ll_filas,ll_max,ll_ultima
string ls_uid
datetime ldt_fecha

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ids_datos.Object.Data[ ll_filas,9 ] =  '3102111111'
next


return 0
end function

public function integer of_asignar_x_metodo_mv ();long ll_filas,ll_max
string ls_uid
datetime ldt_fecha

ll_max =ids_datos.rowcount()

for ll_filas= 1 to ll_max
	ids_datos.setitem(ll_filas,"phone",'3102111111')
next

return 0
end function

public subroutine of_asignar_1_item ();ids_datos.Object.Data[ 1,9 ] =  '3102111111'
ids_datos.Object.phone[ 1 ] = '3102111111'
ids_datos.setitem(1,"phone",'3102111111')
end subroutine

public function integer of_insert_sql (long al_registros, long al_max);long ll_filas
string ls_dato


for ll_filas=al_max + 1 to al_max + al_registros
	
	ls_dato = string(ll_filas)
  INSERT INTO public.contact  
         ( id,   
           last_name,   
           first_name,   
           title,   
           street,   
           city,   
           state,   
           zip,   
           phone,   
           fax )  
  VALUES ( :ll_filas,   
           :ls_dato,   
           :ls_dato,   
           '1',   
           '1',   
           '1',   
           '1',   
           '1',   
           :ls_dato,   
          :ls_dato)  using SQLCA2;
			 
	if SQLCA2.sqlcode <> 0 then
		rollback using SQLCA2;
		return -1
	end if
next

commit using SQLCA2;

return 0
end function

public function integer of_insertar_contactos (long al_registros);long ll_filas,ll_max,ll_ultima
string ls_uid
datetime ldt_fecha

if gs_debug = 'SI' then
 TraceBegin("Bloque1") //Iniciar el trace de este bloque
end if

ids_datos.dataobject = 'd_contacto'
ids_datos.settransobject( SQLCA2)


ll_max = of_max_contactos()

for ll_filas=ll_max + 1 to ll_max + al_registros
	string ls_dato
	ls_dato = string(ll_filas)
	ll_ultima = ids_datos.insertrow(0)
	ids_datos.setitem(ll_ultima,"id",ll_filas)
	ids_datos.setitem(ll_ultima,"state","IN")
	ids_datos.setitem(ll_ultima,"city","0")
	ids_datos.setitem(ll_ultima,"title","Mr")
	ids_datos.setitem(ll_ultima,"first_name","Nombre"+ ls_dato)
	ids_datos.setitem(ll_ultima,"street","Otro"+string(ll_filas))
	ids_datos.setitem(ll_ultima,"last_name","Apellido"+string(ll_filas))
	ids_datos.setitem(ll_ultima,"zip","1")
	ids_datos.setitem(ll_ultima,"phone",string(ll_filas))
	ids_datos.setitem(ll_ultima,"fax",string(ll_filas))
next

if ids_datos.update() = 1 then
	commit using SQLCA2;
	return 0
else
	rollback using SQLCA2;
	return -1
end if

end function

public function long of_principal (long al_registros);long ll_filas,ll_max,ll_ultima
string ls_uid
datetime ldt_fecha

if gs_debug = 'SI' then
 TraceBegin("Bloque1") //Iniciar el trace de este bloque
end if

ll_max = this.of_insertar_contactos( al_registros)
ll_max = of_max_contactos()
sleep(1)

if gs_debug = 'SI' then
 TraceEnd() // Finaliza el Trace
end if


this.of_insert_sql(al_registros, ll_max + al_registros )

ids_datos.setfilter( "id >="+string( ll_max) +" and id <= " + string(ll_max + al_registros))
ids_datos.filter()
//diferentes valores
this.of_asignar_expresion_columna_dv( )
this.of_asignar_expresion_data_dv( )
this.of_asignar_x_metodo_dv( )
this.of_asignar_columna_con_arreglo_dv()
//mismo valor
this.of_asignar_expresion_columna_mv( )
this.of_asignar_expresion_data_mv()
this.of_asignar_x_metodo_mv()
this.of_asignar_columna_con_arreglo_mv( )
//un solo item
this.of_asignar_1_item()
this.of_cursor( 1,10000)
ll_max = this.of_traer_datos(1,10000)
ids_datos.accepttext( )

ll_max = ids_datos.rowcount( )
ll_max = of_max_contactos() 
return ll_max

end function

public function long of_cursor (integer ai_ini, integer ai_fin);int li_cod	 
string ls_first_name,ls_last_name ,ls_title , ls_street,ls_city ,ls_state ,ls_zip ,ls_phone, ls_fax

 DECLARE cur_contacto CURSOR FOR  
  SELECT public.contact.id,   
         public.contact.last_name,   
         public.contact.first_name,   
         public.contact.title,   
         public.contact.street,   
         public.contact.city,   
         public.contact.state,   
         public.contact.zip,   
         public.contact.phone,   
         public.contact.fax  
    FROM public.contact 
	 where id > :ai_ini and id < :ai_fin
	 using sqlca2 ;

open cur_contacto;

do 
	fetch cur_contacto into :li_cod,:ls_first_name,:ls_last_name ,:ls_title , :ls_street,:ls_city ,:ls_state ,:ls_zip ,:ls_phone, :ls_fax;
loop while sqlca2.sqlcode = 0



close cur_contacto;
return 0
	 
	 

end function

public function long of_traer_datos (integer ai_ini, integer ai_fin);long ll_datos
ll_datos = ids_datos.retrieve()
return ll_datos
end function

on uo_logica.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_logica.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Profile demo

SQLCA2 = create uo_mitransaction
SQLCA2.DBMS = "ODBC"
SQLCA2.AutoCommit = False
SQLCA2.DBParm = "ConnectString='DSN=PostgreSQL35W;UID=demo;PWD=demo'"
connect using SQLCA2;
ids_datos  = create uo_midatastore

if gs_debug = 'SI' then
	ErrorReturn le_err
	TimerKind ltk_kind
	ltk_kind = Clock!
	  
	// Crear el archivo de trace
	le_err = TraceOpen( "miarchivotraza2.pbp", ltk_kind )
	IF le_err <> Success! THEN 
		messagebox("Grave", 'No se pudo crear el archivo de trace')
		RETURN -1
	END IF
	
	// Habilitar las actividades de Traza. 
	// Habilitar ActLine! tambien habilita ActRoutine! implicitamente
	TraceEnableActivity(ActTrace!)
	TraceEnableActivity(ActLine!)
end if
	

end event

event destructor;disconnect using SQLCA2;
TraceClose()
end event

