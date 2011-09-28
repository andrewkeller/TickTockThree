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

	#tag Method, Flags = &h0
		Sub GetOptimalRowsAndColumns(area_aspect_ratio As Integer, cell_aspect_ratio As Double, cell_count As Integer, ByRef optimal_rows As Integer, ByRef optimal_cols As Integer)
		  If cell_count > 1 Then
		    
		    Dim r, c As Integer
		    
		    c = 1
		    r = cell_count
		    
		    Dim calc_ratio As Double = cell_aspect_ratio * ( c / r )
		    optimal_cols = c
		    optimal_rows = r
		    
		    Dim ratio_diff As Double = Abs( calc_ratio - area_aspect_ratio )
		    Dim best_ratio_diff As Double = ratio_diff
		    
		    Do
		      
		      c = c + 1
		      r = Ceil( cell_count / c )
		      
		      calc_ratio = cell_aspect_ratio * ( c / r )
		      ratio_diff = Abs( calc_ratio - area_aspect_ratio )
		      
		      If ratio_diff < best_ratio_diff Then
		        
		        best_ratio_diff = ratio_diff
		        optimal_cols = c
		        optimal_rows = r
		        
		      Else
		        Exit
		      End If
		    Loop
		    
		  Else
		    
		    optimal_rows = 1
		    optimal_cols = 1
		    
		  End If
		End Sub
	#tag EndMethod


	#tag Constant, Name = kDefaultActiveClockColor, Type = Color, Dynamic = False, Default = \"&c00D000", Scope = Public
	#tag EndConstant


End Module
#tag EndModule
