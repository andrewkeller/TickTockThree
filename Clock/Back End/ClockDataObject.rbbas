#tag Class
Protected Class ClockDataObject
	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_clock = New DurationKFS
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(other As ClockDataObject)
		  If other Is Nil Then
		    
		    p_clock = New DurationKFS
		    
		  Else
		    
		    p_clock = New DurationKFS( other.p_clock, True )
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  p_clock.MicrosecondsValue = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  p_clock.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  p_clock.Stop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As DurationKFS
		  Return New DurationKFS( p_clock )
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_clock As DurationKFS
	#tag EndProperty


End Class
#tag EndClass
