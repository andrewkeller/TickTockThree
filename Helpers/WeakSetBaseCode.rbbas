#tag Class
Protected Class WeakSetBaseCode
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
		Protected p_weakpool_by_uid As Dictionary
	#tag EndProperty


End Class
#tag EndClass
