Attribute VB_Name = "Module1"
Sub new1()
Dim osld As Slide
Dim lngCount As Long
'insert the real name instead of Picture 2
Const PicName As String = "Text Box 13"
On Error Resume Next
For Each osld In ActivePresentation.Slides
For lngCount = osld.Shapes.Count To 1 Step -1
If osld.Shapes(lngCount).Name = PicName Then osld.Shapes(lngCount).Delete
osld.Shapes(PicName).Delete
Next lngCount
Next osld
End Sub
