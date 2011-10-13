#tag Window
Begin Window ClockWindow
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   246
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   260359578
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "TickTockThree"
   Visible         =   False
   Width           =   700
   Begin ClockGrid ClockGrid1
      AcceptFocus     =   ""
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &hFFFFFF
      Backdrop        =   ""
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   224
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   14
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   8
      UseFocusRing    =   ""
      Visible         =   True
      Width           =   672
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  If MsgBox( "This program cannot currently save any changes.  Are you sure you would like to close this window?", 1 + 16 ) = 2 Then
		    
		    Return True
		    
		  End If
		  
		  Return False
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler


#tag EndWindowCode

#tag Events ClockGrid1
	#tag Event
		Function CompareClocks(clock1 As Clock, clock2 As Clock, ByRef result As Integer) As Boolean
		  // For all nodes, sort lexicographically
		  
		  If clock1.DisplayName < clock2.DisplayName Then
		    result = -1
		  ElseIf clock1.DisplayName > clock2.DisplayName Then
		    result = 1
		  Else
		    result = 0
		  End If
		  
		  Return True
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.AddNewVolatileClock False
		End Sub
	#tag EndEvent
#tag EndEvents
