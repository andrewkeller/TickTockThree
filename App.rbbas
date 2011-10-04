#tag Class
Protected Class App
Inherits Application
Implements Logger
	#tag Event
		Function CancelClose() As Boolean
		  Dim grp_cnt, sng_cnt As Integer = 0
		  
		  For idx As Integer = WindowCount -1 DownTo 0
		    
		    If Window( idx ) IsA ClockWindow Then
		      
		      grp_cnt = grp_cnt + 1
		      
		    ElseIf Window( idx ) IsA SingletonClockWindow Then
		      
		      sng_cnt = sng_cnt + 1
		      
		    End If
		  Next
		  
		  If sng_cnt > 1 Then
		    
		    If Not AskReviewChangesWindow.GetUserChoice( "", _
		      "You have "+Str(sng_cnt)+" singleton clock windows open.  Would you like to merge them into documents before exiting?", _
		      "Singleton clock windows cannot be saved on their own.  If you do not merge them into a document, their data will be lost.", _
		      p_user_wants_to_save_singleton_windows ) Then
		      
		      Return True
		      
		    End If
		  End If
		  
		  Return False
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  ClockGlobals.DestroyGlobalClockSet
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  p_log = New SimpleLogger
		  p_user_wants_to_save_singleton_windows = True
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DebugShowLog() As Boolean Handles DebugShowLog.Action
			If p_log Is Nil Then
			
			MsgBox "Sorry, but I cannot show you a log view, because the logger is not initialized."
			
			ElseIf p_log IsA PushingLogger Then
			
			Dim w As New SimpleLogWindow
			
			w.Show
			
			PushingLogger( p_log ).AttachIncrementallyUpdatableLogView w
			
			End If
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNewClockSet() As Boolean Handles FileNewClockSet.Action
			Dim w As New ClockWindow
			w.Show
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNewSingletonClockWindow() As Boolean Handles FileNewSingletonClockWindow.Action
			Dim w As New SingletonClockWindow
			w.Show
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StatisticsSumOfTheClocks() As Boolean Handles StatisticsSumOfTheClocks.Action
			Dim w As New ClockSumWindow
			w.Show
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub Log(msg As String)
		  // Part of the Logger interface.
		  
		  If Not ( p_log Is Nil ) Then
		    
		    p_log.Log msg
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogEntriesExpireAtMaxLogSize() As Boolean
		  // Part of the Logger interface.
		  
		  If p_log Is Nil Then
		    
		    Return True
		    
		  Else
		    
		    Return p_log.LogEntriesExpireAtMaxLogSize
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogIsCycledAtMaxLogSize() As Boolean
		  // Part of the Logger interface.
		  
		  If p_log Is Nil Then
		    
		    Return True
		    
		  Else
		    
		    Return p_log.LogIsCycledAtMaxLogSize
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogSize() As UInt64
		  // Part of the Logger interface.
		  
		  If p_log Is Nil Then
		    
		    Return 0
		    
		  Else
		    
		    Return p_log.LogSize
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxLogSize() As UInt64
		  // Part of the Logger interface.
		  
		  If p_log Is Nil Then
		    
		    Return 0
		    
		  Else
		    
		    Return p_log.MaxLogSize
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserWantsToSaveSingletonWindows() As Boolean
		  Return p_user_wants_to_save_singleton_windows
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_log As Logger
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_user_wants_to_save_singleton_windows As Boolean
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
