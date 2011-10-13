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
		Sub AddNewVolatileClock(interactive As Boolean = True)
		  Dim c As New VolatileClock
		  Dim new_name As String = c.DisplayName
		  
		  If Not interactive Or EnterStringWindow.GetString( "New Clock", "Please enter the new name for a new clock:", new_name ) Then
		    
		    c.DisplayName = new_name
		    
		    p_clockset.AddClock c
		    
		  End If
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
		  
		  Dim clkbtn As New ClockButton( cdao, False )
		  
		  p_clock_button_order.Insert GetInsertionPointOfNewButton( clkbtn ), clkbtn.ObjectID
		  
		  p_clock_buttons.Value( clkbtn.ObjectID ) = New WeakRef( clkbtn )
		  
		  clkbtn.EmbedWithin Self
		  AddHandler clkbtn.DisplayNameChanged, WeakAddressOf ClockDisplayNameChangedHook
		  AddHandler clkbtn.ClockStarted, WeakAddressOf ClockStartedHook
		  AddHandler clkbtn.ClockStopped, WeakAddressOf ClockStoppedHook
		  AddHandler clkbtn.UserWantsClockClosed, WeakAddressOf UserWantsClockClosedHook
		  
		  RepositionClocks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClockDisplayNameChangedHook(clkbtn As ClockButton)
		  ResortButtons
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
		Sub ClockSetDestroyed(cset As ClockSet)
		  // Part of the ClockSetEventReceiver interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClockStartedHook(clkbtn As ClockButton)
		  clkbtn.HasBackColor = True
		  clkbtn.Refresh
		  
		  Dim clk As Clock = clkbtn.Clock
		  
		  If Not Keyboard.AsyncShiftKey Then
		    For Each c As Clock In p_clockset.ListClocks
		      If Not ( c Is clk ) Then
		        If c.IsRunning Then
		          c.Stop
		        End If
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClockStoppedHook(clkbtn As ClockButton)
		  clkbtn.HasBackColor = False
		  clkbtn.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_id = GetUniqueIndexKFS
		  
		  ReDim p_clock_button_order(-1)
		  
		  p_clock_buttons = New Dictionary
		  
		  p_clockset = New StrongClockSet
		  p_clockset.AttachClockSetEventReceiver Self
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DefaultClockComparator(button1id As Int64, button2id As Int64, ByRef result As Integer) As Boolean
		  If Not RaiseEvent CompareClocks( button1id, button2id, result ) Then
		    
		    result = StrComp( Me.ButtonDisplayName( button1id ), Me.ButtonDisplayName( button2id ), 1 )
		    
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetInsertionPointOfNewButton(clkbtn As ClockButton) As Integer
		  Return GetInsertionPointOfNewButton( clkbtn, p_clock_button_order )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetInsertionPointOfNewButton(clkbtn As ClockButton, button_order() As Int64) As Integer
		  Dim greater_than_index, less_than_index As Integer
		  
		  greater_than_index = -1
		  less_than_index = UBound( button_order ) + 1
		  
		  While less_than_index - greater_than_index > 1
		    
		    Dim split_at As Integer = ( greater_than_index + less_than_index ) / 2
		    
		    Dim split_onto As Integer
		    
		    If Not DefaultClockComparator( button_order(split_at), clkbtn.ObjectID, split_onto ) Then
		      App.Log CurrentMethodName.Replace( ".", "<" + Str( p_id ) + ">." ) + ": error while finding the insertion index: the comparator did not report an answer when comparing against index " + Str( split_at ) + "."
		      Return split_at + 1
		    End If
		    
		    If split_onto > 0 Then
		      greater_than_index = split_onto
		    ElseIf split_onto < 0 Then
		      less_than_index = split_onto
		    Else
		      Return split_onto + 1
		    End If
		    
		  Wend
		  
		  Return less_than_index
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

