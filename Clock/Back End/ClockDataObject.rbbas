#tag Class
Protected Class ClockDataObject
	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_clock = New DurationKFS
		  p_displayname = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(other As ClockDataObject)
		  If other Is Nil Then
		    
		    p_clock = New DurationKFS
		    p_displayname = ""
		    
		  Else
		    
		    p_clock = New DurationKFS( other.p_clock, True )
		    p_displayname = other.p_displayname
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Return p_displayname
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  p_displayname = new_value
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

	#tag Property, Flags = &h1
		Protected p_displayname As String
	#tag EndProperty


End Class
#tag EndClass
