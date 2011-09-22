#tag Window
Begin ContainerControl ClockButton
   AcceptFocus     =   ""
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   "#ClockGlobals.kDefaultActiveClockColor"
   Backdrop        =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   212
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   32
   LockBottom      =   ""
   LockLeft        =   ""
   LockRight       =   ""
   LockTop         =   ""
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   32
   UseFocusRing    =   False
   Visible         =   True
   Width           =   212
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
      Left            =   6
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
      Top             =   6
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
      Left            =   6
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
      Top             =   162
      Transparent     =   True
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
      Top             =   24
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  Super.Constructor
		  p_clock = New ClockDataObject
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Return p_clock.DisplayName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  p_clock.DisplayName = new_value
		  bvlAction.Caption = new_value
		  RaiseEvent LabelChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HandleClockStateChanged()
		  If p_clock.IsRunning Then
		    
		    p_clock.Start
		    tmrRefresh.Mode = Timer.ModeMultiple
		    RefreshLabel
		    RaiseEvent ClockStarted
		    
		  Else
		    
		    p_clock.Stop
		    tmrRefresh.Mode = Timer.ModeOff
		    RefreshLabel
		    RaiseEvent ClockStopped
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPressed() As Boolean
		  Return p_clock.IsRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsPressed(Assigns new_value As Boolean)
		  p_clock.IsRunning = new_value
		  bvlAction.Value = new_value
		  HandleClockStateChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshLabel()
		  Dim h, m, s As Integer
		  Dim cursor As DurationKFS = p_clock.Value
		  
		  h = cursor.IntegerValue( DurationKFS.kHours )
		  
		  cursor = cursor - New DurationKFS( h, DurationKFS.kHours )
		  
		  m = cursor.IntegerValue( DurationKFS.kMinutes )
		  
		  cursor = cursor - New DurationKFS( m, DurationKFS.kMinutes )
		  
		  s = cursor.IntegerValue( DurationKFS.kSeconds )
		  
		  lblTotalTime.Text = Format( h, "00" ) + " : " + Format( m, "00" ) + " : " + Format( s, "00" )
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ClockStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ClockStopped()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LabelChanged()
	#tag EndHook


	#tag Property, Flags = &h1
		Protected p_clock As ClockDataObject
	#tag EndProperty


#tag EndWindowCode

#tag Events bvlAction
	#tag Event
		Sub Action()
		  p_clock.IsRunning = Me.Value
		  HandleClockStateChanged
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lblTotalTime
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  base.Append New MenuItem( "Change name..." )
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If hitItem.Text = "Change name..." Then
		    
		    Dim new_name As String = Self.DisplayName
		    
		    If EnterStringWindow.GetString( "Change name", "Please enter the new name for this window:", new_name ) Then
		      
		      Self.DisplayName = new_name
		      
		    End If
		    
		    Return True
		    
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tmrRefresh
	#tag Event
		Sub Action()
		  RefreshLabel
		End Sub
	#tag EndEvent
#tag EndEvents
