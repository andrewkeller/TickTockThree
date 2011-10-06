#tag Class
Protected Class StrongSetBaseCode
Implements UniqueIDParticipator
	#tag Method, Flags = &h1
		Protected Sub Add(obj As UniqueIDParticipator)
		  If obj Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf p_strongpool_by_uid.HasKey( obj.ObjectID ) Then
		    
		    // Do nothing.
		    
		  Else
		    
		    p_strongpool_by_uid.Value( obj.ObjectID ) = obj
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_id = GetUniqueIndexKFS
		  p_strongpool_by_uid = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Has(obj As UniqueIDParticipator) As Boolean
		  If obj Is Nil Then
		    
		    Return False
		    
		  Else
		    
		    Return p_strongpool_by_uid.HasKey( obj.ObjectID )
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function List() As UniqueIDParticipator()
		  Dim result(-1) As UniqueIDParticipator
		  
		  For Each k As Variant In p_strongpool_by_uid.Keys
		    Dim is_valid As Boolean = False
		    
		    Dim v As Variant = p_strongpool_by_uid.Value( k )
		    If v IsA UniqueIDParticipator Then
		      Dim obj As UniqueIDParticipator = UniqueIDParticipator( v )
		      
		      result.Append obj
		      is_valid = True
		      
		    End If
		    
		    If Not is_valid Then p_strongpool_by_uid.Remove k
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
		    
		  ElseIf p_strongpool_by_uid.HasKey( obj.ObjectID ) Then
		    
		    p_strongpool_by_uid.Remove obj.ObjectID
		    
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_id As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_strongpool_by_uid As Dictionary
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
