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
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   260359578
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "TickTockThree"
   Visible         =   True
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
	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler


#tag EndWindowCode

#tag Events ClockGrid1
	#tag Event
		Function CompareButtons(button1 As Integer, button2 As Integer, ByRef result As Integer) As Boolean
		  // For all nodes, sort lexicographically
		  
		  result = StrComp( Me.Label( button1 ), Me.Label( button2 ), 1 )
		  
		  Return True
		  
		End Function
	#tag EndEvent
#tag EndEvents
