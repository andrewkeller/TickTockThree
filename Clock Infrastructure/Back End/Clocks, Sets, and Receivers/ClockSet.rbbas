#tag Interface
Protected Interface ClockSet
	#tag Method, Flags = &h0
		Sub AddClock(c As Clock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockObjects() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockSetEventReceivers() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveClock(c As Clock)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
