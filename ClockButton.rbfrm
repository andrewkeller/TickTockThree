#tag Window
Begin ContainerControl ClockButton
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
   Left            =   32
   LockBottom      =   ""
   LockLeft        =   ""
   LockRight       =   ""
   LockTop         =   ""
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   32
   UseFocusRing    =   ""
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
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   200
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function IsPressed() As Boolean
		  Return bvlAction.Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsPressed(Assigns new_value As Boolean)
		  bvlAction.Value = new_value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return bvlAction.Caption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns new_value As String)
		  bvlAction.Caption = new_value
		End Sub
	#tag EndMethod


#tag EndWindowCode

