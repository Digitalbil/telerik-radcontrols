Imports Telerik.Web.UI

Partial Class DefaultVB
    Inherits System.Web.UI.Page

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub

    Protected Sub requiredValidator_ServerValidate(source As Object, args As ServerValidateEventArgs)
        'There are no selected files
        If upload.UploadedFiles.Count = 0 Then
            args.IsValid = False
        End If

        'Selected files don't match the specified extension
        For Each file As UploadedFile In upload.UploadedFiles
            If Not file.GetExtension() = ".jpg" Then
                args.IsValid = False
            End If
        Next
    End Sub

    Protected Sub rbSubmit_Click(sender As Object, e As EventArgs)
        If Page.IsValid Then
            Dim target As String = Server.MapPath("~/Uploads/")
            For Each file As UploadedFile In upload.UploadedFiles
                Dim fileName As String = file.FileName
                Dim fullFileName As String = target & fileName
                file.SaveAs(fullFileName)
            Next
        End If
    End Sub

End Class
