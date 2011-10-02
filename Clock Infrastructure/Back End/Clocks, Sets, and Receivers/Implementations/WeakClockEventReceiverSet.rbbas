#tag Class
Protected Class WeakClockEventReceiverSet
Inherits WeakSetBaseCode
Implements ClockEventReceiverSet
	#tag Method, Flags = &h0
		Sub AttachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the ClockEventReceiverSet interface.
		  
		  Me.Add cer
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the ClockEventReceiverSet interface.
		  
		  Me.Remove cer
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockEventReceivers() As Boolean
		  // Part of the ClockEventReceiverSet interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListEventReceivers() As ClockEventReceiver()
		  Dim result() As ClockEventReceiver
		  
		  For Each u As UniqueIDParticipator In Me.List
		    
		    result.Append ClockEventReceiver( u )
		    
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockDisplayNameChanged(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      er.ClockDisplayNameChanged cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockStarted(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      er.ClockStarted cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockStopped(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      er.ClockStopped cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockValueChanged(cdo As Clock)
		  // Part of the ClockEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockEventReceiver In Me.ListEventReceivers
		      
		      er.ClockValueChanged cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
