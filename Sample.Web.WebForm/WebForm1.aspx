<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Sample.Web.WebForm.WebForm1" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Loading Content in Bootstrap 4 Modal Body via Ajax</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
$(document).ready(function(){
    $("#myModal").on("show.bs.modal", function(event){
        // Place the returned HTML into the selected element
        $(this).find(".modal-body").load("/examples/php/remote.php");
    });
});
    </script>
    <style>
        .bs-example {
            margin: 20px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="bs-example">
            <!-- Button HTML (to Trigger Modal) -->
            <button type="button" class="btn btn-lg btn-primary" data-toggle="modal" data-target="#myModal">Launch Demo Modal</button>

            <!-- Modal HTML -->
            <div id="myModal" class="modal fade" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Ajax Loading Demo</h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <!-- Content will be loaded here from "remote.php" file -->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">OK, Got it!</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>