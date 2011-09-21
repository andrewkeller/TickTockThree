#tag Window
Begin ContainerControl ClockGrid
   AcceptFocus     =   ""
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   223
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   32
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   32
   UseFocusRing    =   ""
   Visible         =   True
   Width           =   685
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim c1 As New ClockButton
		  c1.EmbedWithin Self, 20, 14
		  c1.DisplayName = "SFS"
		  
		  Dim c2 As New ClockButton
		  c2.EmbedWithin Self, c1.Left + c1.Width + 12, 14
		  c2.DisplayName = "Multiboard"
		  
		  Dim c3 As New ClockButton
		  c3.EmbedWithin Self, c2.Left + c2.Width + 12, 14
		  c3.DisplayName = "HHS"
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function IsPressed(index As Integer) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsPressed(index As Integer, Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(index As Integer) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(index As Integer, Assigns new_value As String)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CompareButtons(button1 As Integer, button2 As Integer, ByRef result As Integer) As Boolean
	#tag EndHook


#tag EndWindowCode

