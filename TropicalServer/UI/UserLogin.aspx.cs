using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace TropicalServer.Styles
{
    public partial class UserLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack && Response.Cookies["userName"].Value != null)
                txtid.Text = Response.Cookies["userName"].Value;
            string v = Request.QueryString["userName"];
            if (v != null)
                txtid.Text = v;

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();

            SqlCommand cmd = new SqlCommand("select CONCAT(FirstName, ' ',LastName) from [tblTropicalUser] where LoginID ='" + txtid.Text +
                "' and Password = '" + txtpass.Text + "'", sqlcon);

            String s = (String) cmd.ExecuteScalar();
            if (s == null)
            {
                Response.Redirect("UserLogin.aspx");
            }
            else
            {
                Session["name"] = s;
                if (chkremember.Checked == true)
                {
                       Response.Cookies["userName"].Value = txtid.Text;
                       Response.Cookies["userName"].Expires = DateTime.Now.AddDays(1);
                }
                //Response.Redirect("UserWelcome.aspx");
                System.Web.Security.FormsAuthentication.RedirectFromLoginPage(txtid.Text, chkremember.Checked);

            }
            sqlcon.Close();
        }
    }
}