#tag Class
Protected Class SimpleLogger
Implements PushingLogger
	#tag Method, Flags = &h0
		Sub AttachIncrementallyUpdatableLogView(v As IncrementallyUpdatableLogView)
		  // Part of the PushingLogger interface.
		  
		  If Not ( v Is Nil ) Then
		    If p_view_inc.IndexOf( v ) < 0 Then
		      
		      p_view_inc.Append v
		      
		      Dim cursor As NodeKFS = p_log_oldest
		      
		      While Not ( cursor Is Nil )
		        
		        v.NotifyLogEntryAdded cursor.Value.StringValue
		        
		        cursor = cursor.Right
		        
		      Wend
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachIncrementallyUpdatableLogView(v As IncrementallyUpdatableLogView)
		  // Part of the PushingLogger interface.
		  
		  For row As Integer = UBound( p_view_inc ) DownTo 0
		    If p_view_inc( row ) Is v Then
		      
		      p_view_inc.Remove row
		      
		      Exit
		      
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(msg As String)
		  // Part of the Logger interface.
		  
		  Dim d As New Date
		  msg = d.SQLDateTime + " " + msg
		  
		  Dim new_node As New NodeKFS
		  new_node.Value = msg
		  
		  If p_log_oldest Is Nil Then
		    
		    p_log_oldest = new_node
		    p_log_newest = new_node
		    
		  Else
		    
		    p_log_newest.Right = new_node
		    p_log_newest = new_node
		    
		  End If
		  
		  p_log_size = p_log_size + LenB( msg )
		  
		  For Each view As IncrementallyUpdatableLogView In p_view_inc
		    
		    view.NotifyLogEntryAdded msg
		    
		  Next
		  
		  While p_log_size > kMaxLogSize
		    
		    p_log_size = p_log_size - LenB( p_log_oldest.Value.StringValue )
		    p_log_oldest = p_log_oldest.Right
		    
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogEntriesExpireAtMaxLogSize() As Boolean
		  // Part of the Logger interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogIsCycledAtMaxLogSize() As Boolean
		  // Part of the Logger interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogSize() As UInt64
		  // Part of the Logger interface.
		  
		  Return p_log_size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxLogSize() As UInt64
		  // Part of the Logger interface.
		  
		  Return kMaxLogSize
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_log_newest As NodeKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_log_oldest As NodeKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_log_size As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_view_inc() As IncrementallyUpdatableLogView
	#tag EndProperty


	#tag Constant, Name = kMaxLogSize, Type = Double, Dynamic = False, Default = \"100000000", Scope = Protected
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
End Class
#tag EndClass
