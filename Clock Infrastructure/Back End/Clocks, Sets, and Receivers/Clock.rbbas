#tag Interface
Protected Interface Clock
Implements UniqueIDParticipator
	#tag Method, Flags = &h0
		Sub AttachClockEventReceiver(cer As ClockEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockEventReceiver(cer As ClockEventReceiver)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockEventReceivers() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsRunning(Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As DurationKFS
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
