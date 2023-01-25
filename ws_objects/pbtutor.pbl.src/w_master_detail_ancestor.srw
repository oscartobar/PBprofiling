$PBExportHeader$w_master_detail_ancestor.srw
$PBExportComments$New ancestor basesheet for the w_customers and w_products sheet windows.
forward
global type w_master_detail_ancestor from w_pbtutor_basesheet
end type
type dw_detail from u_dwstandard within w_master_detail_ancestor
end type
type dw_master from u_dwstandard within w_master_detail_ancestor
end type
end forward

global type w_master_detail_ancestor from w_pbtutor_basesheet
integer width = 2418
integer height = 1724
string menuname = "m_my_sheet"
event ue_retrieve ( )
event ue_insert ( )
event ue_update ( )
event ue_delete ( )
dw_detail dw_detail
dw_master dw_master
end type
global w_master_detail_ancestor w_master_detail_ancestor

event ue_retrieve();IF dw_master.Retrieve() <> -1 THEN	
		 dw_master.SetFocus()
	 dw_master.SetRowFocusIndicator(Hand!)
END IF
end event

event ue_insert();dw_detail.Reset()
dw_detail.InsertRow(0)
dw_detail.SetFocus()
end event

event ue_update();IF dw_detail.Update() = 1 THEN	
 COMMIT using SQLCA;	
 MessageBox("Save","Save succeeded")
ELSE	
 ROLLBACK using SQLCA;
END IF
end event

event ue_delete();dw_detail.DeleteRow(0)
end event

on w_master_detail_ancestor.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_my_sheet" then this.MenuID = create m_my_sheet
this.dw_detail=create dw_detail
this.dw_master=create dw_master
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.dw_master
end on

on w_master_detail_ancestor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_detail)
destroy(this.dw_master)
end on

event open;call super::open;dw_master.settransobject ( sqlca )
dw_detail.settransobject ( sqlca )
this.EVENT ue_retrieve()
end event

type dw_detail from u_dwstandard within w_master_detail_ancestor
integer x = 18
integer y = 768
integer taborder = 20
end type

type dw_master from u_dwstandard within w_master_detail_ancestor
integer x = 18
integer y = 60
integer taborder = 10
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_itemnum

ll_itemnum = this.object.data[currentrow, 1]

IF dw_detail.Retrieve(ll_itemnum) = -1 THEN	
 MessageBox("Retrieve","Retrieve error-detail")
END IF
end event

