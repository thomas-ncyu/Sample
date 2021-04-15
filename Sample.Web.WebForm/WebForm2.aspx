<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="Sample.Web.WebForm.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function getConfirmation(sender, title, message) {
            $("#spnTitle").text(title);
            $("#spnMsg").text(message);
            $('#modalPopUp').modal('show');
            $('#btnConfirm').attr('onclick', "$('#modalPopUp').modal('hide');setTimeout(function(){" + $(sender).prop('href') + "}, 50);");
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="modalPopUp" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">
                                <span id="spnTitle"></span>
                            </h4>
                        </div>
                        <div class="modal-body">
                            <p>
                                <span id="spnMsg"></span>.
                            </p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="button" id="btnConfirm" class="btn btn-danger">
                                Yes, please</button>
                        </div>
                    </div>
                </div>
            </div>

            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-danger" OnClientClick="return getConfirmation(this, 'Please confirm','Are you sure you want to delete?');" OnClick="lnkDelete_Click"><i class="glyphicon glyphicon-trash"></i>&nbsp;Delete</asp:LinkButton>
            <br />
            <asp:Literal ID="litMsg" runat="server"></asp:Literal>
        </div>
    </form>
</body>
</html>