#tag Interface
Protected Interface ClockEventReceiver
Implements UniqueIDParticipator
	#tag Method, Flags = &h0
		Sub ClockDisplayNameChanged(cdao As Clock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockStarted(cdao As Clock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockStopped(cdao As Clock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClockValueChanged(cdao As Clock)
		  
		End Sub
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
