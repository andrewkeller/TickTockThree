#tag Window
Begin Window SimpleLogWindow Implements IncrementallyUpdatableLogView
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
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
   Title           =   "Application Log"
   Visible         =   False
   Width           =   600
   Begin TextArea txtOut
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   400
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   0
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      ScrollbarHorizontal=   True
      ScrollbarVertical=   True
      Styled          =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "Courier"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   600
   End
   Begin Timer tmrRefresh
      Height          =   32
      Index           =   -2147483648
      Left            =   672
      LockedInPosition=   False
      Mode            =   0
      Period          =   0
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   14
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub NotifyLogEntryAdded(msg As String)
		  // Part of the IncrementallyUpdatableLogView interface.
		  
		  If Not ( tmrRefresh Is Nil ) Then
		    
		    p_new_entries.Append msg
		    
		    If tmrRefresh.Mode <> Timer.ModeSingle Then tmrRefresh.Mode = Timer.ModeSingle
		    
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_new_entries() As String
	#tag EndProperty


#tag EndWindowCode

#tag Events tmrRefresh
	#tag Event
		Sub Action()
		  If Not ( txtOut Is Nil ) Then
		    If UBound( p_new_entries ) > -1 Then
		      
		      txtOut.AppendText Join( p_new_entries, EndOfLine ) + EndOfLine
		      
		      ReDim p_new_entries(-1)
		      
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
