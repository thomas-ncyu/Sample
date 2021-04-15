using System;

namespace Sample.Web.WebForm
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        /// <summary>
        /// https://www.webcodeexpert.com/2016/02/bootstrap-modal-dialog-popup-example-in.html
        /// https://www.jqueryscript.net/demo/Bootstrap-4-Modal-Wrapper/
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            //Write the code here to delete the record
            litMsg.Text = "Record deleted successfully";
        }
    }
}