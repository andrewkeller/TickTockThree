#tag Window
Begin ContainerControl ClockGrid Implements ClockSetEventReceiver
   AcceptFocus     =   ""
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   223
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   32
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   32
   UseFocusRing    =   ""
   Visible         =   True
   Width           =   685
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  base.Append New MenuItem( "Add Clock" )
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If hitItem.Text = "Add Clock" Then
		    
		    AddNewVolatileClock
		    
		    Return True
		    
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Resized()
		  RepositionClocks
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  RepositionClocks
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddNewVolatileClock()
		  p_clockset.AddClock New VolatileClock
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ButtonDisplayName(id As Int64) As String
		  Return ClockButton( WeakRef( p_clock_buttons.Value( id ) ).Value ).DisplayName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ButtonDisplayName(id As Int64, Assigns new_value As String)
		  ClockButton( WeakRef( p_clock_buttons.Value( id ) ).Value ).DisplayName = new_value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ButtonIsRunning(id As Int64) As Boolean
		  Return ClockButton( WeakRef( p_clock_buttons.Value( id ) ).Value ).IsPressed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ButtonIsRunning(id As Int64, Assigns new_value As Boolean)
		  ClockButton( WeakRef( p_clock_buttons.Value( id ) ).Value ).IsPressed = new_value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ButtonValue(id As Int64) As DurationKFS
		  Return ClockButton( WeakRef( p_clock_buttons.Value( id ) ).Value ).Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockAdded(cset As ClockSet, cdao As Clock)
		  // Part of the ClockSetEventReceiver interface.
		  
		  Dim clkbtn As New ClockButton( cdao )
		  
		  p_clock_button_order.Insert GetInsertionPointOfNewButton( clkbtn ), clkbtn.ObjectID
		  
		  p_clock_buttons.Value( clkbtn.ObjectID ) = New WeakRef( clkbtn )
		  
		  clkbtn.EmbedWithin Self
		  AddHandler clkbtn.UserWantsClockClosed, WeakAddressOf UserWantsClockClosedHook
		  
		  RepositionClocks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockRemoved(cset As ClockSet, cdao As Clock)
		  // Part of the ClockSetEventReceiver interface.
		  
		  // The given clock has been removed from the clock set.
		  
		  // Remove every button that was displaying that clock.
		  
		  For Each clkbtn As ClockButton In ListButtons
		    If clkbtn.Clock Is cdao Then
		      
		      // Remove the button from the buttons Dictionary:
		      
		      p_clock_buttons.Remove clkbtn.ObjectID
		      
		      // Remove the button from the button order array:
		      
		      p_clock_button_order.Remove p_clock_button_order.IndexOf( clkbtn.ObjectID )
		      
		      // Close the button object:
		      
		      clkbtn.Close
		      
		    End If
		  Next
		  
		  // Reposition the buttons:
		  
		  RepositionClocks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_id = GetUniqueIndexKFS
		  
		  ReDim p_clock_button_order(-1)
		  
		  p_clock_buttons = New Dictionary
		  
		  p_clockset = New WeakClockSet
		  p_clockset.AttachClockSetEventReceiver Self
		  
		  Super.Constructor
		  
		  ' AddNewVolatileClock
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetInsertionPointOfNewButton(clkbtn As ClockButton) As Integer
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListButtons() As ClockButton()
		  Dim result() As ClockButton
		  
		  For Each id As Int64 In p_clock_button_order
		    
		    result.Append ClockButton( WeakRef( p_clock_buttons.Value( id ) ).Value )
		    
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Int64
		  // Part of the UniqueIDParticipator interface.
		  
		  Return p_id
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RepositionClocks()
		  Dim buttons() As ClockButton = ListButtons
		  
		  If UBound( buttons ) > -1 Then
		    
		    Dim avail_h, avail_h_bkup As Integer = Self.Height
		    Dim avail_w, avail_w_bkup As Integer = Self.Width
		    
		    Dim rows, cols As Integer
		    GetOptimalRowsAndColumns avail_w / avail_h, 1, UBound( buttons ) + 1, rows, cols
		    
		    Dim row As Integer = 0
		    Dim col As Integer = 0
		    
		    For idx As Integer = 0 To UBound( buttons )
		      Dim clk As ClockButton = buttons(idx)
		      Dim clkm1 As ClockButton = Nil
		      If idx > 0 Then clkm1 = buttons(idx-1)
		      
		      If col > 0 Then
		        clk.Left = clkm1.Left + clkm1.Width
		        clk.Top = clkm1.Top
		      ElseIf row > 0 Then
		        clk.Left = 0
		        clk.Top = clkm1.Top + clkm1.Height
		      Else
		        clk.Left = 0
		        clk.Top = 0
		      End If
		      
		      clk.Width = avail_w / ( cols - col )
		      clk.Height = avail_h / ( rows - row )
		      
		      col = col + 1
		      avail_w = avail_w - clk.Width
		      
		      If col >= cols Then
		        
		        col = 0
		        avail_w = avail_w_bkup
		        
		        row = row + 1
		        avail_h = avail_h - clk.Height
		        
		      End If
		      
		      #if TargetWin32 then
		        clk.Refresh
		      #endif
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResortButtons()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UserWantsClockClosedHook(clkbtn As ClockButton)
		  p_clockset.RemoveClock clkbtn.Clock
		  
		  // This ClockButton is one of the few "critical reference holders"
		  // - that is, when clkbtn deallocates, that very well may cause
		  // the associated Clock to also get deallocated, which would
		  // remove it from the global set and cause other things to happen.
		  
		  // However, I've been having a problem with ClockButtons not
		  // deallocating.  You can imagine the trouble that causes.
		  
		  // So, here's a hack to get around it.  I want the reference
		  // to the Clock lost, so let's lose the reference.
		  
		  clkbtn.SeverReferenceToClock
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CompareClocks(button1id As Int64, button2id As Int64, ByRef result As Integer) As Boolean
	#tag EndHook


	#tag Property, Flags = &h1
		Protected p_clockset As ClockSet
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_clock_buttons As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_clock_button_order() As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_id As Int64
	#tag EndProperty


#tag EndWindowCode

