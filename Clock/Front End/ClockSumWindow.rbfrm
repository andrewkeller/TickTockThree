#tag Window
Begin Window ClockSumWindow Implements ClockSetEventReceiver, ClockEventReceiver
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
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
   Title           =   "Sum of the Clocks"
   Visible         =   False
   Width           =   600
   Begin Listbox lstCats
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   True
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   ""
      EnableDragReorder=   ""
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   300
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Sum"
      Italic          =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollBarVertical=   True
      SelectionType   =   1
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   46
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   268
      _ScrollWidth    =   -1
   End
   Begin Listbox lstClocks
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   True
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   ""
      EnableDragReorder=   ""
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   300
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Sum"
      Italic          =   ""
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollBarVertical=   True
      SelectionType   =   1
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   46
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   280
      _ScrollWidth    =   -1
   End
   Begin Label Label1
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
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      Text            =   "Categories"
      TextAlign       =   0
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   268
   End
   Begin Label Label2
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
      Left            =   300
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      Text            =   "Timers"
      TextAlign       =   0
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   280
   End
   Begin BevelButton BevelButton1
      AcceptFocus     =   False
      AutoDeactivate  =   True
      BackColor       =   &c000000
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   "+"
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   22
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
      LockRight       =   ""
      LockTop         =   False
      MenuValue       =   0
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c000000
      TextFont        =   "System"
      TextSize        =   ""
      TextUnit        =   0
      Top             =   358
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   22
   End
   Begin BevelButton BevelButton2
      AcceptFocus     =   False
      AutoDeactivate  =   True
      BackColor       =   &h000000
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   "-"
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   22
      HelpTag         =   ""
      Icon            =   ""
      IconAlign       =   0
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   41
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      MenuValue       =   0
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   ""
      TextUnit        =   0
      Top             =   358
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   22
   End
   Begin Label lblSum
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   True
      TabIndex        =   6
      TabPanelIndex   =   0
      Text            =   "Sum: something"
      TextAlign       =   2
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   358
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   280
   End
   Begin Timer tmrRefresh
      Height          =   32
      Index           =   -2147483648
      Left            =   664
      LockedInPosition=   False
      Mode            =   2
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
		Sub Close()
		  ClockDataObject.UnregisterForClockSetUpdates Self
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  ClockDataObject.RegisterForClockSetUpdates Self
		  UpdateSum
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ClockCreated(cdao As ClockDataObject)
		  // Part of the ClockSetEventReceiver interface.
		  
		  If Not ( cdao Is Nil ) Then
		    
		    lstClocks.AddRow cdao.DisplayName
		    lstClocks.RowTag( lstClocks.LastIndex ) = cdao
		    lstClocks.Cell( lstClocks.LastIndex, 1 ) = cdao.Value.ShortHumanReadableStringValue( DurationKFS.kSeconds )
		    
		    cdao.RegisterForClockObjectUpdates Self
		    
		    lstClocks.Sort
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockDestroyed(cdao As ClockDataObject)
		  // Part of the ClockSetEventReceiver interface.
		  
		  For row As Integer = lstClocks.ListCount -1 DownTo 0
		    If lstClocks.RowTag( row ) Is cdao Then
		      
		      lstClocks.RemoveRow row
		      
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockMessageUpdated(cdao As ClockDataObject)
		  // Part of the ClockEventReceiver interface.
		  
		  For idx As Integer = lstClocks.ListCount -1 DownTo 0
		    
		    If ClockDataObject( lstClocks.RowTag( idx ) ) Is cdao Then
		      
		      lstClocks.Cell( idx, 0 ) = cdao.DisplayName
		      
		    End If
		  Next
		  
		  lstClocks.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockValueUpdated(cdao As ClockDataObject)
		  // Part of the ClockEventReceiver interface.
		  
		  UpdateNumbers
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateNumbers()
		  Dim something_changed As Boolean = False
		  
		  For idx As Integer = lstClocks.ListCount -1 DownTo 0
		    
		    Dim cdao As ClockDataObject = ClockDataObject( lstClocks.RowTag( idx ) )
		    
		    If cdao.IsRunning Then
		      
		      lstClocks.Cell( idx, 1 ) = cdao.Value.ShortHumanReadableStringValue( DurationKFS.kSeconds )
		      something_changed = True
		      
		    End If
		  Next
		  
		  If something_changed Then
		    
		    lstClocks.Sort
		    
		    UpdateSum
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateSum()
		  Dim count_only_selected As Boolean = lstClocks.SelCount > 0
		  
		  Dim sum As New DurationKFS
		  
		  For idx As Integer = lstClocks.ListCount -1 DownTo 0
		    
		    If Not count_only_selected Or lstClocks.Selected( idx ) Then
		      
		      sum = sum + ClockDataObject( lstClocks.RowTag( idx ) ).Value
		      
		    End If
		  Next
		  
		  lblSum.Text = "Sum: " + sum.ShortHumanReadableStringValue( DurationKFS.kSeconds )
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events lstClocks
	#tag Event
		Sub Change()
		  UpdateSum
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tmrRefresh
	#tag Event
		Sub Action()
		  UpdateNumbers
		End Sub
	#tag EndEvent
#tag EndEvents
