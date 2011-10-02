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
		  
		  p_clocks.Append New WeakRef( c )
		  
		  ResortClocks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClockStartedHook(obj As ClockButton)
		  obj.HasBackColor = True
		  obj.Refresh
		  
		  If Not Keyboard.ShiftKey Then
		    For Each w As WeakRef In p_clocks
		      Dim c As ClockButton = ClockButton( w.Value )
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
		      Dim clk As ClockButton = ClockButton( p_clocks(idx).Value )
		      Dim clkm1 As ClockButton = Nil
		      If idx > 0 Then clkm1 = ClockButton( p_clocks(idx-1).Value )
		      
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
		Event CompareClocks(button1 As Integer, button2 As Integer, ByRef result As Integer) As Boolean
	#tag EndHook


	#tag Property, Flags = &h1
		Protected p_clocks(-1) As WeakRef
	#tag EndProperty


#tag EndWindowCode

