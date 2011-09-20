#tag Window
Begin Window SingletonClockWindow
   BackColor       =   &hFFFFFF
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
   Visible         =   True
   Width           =   2.4e+2
   Begin BevelButton bvlAction
      AcceptFocus     =   False
      AutoDeactivate  =   True
      BackColor       =   "&c000000"
      Bevel           =   3
      Bold            =   False
      ButtonType      =   1
      Caption         =   "Project Title"
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   144
      HelpTag         =   ""
      Icon            =   ""
      IconAlign       =   0
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MenuValue       =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   "&c000000"
      TextFont        =   "System"
      TextSize        =   25
      TextUnit        =   0
      Top             =   14
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   200
   End
   Begin Label lblTotalTime
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   44
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   ""
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      Text            =   "Time"
      TextAlign       =   1
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   17
      TextUnit        =   0
      Top             =   170
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   200
   End
   Begin Timer tmrRefresh
      Height          =   32
      Index           =   -2147483648
      Left            =   281
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   14
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  p_clock = New DurationKFS
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Sub RefreshLabel()
		  Dim h, m, s As Integer
		  Dim cursor As DurationKFS = p_clock
		  
		  h = cursor.IntegerValue( DurationKFS.kHours )
		  
		  cursor = cursor - New DurationKFS( h, DurationKFS.kHours )
		  
		  m = cursor.IntegerValue( DurationKFS.kMinutes )
		  
		  cursor = cursor - New DurationKFS( m, DurationKFS.kMinutes )
		  
		  s = cursor.IntegerValue( DurationKFS.kSeconds )
		  
		  lblTotalTime.Text = Format( h, "00" ) + " : " + Format( m, "00" ) + " : " + Format( s, "00" )
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_clock As DurationKFS
	#tag EndProperty


#tag EndWindowCode

#tag Events bvlAction
	#tag Event
		Sub Action()
		  If Me.Value Then
		    
		    p_clock.Start
		    tmrRefresh.Mode = Timer.ModeMultiple
		    
		  Else
		    
		    p_clock.Stop
		    tmrRefresh.Mode = Timer.ModeOff
		    RefreshLabel
		    
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tmrRefresh
	#tag Event
		Sub Action()
		  RefreshLabel
		End Sub
	#tag EndEvent
#tag EndEvents
