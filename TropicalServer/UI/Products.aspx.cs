using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace TropicalServer.UI
{
    public partial class Products : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
                SqlConnection sqlcon = new SqlConnection(con);
                sqlcon.Open();
                SqlCommand cmd = new SqlCommand("EXEC SelectItemType", sqlcon);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                Repeater1.DataSource = ds;
                Repeater1.DataBind();

                cmd = new SqlCommand("EXEC SelectItem", sqlcon);
                SqlDataAdapter da2 = new SqlDataAdapter(cmd);
                DataSet ds2 = new DataSet();
                da2.Fill(ds2);
                Cache.Insert("tbItem", ds2);
                itemGrid.DataSource = ds2;
                itemGrid.DataBind();

                sqlcon.Close();
            }
        }

        private void LoadGridData(int n)
        {
            DataSet ds = (DataSet)Cache.Get("tbItem");
            DataRow[] foundRows;
            foundRows = ds.Tables[0].Select("ItemType = " + n);
            DataTable table = ds.Tables[0].Clone();
            foreach (DataRow r in foundRows)
            {
                table.ImportRow(r);
            }
            itemGrid.DataSource = table;
            itemGrid.DataBind();
        }
        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            
            int intemNo = Int32.Parse(e.CommandArgument.ToString());

            Cache.Remove("intemNo");
            Cache.Insert("intemNo", intemNo);
            itemGrid.PageIndex = 0;
            LoadGridData(intemNo);

            /*
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("select [ItemNumber],[ItemDescription],PrePrice, concat(cast([ItemUnits] as varchar(50)), 'x', cast([ItemWeights] as varchar(50)), ' oz' ) as SIZE from tblItem where ItemType = " + intemNo, sqlcon);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            */

            //itemGrid.PageIndex = 0;


            //itemGrid.DataKeyNames =  "ItemNumber" ;

            //sqlcon.Close();
        }

        protected void itemGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            itemGrid.PageIndex = e.NewPageIndex;
            if (Cache.Get("intemNo") == null)
            {
                DataSet ds = (DataSet)Cache.Get("tbItem");
                itemGrid.DataSource = ds;
                itemGrid.DataBind();
            }
            else 
            LoadGridData((int) Cache.Get("intemNo"));
        }
    }
}