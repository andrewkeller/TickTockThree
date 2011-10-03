#tag Class
Protected Class VolatileClock
Implements Clock
	#tag Method, Flags = &h0
		Sub AttachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the Clock interface.
		  
		  If Not p_autoupdate_obj_pool.HasClockEventReceiver( cer ) Then
		    
		    App.Log "VolatileClock<" + Str( p_id ) + ">: attaching ClockEventReceiver<" + Str( cer.ObjectID ) + ">."
		    
		    p_autoupdate_obj_pool.AttachClockEventReceiver cer
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_autoupdate_obj_pool = New WeakClockEventReceiverSet
		  p_clock = New DurationKFS
		  p_displayname = "Untitled Clock"
		  p_id = GetUniqueIndexKFS
		  
		  App.Log "VolatileClock<" + Str( p_id ) + ">: initializing."
		  
		  GlobalClockSet.AddClock Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(other As VolatileClock)
		  p_autoupdate_obj_pool = New WeakClockEventReceiverSet
		  Dim other_id_str As String
		  
		  If other Is Nil Then
		    
		    p_clock = New DurationKFS
		    p_displayname = "Untitled Clock"
		    other_id_str = "Nil"
		    
		  Else
		    
		    p_clock = New DurationKFS( other.p_clock, True )
		    p_displayname = other.p_displayname
		    other_id_str = Str( other.p_id )
		    
		  End If
		  
		  p_id = GetUniqueIndexKFS
		  
		  App.Log "VolatileClock<" + Str( p_id ) + ">: initializing as a clone of Clock<" + Str( other.p_id ) + ">."
		  
		  GlobalClockSet.AddClock Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  App.Log "VolatileClock<" + Str( p_id ) + ">: deallocating."
		  
		  GlobalClockSet.RemoveClock Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DetachClockEventReceiver(cer As ClockEventReceiver)
		  // Part of the Clock interface.
		  
		  If p_autoupdate_obj_pool.HasClockEventReceiver( cer ) Then
		    
		    App.Log "VolatileClock<" + Str( p_id ) + ">: detaching ClockEventReceiver<" + Str( cer.ObjectID ) + ">."
		    
		    p_autoupdate_obj_pool.DetachClockEventReceiver cer
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Return p_displayname
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  If StrComp( p_displayname, new_value, 0 ) <> 0 Then
		    
		    App.Log "VolatileClock<" + Str( p_id ) + ">: changing display name to '" + new_value + "'."
		    
		    p_displayname = new_value
		    
		    p_autoupdate_obj_pool.NotifyClockDisplayNameChanged Me
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoldsStrongReferencesToClockEventReceivers() As Boolean
		  // Part of the Clock interface.
		  
		  Return p_autoupdate_obj_pool.HoldsStrongReferencesToClockEventReceivers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning() As Boolean
		  Return p_clock.IsRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsRunning(Assigns new_value As Boolean)
		  If p_clock.IsRunning <> new_value Then
		    
		    p_clock.IsRunning = new_value
		    
		    If new_value Then
		      
		      App.Log "VolatileClock<" + Str( p_id ) + ">: changing state to name to running."
		      
		      p_autoupdate_obj_pool.NotifyClockStarted Me
		      
		    Else
		      
		      App.Log "VolatileClock<" + Str( p_id ) + ">: changing state to name to stopped."
		      
		      p_autoupdate_obj_pool.NotifyClockStopped Me
		      
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Int64
		  // Part of the UniqueIDParticipator interface.
		  
		  Return p_id
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  IsRunning = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  IsRunning = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As DurationKFS
		  Return New DurationKFS( p_clock, True )
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_autoupdate_obj_pool As ClockEventReceiverSet
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_clock As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_displayname As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_id As Int64
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
