using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace TropicalServer.UI
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();

            SqlCommand cmd = new SqlCommand("update [tblTropicalUser] set password = '" 
                + txtpass.Text +
                "' where LoginID = '" + txtid.Text + "'", sqlcon);

            cmd.ExecuteNonQuery();
            Response.Redirect("UserLogin.aspx/?userName=" + txtid.Text);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            txtid.Text = "";
            txtpass.Text = "";
            txtpass_again.Text = "";
        }
    }
}