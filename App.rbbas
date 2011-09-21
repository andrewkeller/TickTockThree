#tag Class
Protected Class App
Inherits Application
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
		  
		  If grp_cnt + sng_cnt > 0 Then
		    
		    Return MsgBox( "This application cannot currently save any changes.  Are you sure you want to quit?", 1 + 48 ) = 2
		    
		  Else
		    
		    Return False
		    
		  End If
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileNewSingletonClockWindow() As Boolean Handles FileNewSingletonClockWindow.Action
			Dim w As New SingletonClockWindow
			w.Show
			Return True
		End Function
	#tag EndMenuHandler


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
