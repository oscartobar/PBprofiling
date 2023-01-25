$PBExportHeader$u_dwstandard.sru
$PBExportComments$User-defined standard DataWindow control with built-in error processing
forward
global type u_dwstandard from datawindow
end type
end forward

global type u_dwstandard from datawindow
int Width=2098
int Height=684
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event uevent_dberr_reqmissing ( dwbuffer adwb_buffer,  long al_row )
event uevent_dberr_initial ( )
event uevent_dberr_message ( long al_errorcode,  string as_errortext,  long al_row,  dwbuffer adwb_buffer )
end type
global u_dwstandard u_dwstandard

event uevent_dberr_reqmissing;/* Event profile
	
	Name:			uevent_dberr_reqmissing
	Applies to:	u_dwstandard
	Kind:			User
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  This user event is triggered by the uevent_dberr_message     /
//  event script when SQL Anywhere database error -195 occurs    /
//  (required column values are missing). It takes 2 arguments:  /
//                                                               /
//  * adwb_buffer (the DataWindow buffer)                        /
//  * al_row (the error row)                                     /
//                                                               /
//  If you want to perform any specialized processing in your    /
//  descendent DW control in this situation, code it here.       /
//                                                               /
//////////////////////////////////////////////////////////////////

end event

event uevent_dberr_initial;/* Event profile
	
	Name:			uevent_dberr_initial
	Applies to:	u_dwstandard
	Kind:			User
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  This user event is triggered by the DBError event script     /
//  at the very beginning of that script.                        /
//                                                               /
//  If you want to perform any specialized initial error         /
//  processing in your descendent DW control, code it here.      /
//                                                               /
//////////////////////////////////////////////////////////////////

end event

event uevent_dberr_message;/* Event profile
	
	Name:			uevent_dberr_message
	Applies to:	u_dwstandard
	Kind:			User
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  Overview --                                                  /
//                                                               /
//  This user event is posted by the DBError event script to     /
//  display an appropriate messagebox describing the database    /
//  error that has occurred. It takes 4 arguments:               /
//                                                               /
//  * al_errorcode (the database error code)                     /
//  * as_errortext (the database error text)                     /
//  * al_row (the error row)                                     /
//  * adwb_buffer (the DataWindow buffer)                        /
//                                                               /
//  The technique of deferring message displays to this posted   /
//  user event enables the DBError event to finish quickly, so   /
//  that the application can proceed to finish the transaction   /
//  (by doing a rollback or commit).                             /
//                                                               /
//////////////////////////////////////////////////////////////////




	///////////////////////////////////////////////////////////////
   //                                                            /
	//  Handling particular errors --                             /
	//                                                            /
	//  Trap some of the more common errors and provide special   /
	//  messages (and maybe even further processing) for them.    /
	//  For any other errors, display a more generic messagebox.  /
	//                                                            /
	//                                                            /
	//    About DBMS error codes --                               /
	//                                                            /
	//		Since this application currently uses a SQL Anywhere    /
	//    database, the codes tested below are specific to the    /
	//    SQL Anywhere DBMS.  If accessing a different DBMS,      /
	//    substitute its own codes.                               /
	//                                                            /
	///////////////////////////////////////////////////////////////

CHOOSE CASE al_errorcode

	CASE -193

		Beep (1)

		MessageBox("Database Error: Trouble with Key", &
					  "Problem: " +&
					  "Your key value is already used by an existing row. " +&
						"~n~r~n~r" +&
					  "Solution: " +&
					  "Please specify a unique key value. "+&
 				  	  "~n~r~n~r" +&
					  "Details: " +&
					  String(al_errorcode) + " " + as_errortext, &
  					  exclamation!)

	CASE -194

		Beep (1)

		MessageBox("Database Error: Related Info Not on File", &
					  "Problem: " +&
					  "One of your column values is a key that " +&
				 	  "refers to a related row in another table. " +&
				 	  "But there's not a row in the other table " +&
  					  "with that key value. " +&
						"~n~r~n~r" +&
					  "Solution: " +&
					  "Please check your column values for accuracy " +&
					  "and make any needed corrections. " +&
 				  	  "~n~r~n~r" +&
					  "Details: " +&
					  String(al_errorcode) + " " + as_errortext, &
  					  exclamation!)

	CASE -195

		Beep (1)

		MessageBox("Database Error: Missing Column Value(s)", &
					  "Problem: " +&
					  "You left one or more required columns empty. " +&
					  "~n~r~n~r" +&
					  "Solution: " +&
					  "Please fill in all of the required columns. " +&
 				  	  "~n~r~n~r" +&
					  "Details: " +&
					  String(al_errorcode) + " " + as_errortext, &
  					  exclamation!)
			
			// Trigger the user event uevent_dberr_reqmissing to do any
			// additional processing that is needed for this particular 
			// error. This user event takes 2 arguments:
			// 
			// * adwb_buffer (the DataWindow buffer, which is available
			//					  in the adwb_buffer argument of the 
			//               uevent_dberr_message event)
			//
			// * al_row		  (the error row, which is available in the
			//					  al_row argument of the uevent_dberr_message 
			//               event)		
			//
			// We'll leave the script for this user event empty in the
			// ancestor DW user object.  That way, if a descendent needs
			// to do some specialized processing for the error, we can 
			// easily code this in the descendent's version of the user
			// event script.

		this.EVENT uevent_dberr_reqmissing(adwb_buffer,al_row)


	CASE -198

		Beep (1)

		MessageBox("Database Error: Trouble with Related Info", &
					  "Problem: " +&
					  "One or more other tables refer to the row " +&
				 	  "that you're processing.  That means you can't " +&
				 	  "delete this row or change its key value. " +&
  						"~n~r~n~r" +&
					  "Solution: " +&
					  "If appropriate, delete the related rows in those " +&
					  "other tables first (or modify them so that they " +&
				 	  "don't refer to your target row). " +&
 				  	  "~n~r~n~r" +&
					  "Details: " +&
					  String(al_errorcode) + " " + as_errortext, &
  					  exclamation!)

	CASE -209

		Beep (1)

		MessageBox("Database Error: Invalid Column Value(s)", &
					  "Problem: " +&
					  "One or more of your columns have values that " +&
					  "are not allowed. " +&
					  "~n~r~n~r" +&
					  "Solution: " +&
					  "Please check your column values for accuracy " +&
					  "and make any needed corrections. " +&
 				  	  "~n~r~n~r" +&
					  "Details: " +&
					  String(al_errorcode) + " " + as_errortext, &
  					  exclamation!)


	CASE ELSE

			// For all other errors, display this generic messagebox with
			// a user-friendly message as well as the DBMS error code and 
			// message text.

		Beep (1)

		MessageBox("Database Processing Error", &
					  "A database problem occurred while your " +&
					  "request was being processed. " +&
  					  "Here are the details: " +&
					  "~n~r~n~r" +&
					  String(al_errorcode) + " " + as_errortext +&
					  "~n~r~n~r" +&
				 	  "Please call the Anchor Bay support team. ", &
				 	  exclamation!)
		
END CHOOSE

end event

event dberror;/* Event profile
	
	Name:			DBError
	Applies to:	u_dwstandard
	Kind:			System
	Processing:	See below

*/

