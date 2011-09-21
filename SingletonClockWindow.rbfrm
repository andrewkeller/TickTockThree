#tag Window
Begin Window SingletonClockWindow
   BackColor       =   "#ClockGlobals.kDefaultActiveClockColor"
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   2.34e+2
   ImplicitInstance=   False
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
   Title           =   "Singleton Clock Window"
   Visible         =   False
   Width           =   2.4e+2
   Begin ClockButton ClockButton1
      AcceptFocus     =   ""
      AcceptTabs      =   True
      AutoDeactivate  =   True
      BackColor       =   &hFFFFFF
      Backdrop        =   ""
      Enabled         =   True
      EraseBackground =   True
      HasBackColor    =   False
      Height          =   212
      HelpTag         =   ""
      InitialParent   =   ""
      Left            =   14
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   8
      UseFocusRing    =   ""
      Visible         =   True
      Width           =   212
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

#tag Events ClockButton1
	#tag Event
		Sub LabelChanged()
		  Self.Title = Trim( Me.DisplayName ) + " Timer"
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClockStarted()
		  Self.HasBackColor = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClockStopped()
		  Self.HasBackColor = False
		End Sub
	#tag EndEvent
#tag EndEvents
