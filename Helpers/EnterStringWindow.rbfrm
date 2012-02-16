#tag Window
Begin Window EnterStringWindow
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.47e+2
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   False
   Width           =   5.22e+2
   Begin Label lblPrompt
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      Text            =   "Untitled"
      TextAlign       =   0
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   482
   End
   Begin TextField txtInput
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   0
      Italic          =   ""
      Left            =   20
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   ""
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   46
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   482
   End
   Begin PushButton cmdOK
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   422
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   105
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton cmdCancel
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   330
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   105
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h1
		Protected Function AddInputFieldInstance() As TextField
		  Dim template As TextField = txtInput( p_txtInput_UBound )
		  
		  Dim t As TextField = New txtInput
		  t.Top = template.Top + template.Height + 12
		  t.Width = template.Width
		  t.TabIndex = template.TabIndex + 1
		  
		  cmdCancel.TabIndex = cmdCancel.TabIndex + 1
		  cmdOK.TabIndex = cmdOK.TabIndex + 1
		  
		  Self.Height = Self.Height + t.Height + 12
		  
		  p_txtInput_UBound = p_txtInput_UBound + 1
		  
		  Return t
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function GetString(title As String, prompt As String, ByRef result As String) As Boolean
		  Dim w As New EnterStringWindow
		  
		  w.p_allow_multiples = False
		  w.Title = title
		  w.lblPrompt.Text = prompt
		  w.txtInput(0).Text = result
		  w.txtInput(0).SelectAll
		  
		  w.ShowModal
		  
		  result = w.txtInput(0).Text
		  
		  Dim rtn_val As Boolean = w.p_button_pressed = w.cmdOK
		  
		  w.Close
		  
		  Return rtn_val
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function GetStrings(title As String, prompt As String, ByRef results() As String) As Boolean
		  Dim w As New EnterStringWindow
		  
		  w.p_allow_multiples = True
		  w.Title = title
		  w.lblPrompt.Text = prompt
		  For i As Integer = 0 To UBound( results )
		    If i <= w.p_txtInput_UBound Then
		      w.txtInput(i).Text = results(i)
		    Else
		      w.AddInputFieldInstance.Text = results(i)
		    End If
		  Next
		  w.txtInput(0).SelectAll
		  
		  w.ShowModal
		  
		  ReDim results( w.p_txtInput_UBound )
		  For i As Integer = 0 To UBound( results )
		    results(i) = w.txtInput(i).Text
		  Next
		  
		  Dim rtn_val As Boolean = w.p_button_pressed = w.cmdOK
		  
		  w.Close
		  
		  Return rtn_val
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateButtons()
		  cmdOK.Enabled = txtInput(0).Text <> ""
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		p_allow_multiples As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_button_pressed As PushButton
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_txtInput_UBound As Integer = 0
	#tag EndProperty


#tag EndWindowCode

#tag Events txtInput
	#tag Event
		Function KeyDown(index as Integer, Key As String) As Boolean
		  If p_allow_multiples And index = p_txtInput_UBound And Asc(Key) = 9 And Not Keyboard.ShiftKey And Me.Text <> "" Then
		    AddInputFieldInstance.SetFocus
		    Return True
		  Else
		    UpdateButtons
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events cmdOK
	#tag Event
		Sub Action()
		  p_button_pressed = Me
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events cmdCancel
	#tag Event
		Sub Action()
		  p_button_pressed = Me
		  Self.Hide
		End Sub
	#tag EndEvent
#tag EndEvents
