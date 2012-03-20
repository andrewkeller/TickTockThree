#tag Module
Protected Module ClockGlobals
	#tag Method, Flags = &h1
		Protected Sub DestroyGlobalClockSet()
		  p_global_clock_set = Nil
		End Sub
	#tag EndMethod

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
		Sub GetOptimalRowsAndColumnsBasedOnAspectRatio(area_aspect_ratio As Integer, cell_aspect_ratio As Double, cell_count As Integer, ByRef optimal_rows As Integer, ByRef optimal_cols As Integer)
		  If cell_count > 1 Then
		    
		    Dim r, c As Integer
		    
		    optimal_cols = 1
		    optimal_rows = cell_count
		    
		    Dim best_ratio_diff As Double = Abs( ( cell_aspect_ratio * (1/cell_count) ) - area_aspect_ratio )
		    
		    For c = 1 To cell_count / 2 Step 1
		      
		      r = Ceil( cell_count / c )
		      
		      Dim calc_ratio As Double = cell_aspect_ratio * (c/r)
		      Dim ratio_diff As Double = Abs( calc_ratio - area_aspect_ratio )
		      
		      If ratio_diff < best_ratio_diff Then
		        
		        best_ratio_diff = ratio_diff
		        optimal_cols = c
		        optimal_rows = r
		        
		      End If
		      
		      calc_ratio = cell_aspect_ratio * (r/c)
		      ratio_diff = Abs( calc_ratio - area_aspect_ratio )
		      
		      If ratio_diff < best_ratio_diff Then
		        
		        best_ratio_diff = ratio_diff
		        optimal_cols = r
		        optimal_rows = c
		        
		      End If
		    Next
		  Else
		    
		    optimal_rows = 1
		    optimal_cols = 1
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GlobalClockSet() As ClockSet
		  If p_global_clock_set Is Nil Then p_global_clock_set = New WeakClockSet
		  
		  Return p_global_clock_set
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private p_global_clock_set As ClockSet
	#tag EndProperty


	#tag Constant, Name = kDefaultActiveClockColor, Type = Color, Dynamic = False, Default = \"&c00D000", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
