#tag Class
Protected Class ClockDataObject
	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  p_clock = New DurationKFS
		  p_displayname = "Untitled Clock"
		  p_id = NextUniqueInteger
		  
		  RegisterObject Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(other As ClockDataObject)
		  If other Is Nil Then
		    
		    p_clock = New DurationKFS
		    p_displayname = "Untitled Clock"
		    
		  Else
		    
		    p_clock = New DurationKFS( other.p_clock, True )
		    p_displayname = other.p_displayname
		    
		  End If
		  
		  p_id = NextUniqueInteger
		  
		  RegisterObject Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  UnregisterObject Me
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Return p_displayname
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayName(Assigns new_value As String)
		  p_displayname = new_value
		  
		  For Each t As ClockEventReceiver In p_autoupdate_obj_pool
		    
		    t.ClockMessageUpdated Me
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning() As Boolean
		  Return p_clock.IsRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsRunning(Assigns new_value As Boolean)
		  p_clock.IsRunning = new_value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function NextUniqueInteger() As Int64
		  Static counter As Int64 = 0
		  
		  counter = counter + 1
		  
		  Return counter
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterForClockObjectUpdates(target As ClockEventReceiver)
		  If Not ( target Is Nil ) Then
		    
		    p_autoupdate_obj_pool.Append target
		    
		    target.ClockMessageUpdated Me
		    target.ClockValueUpdated Me
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub RegisterForClockSetUpdates(target As ClockSetEventReceiver)
		  If Not ( target Is Nil ) Then
		    
		    p_autoupdate_set_pool.Append target
		    
		    For Each v As Variant In p_cdao_pool.Values
		      
		      Try
		        
		        target.ClockCreated ClockDataObject( WeakRef( v ).Value )
		        
		      Catch err As RuntimeException
		        ReRaiseRBFrameworkExceptionsKFS err
		        
		        MsgBox "Uh oh...  While pushing all new clocks to a clock sum window, an exception of type "+Introspection.GetType(err).Name+" was encountered:" _
		        + EndOfLine + EndOfLine + err.Message + " (error code " + Str( err.ErrorNumber ) + ")"
		        
		      End Try
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub RegisterObject(cdao As ClockDataObject)
		  If Not ( cdao Is Nil ) Then
		    
		    If p_cdao_pool Is Nil Then p_cdao_pool = New Dictionary
		    
		    p_cdao_pool.Value( cdao.p_id ) = New WeakRef( cdao )
		    
		    For Each t As ClockSetEventReceiver In p_autoupdate_set_pool
		      t.ClockCreated cdao
		    Next
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  p_clock.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  p_clock.Stop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnregisterForClockObjectUpdates(target As ClockEventReceiver)
		  For idx As Integer = UBound( p_autoupdate_obj_pool ) DownTo 0
		    
		    If p_autoupdate_obj_pool(idx) Is Nil Or p_autoupdate_obj_pool(idx) Is target Then p_autoupdate_obj_pool.Remove idx
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub UnregisterForClockSetUpdates(target As ClockSetEventReceiver)
		  For idx As Integer = UBound( p_autoupdate_set_pool ) DownTo 0
		    
		    If p_autoupdate_set_pool(idx) Is Nil Or p_autoupdate_set_pool(idx) Is target Then p_autoupdate_set_pool.Remove idx
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub UnregisterObject(cdao As ClockDataObject)
		  If Not ( cdao Is Nil ) Then
		    
		    If Not ( p_cdao_pool Is Nil ) Then
		      
		      p_cdao_pool.Remove cdao.p_id
		      
		    End If
		    
		    For Each t As ClockSetEventReceiver In p_autoupdate_set_pool
		      t.ClockDestroyed cdao
		    Next
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As DurationKFS
		  Return New DurationKFS( p_clock )
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_autoupdate_obj_pool() As ClockEventReceiver
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared p_autoupdate_set_pool() As ClockSetEventReceiver
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared p_cdao_pool As Dictionary
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


End Class
#tag EndClass
