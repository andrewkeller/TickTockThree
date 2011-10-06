#tag Interface
Protected Interface ClockSetEventReceiverSet
Implements UniqueIDParticipator
	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasClockSetEventReceiver(cser As ClockSetEventReceiver) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockSetEventReceivers() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockAdded(cset As ClockSet, cdao As Clock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockRemoved(cset As ClockSet, cdao As Clock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockSetDestroyed(cset As ClockSet)
		  
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
