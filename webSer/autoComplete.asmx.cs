using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Xml;

namespace webSer
{
    /// <summary>
    /// Summary description for autoComplete
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class autoComplete : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public List<String> getAutoCompleteName(String word)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("GetAutoComplete", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "Name";
            cmd.Parameters.Add("@word", SqlDbType.VarChar).Value = word;
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet toReturn = new DataSet();
            da.Fill(toReturn);
            String s = toReturn.Tables[0].Rows[0].ToString();
            List<String> ss = new List<string>();
            ss.Add(s);
            return ss;
        }

        [WebMethod]

        public List<String> getAutoCompleteName2(String word)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("GetAutoComplete", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "Name";
            cmd.Parameters.Add("@word", SqlDbType.VarChar).Value = word;
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet toReturn = new DataSet();
            da.Fill(toReturn);
            List<String> ss = new List<string>();
            foreach (DataRow dr in toReturn.Tables[0].Rows)
            {
                ss.Add(Convert.ToString(dr["CustName"]));
            }
           
            return ss;
        }
    }
}
