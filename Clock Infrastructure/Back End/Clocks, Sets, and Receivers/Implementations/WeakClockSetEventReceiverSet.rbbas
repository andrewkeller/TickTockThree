#tag Class
Protected Class WeakClockSetEventReceiverSet
Inherits WeakSetBaseCode
Implements ClockSetEventReceiverSet
	#tag Method, Flags = &h0
		Sub AttachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  Me.Add cser
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockSetEventReceiver(cser As ClockSetEventReceiver)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  Me.Remove cser
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockSetEventReceivers() As Boolean
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ListEventReceivers() As ClockSetEventReceiver()
		  Dim result() As ClockSetEventReceiver
		  
		  For Each u As UniqueIDParticipator In Me.List
		    
		    result.Append ClockSetEventReceiver( u )
		    
		  Next
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockAdded(cdo As Clock)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockSetEventReceiver In Me.ListEventReceivers
		      
		      er.ClockAdded cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyClockRemoved(cdo As Clock)
		  // Part of the ClockSetEventReceiverSet interface.
		  
		  If Not ( cdo Is Nil ) Then
		    For Each er As ClockSetEventReceiver In Me.ListEventReceivers
		      
		      er.ClockRemoved cdo
		      
		    Next
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
