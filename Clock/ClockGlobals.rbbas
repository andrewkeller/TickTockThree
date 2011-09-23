#tag Module
Protected Module ClockGlobals
	#tag Method, Flags = &h0
		Function FormatAsHHMMSS(Extends d As DurationKFS) As String
		  Dim h, m, s As Integer
		  Dim cursor As DurationKFS = d
		  
		  h = cursor.IntegerValue( DurationKFS.kHours )
		  
		  cursor = cursor - New DurationKFS( h, DurationKFS.kHours )
		  
		  m = cursor.IntegerValue( DurationKFS.kMinutes )
		  
		  cursor = cursor - New DurationKFS( m, DurationKFS.kMinutes )
		  
		  s = cursor.IntegerValue( DurationKFS.kSeconds )
		  
		  Return Format( h, "00" ) + " : " + Format( m, "00" ) + " : " + Format( s, "00" )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kDefaultActiveClockColor, Type = Color, Dynamic = False, Default = \"&c00D000", Scope = Public
	#tag EndConstant


End Module
#tag EndModule
