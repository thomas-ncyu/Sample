<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="Sample.Web.WebForm.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript">

    //顯示視窗前呼叫
    $("#ooo").on("show.bs.modal", function (e) {
        console.log('顯示視窗前呼叫');
    });

    //轉場特效結束，已完全呈現時呼叫
    $("#ooo").on("shown.bs.modal", function (e) {
        console.log('轉場特效結束，已完全呈現時呼叫');
    });

    //關閉視窗前呼叫
    $("#ooo").on("hide.bs.modal", function (e) {
        console.log('關閉視窗前呼叫');
    });

    //轉場特效結束，已完全隱藏時呼叫
    $("#ooo").on("hidden.bs.modal", function (e) {
        console.log('轉場特效結束，已完全隱藏時呼叫');
    });

    //隱藏視窗
    $("#ooo").modal('hide');

    //開啟視窗
    $("#ooo").modal('show');

    //切換視窗顯示、不顯示
    $("#ooo").modal('toggle');

    //判斷視窗是否開啟中
    if ($("#ooo").hasClass('in')) {
        console.log('視窗目前是開啟的狀態..');
    }
</script>
<body>
    <form id="form1" runat="server">

        <!--
  「data-backdrop="static"」 鎖定背景，點擊背景時不自動關閉視窗
  「fade」 淡入、淡出的轉場效果
  「modal-lg」視窗大小，如modal-lg、modal-md、modal-sm
  「data-dismiss="modal"」 關閉視窗
  「data-keyboard="true"」 是否用ESC鍵關閉，預設為true
-->
        <div id="ooo" class="modal inmodal fade" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span>&times;</span>
                        </button>
                        <div class="modal-title ">
                            標題列
                        </div>
                    </div>
                    <div class="modal-body">
                        內容
                    </div>
                    <div class="modal-footer">
                        <button class="btn">OK</button>
                        <button class="btn">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 使用按鈕開啟  data-target-->
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ooo">...</button>
    </form>
</body>
</html>