//////////////////////////////////////////////////////////////////
//                                                               /
//  Overview --                                                  /
//                                                               /
//  When a database error occurs in the DataWindow control       /
//  (resulting from a Retrieve function or an Update function),  /
//  then get the error code and message that the DBMS returned   /
//  and display them nicely to the user.                         /
//                                                               /
//  Also, suppress the default error messagebox that the         /
//  DBError event normally displays.                             /
//                                                               /
//////////////////////////////////////////////////////////////////


	///////////////////////////////////////////////////////////////
	//                                                            /
	//  Initial processing --                                     /
	//                                                            /
	//  First, trigger a user event that descendents of this      /
	//  ancestor DW user object can use if necessary to perform   /
	//  any initial error processing.  (The script for this user  /
	//  event is empty in this ancestor DW user object.)          /
	//                                                            /
	///////////////////////////////////////////////////////////////

this.EVENT uevent_dberr_initial()


	///////////////////////////////////////////////////////////////
   //                                                            /
	//  Displaying an error message --                            /
	//                                                            /
	//  Next, tell the user what went wrong by displaying a       /
	//  messagebox with the database error information. We do     /
	//  that by posting a user event (uevent_dberr_message).      /
	//  Read the following discussion to learn the reason for     /
	//  this approach.                                            /
	//                                                            /
	//                                                            /
	//    Avoiding stalled transactions --                        /
	//                                                            /	
	//    When the DBError event executes, your current           /
	//    transaction is still open, meaning that portions of     /
	//    the database are locked. If accessing a single-user     /
	//    database (such as this application's SQL Anywhere       /
	//    database ANCHRBAY.DB) that isn't a concern. But in a    /
	//    multi-user environment, it can affect performance       /
	//    dramatically.                                           /
	//                                                            /
	//    To avoid performance bottlenecks in the multi-user      /
	//    environment, follow these guidelines when coding your   /
	//    DBError event:                                          /
	//                                                            /
	//    *  End the transaction as quickly as possible once the  /
	//       DBError event executes. Don't code DBError to do     /
	//       any non-critical processing while the transaction    /
	//       remains open.                                        /
	//                                                            /
	//    *  In particular, don't code DBError to display a       /
	//       messagebox before you have performed a rollback or   /
	//       commit. That would potentially stall the transaction /
	//       if the user didn't respond immediately.              /
	//                                                            /
	//    *  Some approaches you might use include:               /
	//                                                            /
	//          > Executing your rollback/commit logic at the     /
	//            start of the DBError event script               /
	//                                                            /
	//          > Posting an event or function from within the    /
	//            DBError event script to display messages or     /
	//            perform non-critical work (as shown in this     /
	//            example)                                        /
	//                                                            /
	///////////////////////////////////////////////////////////////

			
		// Post the user event uevent_dberr_message to display the
		// appropriate error message. This user event takes 4 
		// arguments:
		//
		// * al_errorcode (the DBMS error code, which is available
		//					   in the sqldbcode argument of the DBError 
		//                event)
		//
		// * as_errortext	(the DBMS error text, which is available 
		//                in the sqlerrtext argument of the DBError 
		//                event)				
		//
		// * al_row		   (the error row, which is available in the
		//					   row argument of the DBError event)
		//
		// * adwb_buffer  (the DataWindow buffer, which is available
		//					   in the buffer argument of the DBError event)

this.POST EVENT uevent_dberr_message &
					 (sqldbcode,sqlerrtext,row,buffer)


   ///////////////////////////////////////////////////////////////
	//                                                            /
	//  Suppressing the default messagebox --                     /
	//                                                            /
	//  Finally, return the value 1 from the DBError event to     /
	//  suppress its default error messagebox.                    /
	//                                                            /
	///////////////////////////////////////////////////////////////

RETURN 1

end event

