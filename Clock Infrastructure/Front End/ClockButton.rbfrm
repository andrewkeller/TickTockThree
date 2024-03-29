#tag Window
Begin ContainerControl ClockButton Implements ClockEventReceiver
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
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  base.Append New MenuItem( "Destroy Clock" )
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If hitItem.Text = "Destroy Clock" Then
		    
		    Dim c As Clock = Self.Clock
		    If Not ( c Is Nil ) Then
		      
		      App.Log "ClockButton<" + Str( p_id ) + ">: user wants to destroy this clock button.  Associated clock: Clock<" + Str( c.ObjectID ) + ">."
		      
		      RaiseEvent UserWantsClockClosed
		      
		    End If
		    
		    Return True
		    
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function ClkDesc() As String
		  Dim c As Clock = Self.Clock
		  If c Is Nil Then
		    
		    Return "was showing Clock<" + Str( p_severed_clock_id ) + ">"
		    
		  Else
		    
		    Return "is showing Clock<" + Str( c.ObjectID ) + ">"
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clock() As Clock
		  If Not ( p_clock_strongref Is Nil ) Then
		    
		    Return p_clock_strongref
		    
		  ElseIf Not ( p_clock_weakref Is Nil ) Then
		    
		    Dim v As Variant = p_clock_weakref.Value
		    
		    If v IsA Clock Then Return Clock( v )
		    
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockDisplayNameChanged(cdao As Clock)
		  // Part of the ClockEventReceiver interface.
		  
		  Dim c As Clock = Self.Clock
		  If Not ( c Is Nil ) Then
		    
		    #if TargetWin32 then
		      bvlAction.Caption = c.DisplayName.ReplaceAll( "&", "&&" )
		    #else
		      bvlAction.Caption = c.DisplayName
		    #endif
		    
		    RaiseEvent DisplayNameChanged
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockStarted(cdao As Clock)
		  // Part of the ClockEventReceiver interface.
		  
		  bvlAction.Value = True
		  tmrRefresh.Mode = Timer.ModeMultiple
		  RefreshLabel
		  RaiseEvent ClockStarted
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockStopped(cdao As Clock)
		  // Part of the ClockEventReceiver interface.
		  
		  bvlAction.Value = False
		  tmrRefresh.Mode = Timer.ModeOff
		  RefreshLabel
		  RaiseEvent ClockStopped
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockValueChanged(cdao As Clock)
		  // Part of the ClockEventReceiver interface.
		  
		  RefreshLabel
		  RaiseEvent ValueChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  App.Log "ClockButton<" + Str( Self.ObjectID ) + ">: received Close instruction (" + ClkDesc + ")."
		  Super.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_id = GetUniqueIndexKFS
		  Super.Constructor
		  p_clock_strongref = New VolatileClock
		  p_clock_weakref = Nil
		  p_severed_clock_id = p_clock_strongref.ObjectID
		  App.Log "ClockButton<" + Str( Self.ObjectID ) + ">: initializing with Clock<" + Str( p_clock_strongref.ObjectID ) + ">."
		  Self.Clock.AttachClockEventReceiver Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(cdao As Clock, use_hard_reference As Boolean)
		  p_id = GetUniqueIndexKFS
		  Super.Constructor
		  If use_hard_reference Then
		    p_clock_strongref = cdao
		  Else
		    p_clock_weakref = New WeakRef( cdao )
		  End If
		  p_severed_clock_id = cdao.ObjectID
		  App.Log "ClockButton<" + Str( Self.ObjectID ) + ">: initializing with Clock<" + Str( cdao.ObjectID ) + ">."
		  Self.Clock.AttachClockEventReceiver Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  App.Log "ClockButton<" + Str( Self.ObjectID ) + ">: deallocating (" + ClkDesc + ")."
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Dim c As Clock = Self.Clock
		  If Not ( c Is Nil ) Then
		    
		    Return c.DisplayName
		    
		  End If
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  Dim c As Clock = Self.Clock
		  If Not ( c Is Nil ) Then
		    
		    c.DisplayName = new_value
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferenceToTheClock() As Boolean
		  Return Not ( p_clock_strongref Is Nil )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPressed() As Boolean
		  Dim c As Clock = Self.Clock
		  If Not ( c Is Nil ) Then
		    
		    Return c.IsRunning
		    
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsPressed(Assigns new_value As Boolean)
		  Dim c As Clock = Self.Clock
		  If Not ( c Is Nil ) Then
		    
		    c.IsRunning = new_value
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Int64
		  // Part of the UniqueIDParticipator interface.
		  
		  Return p_id
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshLabel()
		  Dim c As Clock = Self.Clock
		  If Not ( c Is Nil ) Then
		    
		    lblTotalTime.Text = c.Value.FormatAsHHMMSS
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SeverReferenceToClock()
		  Dim c As Clock = Self.Clock
		  If c Is Nil Then
		    
		    App.Log "ClockButton<" + Str( Self.ObjectID ) + ">: already severed from Clock<" + Str( p_severed_clock_id ) + ">."
		    
		  Else
		    
		    App.Log "ClockButton<" + Str( Self.ObjectID ) + ">: severing the reference to Clock<" + Str( c.ObjectID ) + ">."
		    p_severed_clock_id = c.ObjectID
		    p_clock_strongref = Nil
		    p_clock_weakref = Nil
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As DurationKFS
		  Dim c As Clock = Self.Clock
		  If Not ( c Is Nil ) Then
		    
		    Return c.Value
		    
		  End If
		  
		  Return New DurationKFS
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ClockStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ClockStopped()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DisplayNameChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UserWantsClockClosed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged()
	#tag EndHook


	#tag Property, Flags = &h1
		Protected p_clock_strongref As Clock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_clock_weakref As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_id As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_severed_clock_id As Int64
	#tag EndProperty


#tag EndWindowCode

#tag Events bvlAction
	#tag Event
		Sub Action()
		  Self.IsPressed = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lblTotalTime
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  base.Append New MenuItem( "Change Name..." )
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If hitItem.Text = "Change Name..." Then
		    
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
