Attribute VB_Name = "Module2"
Sub deletePix()
Dim osld As Slide
'insert the real name instead of Picture 2
Const PicName As String = "Subtitle 4"
On Error Resume Next
For Each osld In ActivePresentation.Slides
osld.Shapes(PicName).Delete
Next osld
End Sub
