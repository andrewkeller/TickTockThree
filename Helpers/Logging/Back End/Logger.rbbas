#tag Interface
Protected Interface Logger
	#tag Method, Flags = &h0
		Sub Log(msg As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogEntriesExpireAtMaxLogSize() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogIsCycledAtMaxLogSize() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogSize() As UInt64
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxLogSize() As UInt64
		  
		End Function
	#tag EndMethod


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
End Interface
#tag EndInterface
