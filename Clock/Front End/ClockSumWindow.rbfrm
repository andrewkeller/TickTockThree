#tag Window
Begin Window ClockSumWindow Implements ClockSetEventReceiver,ClockEventReceiver
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   4.0e+2
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
   Title           =   "Sum of the Clocks"
   Visible         =   False
   Width           =   400
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
      Left            =   20
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
      Width           =   360
      _ScrollWidth    =   -1
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
      Left            =   20
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
      TabStop         =   True
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
      Width           =   360
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
      Left            =   20
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
      TabStop         =   True
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
      Width           =   360
   End
   Begin Timer tmrRefresh
      Enabled         =   True
      Height          =   32
      Index           =   -2147483648
      Left            =   664
      LockedInPosition=   False
      Mode            =   2
      Period          =   1000
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   14
      Visible         =   True
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  ClockDataObject.UnregisterForClockSetUpdates Self
		  
		  For row As Integer = lstClocks.ListCount -1 DownTo 0
		    
		    ClockDataObject.GetObjectByID( lstClocks.RowTag( row ).Int64Value ).UnregisterForClockObjectUpdates( Self )
		    
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  ClockDataObject.RegisterForClockSetUpdates Self
		  RerenderSum
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub ClockCreated(cdao As ClockDataObject)
		  // Part of the ClockSetEventReceiver interface.
		  
		  If Not ( cdao Is Nil ) Then
		    
		    lstClocks.AddRow cdao.DisplayName
		    lstClocks.RowTag( lstClocks.LastIndex ) = cdao.ObjectID
		    lstClocks.CellTag( lstClocks.LastIndex, 1 ) = cdao.Value
		    
		    cdao.RegisterForClockObjectUpdates Self
		    
		    lstClocks.Sort
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockDestroyed(cdao As ClockDataObject)
		  // Part of the ClockSetEventReceiver interface.
		  
		  If Not ( cdao Is Nil ) Then
		    
		    For row As Integer = lstClocks.ListCount -1 DownTo 0
		      
		      If lstClocks.RowTag( row ) = cdao.ObjectID Then
		        
		        lstClocks.RemoveRow row
		        
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockMessageChanged(cdao As ClockDataObject)
		  // Part of the ClockEventReceiver interface.
		  
		  If Not ( cdao Is Nil ) Then
		    
		    For idx As Integer = lstClocks.ListCount -1 DownTo 0
		      
		      If lstClocks.RowTag( idx ) = cdao.ObjectID Then
		        
		        lstClocks.Cell( idx, 0 ) = cdao.DisplayName
		        
		      End If
		    Next
		    
		    lstClocks.Sort
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockStarted(cdao As ClockDataObject)
		  // Part of the ClockEventReceiver interface.
		  
		  If Not ( cdao Is Nil ) Then
		    
		    For idx As Integer = lstClocks.ListCount -1 DownTo 0
		      
		      If lstClocks.RowTag( idx ) = cdao.ObjectID Then
		        
		        lstClocks.CellTag( idx, 1 ) = cdao.Value
		        
		      End If
		    Next
		    
		    lstClocks.Sort
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockStopped(cdao As ClockDataObject)
		  // Part of the ClockEventReceiver interface.
		  
		  If Not ( cdao Is Nil ) Then
		    
		    For idx As Integer = lstClocks.ListCount -1 DownTo 0
		      
		      If lstClocks.RowTag( idx ) = cdao.ObjectID Then
		        
		        lstClocks.CellTag( idx, 1 ) = cdao.Value
		        
		      End If
		    Next
		    
		    lstClocks.Sort
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockValueChanged(cdao As ClockDataObject)
		  // Part of the ClockEventReceiver interface.
		  
		  If Not ( cdao Is Nil ) Then
		    
		    For idx As Integer = lstClocks.ListCount -1 DownTo 0
		      
		      If lstClocks.RowTag( idx ) = cdao.ObjectID Then
		        
		        lstClocks.CellTag( idx, 1 ) = cdao.Value
		        
		      End If
		    Next
		    
		    lstClocks.Sort
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RerenderNumbers()
		  For idx As Integer = lstClocks.ListCount -1 DownTo 0
		    
		    lstClocks.Cell( idx, 1 ) = DurationKFS( lstClocks.CellTag( idx, 1 ) ).FormatAsHHMMSS
		    
		  Next
		  
		  lstClocks.Sort
		  
		  RerenderSum
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RerenderSum()
		  Dim count_only_selected As Boolean = lstClocks.SelCount > 0
		  
		  Dim sum As New DurationKFS
		  
		  For idx As Integer = lstClocks.ListCount -1 DownTo 0
		    
		    If Not count_only_selected Or lstClocks.Selected( idx ) Then
		      
		      sum = sum + DurationKFS( lstClocks.CellTag( idx, 1 ) )
		      
		    End If
		  Next
		  
		  lblSum.Text = "Sum: " + sum.FormatAsHHMMSS
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events lstClocks
	#tag Event
		Sub Change()
		  RerenderSum
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If column = 1 Then
		    
		    Dim d1 As DurationKFS = Me.CellTag( row1, 1 )
		    Dim d2 As DurationKFS = Me.CellTag( row2, 1 )
		    
		    result = d1.Operator_Compare( d2 )
		    
		    Return True
		    
		  End If
		  
		  Return False
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tmrRefresh
	#tag Event
		Sub Action()
		  RerenderNumbers
		End Sub
	#tag EndEvent
#tag EndEvents
