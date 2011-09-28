#tag Window
Begin ContainerControl ClockGrid
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
		    
		    AddNewClock
		    
		    Return True
		    
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  AddNewClock
		End Sub
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
		Sub AddNewClock()
		  Dim c As New ClockButton
		  c.EmbedWithin Self
		  AddHandler c.ClockStarted, AddressOf ClockStartedHook
		  AddHandler c.ClockStopped, AddressOf ClockStoppedHook
		  AddHandler c.UserWantsClockClosed, AddressOf UserWantsClockClosedHook
		  
		  p_clocks.Append c
		  
		  ResortClocks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClockStartedHook(obj As ClockButton)
		  obj.HasBackColor = True
		  obj.Refresh
		  
		  If Not Keyboard.ShiftKey Then
		    For Each c As ClockButton In p_clocks
		      If Not ( c Is obj ) Then
		        If c.IsPressed Then
		          c.IsPressed = False
		        End If
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClockStoppedHook(obj As ClockButton)
		  obj.HasBackColor = False
		  obj.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPressed(index As Integer) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsPressed(index As Integer, Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(index As Integer) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(index As Integer, Assigns new_value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RepositionClocks()
		  If UBound( p_clocks ) > -1 Then
		    
		    Dim avail_h, avail_h_bkup As Integer = Self.Height
		    Dim avail_w, avail_w_bkup As Integer = Self.Width
		    
		    Dim rows, cols As Integer
		    GetOptimalRowsAndColumns avail_w / avail_h, 1, UBound( p_clocks ) + 1, rows, cols
		    
		    Dim row As Integer = 0
		    Dim col As Integer = 0
		    
		    For idx As Integer = 0 To UBound( p_clocks )
		      
		      If col > 0 Then
		        p_clocks(idx).Left = p_clocks(idx-1).Left + p_clocks(idx-1).Width
		        p_clocks(idx).Top = p_clocks(idx-1).Top
		      ElseIf row > 0 Then
		        p_clocks(idx).Left = 0
		        p_clocks(idx).Top = p_clocks(idx-1).Top + p_clocks(idx-1).Height
		      Else
		        p_clocks(idx).Left = 0
		        p_clocks(idx).Top = 0
		      End If
		      
		      p_clocks(idx).Width = avail_w / ( cols - col )
		      p_clocks(idx).Height = avail_h / ( rows - row )
		      
		      col = col + 1
		      avail_w = avail_w - p_clocks(idx).Width
		      
		      If col >= cols Then
		        
		        col = 0
		        avail_w = avail_w_bkup
		        
		        row = row + 1
		        avail_h = avail_h - p_clocks(idx).Height
		        
		      End If
		      
		      #if TargetWin32 then
		        p_clocks(idx).Refresh
		      #endif
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ResortClocks()
		  RepositionClocks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UserWantsClockClosedHook(obj As ClockButton)
		  For idx As Integer = UBound( p_clocks ) DownTo 0
		    If p_clocks(idx) Is obj Then
		      
		      p_clocks.Remove idx
		      
		    End If
		  Next
		  
		  obj.Close
		  
		  RepositionClocks
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CompareButtons(button1 As Integer, button2 As Integer, ByRef result As Integer) As Boolean
	#tag EndHook


	#tag Property, Flags = &h1
		Protected p_clocks(-1) As ClockButton
	#tag EndProperty


#tag EndWindowCode

