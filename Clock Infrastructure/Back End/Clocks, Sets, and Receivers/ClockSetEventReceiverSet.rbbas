#tag Interface
Protected Interface ClockSetEventReceiverSet
	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockSetEventReceivers() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockAdded(cdo As Clock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockRemoved(cdo As Clock)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
