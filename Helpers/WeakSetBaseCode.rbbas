#tag Class
Protected Class WeakSetBaseCode
Implements UniqueIDParticipator
	#tag Method, Flags = &h1
		Protected Sub Add(obj As UniqueIDParticipator)
		  If obj Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf p_weakpool_by_uid.HasKey( obj.ObjectID ) Then
		    
		    // Do nothing.
		    
		  Else
		    
		    p_weakpool_by_uid.Value( obj.ObjectID ) = New WeakRef( obj )
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_id = GetUniqueIndexKFS
		  p_weakpool_by_uid = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Has(obj As UniqueIDParticipator) As Boolean
		  If obj Is Nil Then
		    
		    Return False
		    
		  Else
		    
		    Return p_weakpool_by_uid.HasKey( obj.ObjectID )
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function List() As UniqueIDParticipator()
		  Dim result(-1) As UniqueIDParticipator
		  
		  For Each k As Variant In p_weakpool_by_uid.Keys
		    Dim is_valid As Boolean = False
		    
		    Dim v As Variant = p_weakpool_by_uid.Value( k )
		    If v IsA WeakRef Then
		      Dim w As WeakRef = WeakRef( v )
		      If w.Value IsA UniqueIDParticipator Then
		        Dim obj As UniqueIDParticipator = UniqueIDParticipator( w.Value )
		        
		        result.Append obj
		        is_valid = True
		        
		      End If
		    End If
		    
		    If Not is_valid Then p_weakpool_by_uid.Remove k
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Int64
		  // Part of the UniqueIDParticipator interface.
		  
		  Return p_id
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Remove(obj As UniqueIDParticipator)
		  If obj Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf p_weakpool_by_uid.HasKey( obj.ObjectID ) Then
		    
		    p_weakpool_by_uid.Remove obj.ObjectID
		    
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_id As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_weakpool_by_uid As Dictionary
	#tag EndProperty


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
