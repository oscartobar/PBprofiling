$PBExportHeader$w_cust_pct.srw
forward
global type w_cust_pct from w_pbtutor_basesheet
end type
type cbx_zero from checkbox within w_cust_pct
end type
type sle_result from singlelineedit within w_cust_pct
end type
type cb_percent from commandbutton within w_cust_pct
end type
type ddlb_state from dropdownlistbox within w_cust_pct
end type
type st_2 from statictext within w_cust_pct
end type
type st_1 from statictext within w_cust_pct
end type
end forward

global type w_cust_pct from w_pbtutor_basesheet
string tag = "Customer Location"
integer width = 2286
cbx_zero cbx_zero
sle_result sle_result
cb_percent cb_percent
ddlb_state ddlb_state
st_2 st_2
st_1 st_1
end type
global w_cust_pct w_cust_pct

forward prototypes
public function decimal uf_percentage (integer ai_custbystate, integer ai_totalcust) throws exc_no_rows,exc_low_number
end prototypes

public function decimal uf_percentage (integer ai_custbystate, integer ai_totalcust) throws exc_no_rows,exc_low_number;Decimal my_result
exc_no_rows  le_nr
exc_low_number le_ex
//* Process two integers passed as parameters. Instantiate and throw exceptions if the first integer value is 0 or 1. Otherwise calculate a percentage and return a numeric value truncated to a single decimal place. If the second integer value is 0, catch and rethrow the runtime dividebyzero error during the calculation. 
//Set denominator to zero to test error condition
//Numerator unimportant, avoid user exception cases
TRY
IF cbx_zero.checked=TRUE THEN
		ai_totalcust=0
		ai_custbystate=2
END IF
CATCH (nullobjecterror e_no)
		MessageBox ("Null object", "Invalid Test")
END TRY
CHOOSE CASE ai_custbystate
	CASE 0
		le_nr = create exc_no_rows
		throw le_nr		
	CASE 1
		le_ex = create exc_low_number
		throw le_ex
	CASE ELSE
		TRY
			my_result=(ai_custbystate/ai_totalcust)*100
		CATCH (dividebyzeroerror le_zero)
			throw le_zero
		End TRY	
END CHOOSE
return truncate(my_result,1)
end function

on w_cust_pct.create
int iCurrent
call super::create
this.cbx_zero=create cbx_zero
this.sle_result=create sle_result
this.cb_percent=create cb_percent
this.ddlb_state=create ddlb_state
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_zero
this.Control[iCurrent+2]=this.sle_result
this.Control[iCurrent+3]=this.cb_percent
this.Control[iCurrent+4]=this.ddlb_state
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
end on

on w_cust_pct.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_zero)
destroy(this.sle_result)
destroy(this.cb_percent)
destroy(this.ddlb_state)
destroy(this.st_2)
destroy(this.st_1)
end on

type cbx_zero from checkbox within w_cust_pct
integer x = 768
integer y = 320
integer width = 736
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Test divide-by-zero error"
end type

type sle_result from singlelineedit within w_cust_pct
integer x = 197
integer y = 544
integer width = 1609
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Text box for percent of customers in the selected state"
borderstyle borderstyle = stylelowered!
end type

type cb_percent from commandbutton within w_cust_pct
integer x = 251
integer y = 320
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Percentage"
end type

event clicked;Decimal my_result 
Double entry_1, entry_2
Int li_int, li_rtn
String sel_state

sel_state=ddlb_state.text
//Get the number of rows with customers from the 
//selected states and place in the entry_1 variable.
//Change the first static control to display this
//number.


SELECT count(*) INTO :entry_1 FROM customer
		WHERE customer.state=:sel_state;
st_1.text="Customers in state: " + string(entry_1)

//Get the total number of customers and place in 
//the entry_2 variable.
//Change the second static control to display this //number.
SELECT count(*) INTO :entry_2 FROM customer;
st_2.text="Total number of customers: " &
		+ string(entry_2)

//Call uf_percentage and catch its exceptions.
TRY 
		my_result = uf_percentage (entry_1, entry_2)
CATCH (exc_no_rows e_nr )
		MessageBox("From exc_no_rows", 		&
			e_nr.getmessage())
CATCH (exc_low_number e_ln )
		li_int=1 
		MessageBox("From exc_low_number", & 				
			e_ln.getmessage())
	CATCH (dividebyzeroerror e_zero)
		li_rtn = MessageBox("No Customers", &
			"Terminate Application?", Stopsign!, YesNo!)
		IF li_rtn=1 THEN
			HALT
		END IF
END TRY

//Display the message in the text box. Vary the //message depending on whether there is only one 
//customer for the selected state or if more than 
//one customer resides in selected state.
IF li_int=1 THEN
		sle_result.text ="Value not calculated for " & 
			+ sel_state + "." 	+ " Try another state."
ELSE
		sle_result.text = String (my_result) + &
			" % of customers are in " + sel_state + "."
END IF
end event

type ddlb_state from dropdownlistbox within w_cust_pct
event type integer ue_modified ( string as_statecode ) throws exc_bad_entry
integer x = 1463
integer y = 28
integer width = 480
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event type integer ue_modified(string as_statecode);exc_bad_entry  le_ex
//Make sure the current text in the drop-down list 
//box is two characters in length. Otherwise, 
//instantiate the exc_bad_entry exception object and 
//throw the exception.
IF len(this.text)<>2 Then
		le_ex = create exc_bad_entry
		throw le_ex
END IF
Return 1
end event

event losefocus;Try 
		this.EVENT ue_modified(this.text)
Catch (exc_bad_entry le_be)
		messagebox ("from exc_bad_entry", & 				
			le_be.getmessage())
End Try

return 1
end event

event constructor;int 		li_nrows, n
string		 ls_state
//Get the distinct count of all states in the 
//customer table
SELECT count(distinct state) INTO :li_nrows 
FROM customer;
//Declare the SQL cursor to select all states
//in customer table but avoid
//rows with duplicate values for state.
DECLARE custstatecursor CURSOR FOR 
SELECT state FROM customer
GROUP BY state HAVING count(state)=1
UNION 
SELECT state FROM customer
GROUP BY state
HAVING count(state)>1;
OPEN custstatecursor ;
//Populate the control with a single entry for
//every state in the customer table.
FOR n=1 TO li_nrows
		FETCH NEXT custstatecursor INTO :ls_state;				
		this.additem( ls_state)
NEXT
CLOSE custstatecursor ;
//Set first item in list as selected item
this.selectitem (1)
end event

type st_2 from statictext within w_cust_pct
integer x = 110
integer y = 160
integer width = 2249
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2. Click percentage button"
boolean focusrectangle = false
end type

type st_1 from statictext within w_cust_pct
integer x = 110
integer y = 68
integer width = 2249
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "1. Select or type a state code in drop-down list box:"
boolean focusrectangle = false
end type

