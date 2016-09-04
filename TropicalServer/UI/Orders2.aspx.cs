using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using TropicalServer.ServiceReference1;

namespace TropicalServer.UI
{
    public partial class Orders2 : System.Web.UI.Page
    {
        TropicalServer.BLL.OrdersBLL obj = new BLL.OrdersBLL();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                DataSet ds = obj.GetUserOrders_BLL();
                Cache.Insert("ds", ds);
                GridViewOrders.DataSource = ds;
                GridViewOrders.DataBind();
                ddlSalesManager.DataSource = obj.GetSalesManager_BBL();
                ddlSalesManager.DataTextField = "CustRouteRep";
                ddlSalesManager.DataValueField = "CustRouteRep";
                ddlSalesManager.DataBind();
                ddlSalesManager.Items.Insert(0, new ListItem(String.Empty, String.Empty));
                ddlSalesManager.SelectedIndex = 0;
            }
        }
        protected void GridViewOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void GridViewOrders_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewOrders.EditIndex = e.NewEditIndex;
            GridViewOrders.DataSource = Cache.Get("ds");
            GridViewOrders.DataBind();
        }

        protected void GridViewOrders_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridViewOrders.Rows[e.RowIndex];
            TextBox box = (TextBox)row.FindControl("trackNoEdit");
            String trackNo = box.Text;
            box = (TextBox)row.FindControl("OrderDatesEdit");
            String date = box.Text;
            //test.Text = date;
            obj.UpdateRow_BBL(GridViewOrders.DataKeys[e.RowIndex].Value.ToString(), trackNo, date);
            GridViewOrders.EditIndex = -1;
            filter();
        }

        protected void ddlOrderDate_TextChanged(object sender, EventArgs e)
        {
            filter();
        }

        protected void GridViewOrders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewOrders.EditIndex = -1;
            GridViewOrders.DataSource = Cache.Get("ds");
            GridViewOrders.DataBind();
        }

        protected void GridViewOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            obj.DeleteRow_BBL(GridViewOrders.DataKeys[e.RowIndex].Value.ToString());

            GridViewOrders.EditIndex = -1;
        }

        protected void txtID_TextChanged(object sender, EventArgs e)
        {
            ViewState.Add("CID", txtID.Text);
            filter();
        }
        private void filter()
        {
            String date = ddlOrderDate.Text;
            String id = txtID.Text;
            String name = txtCName.Text;
            String rep = ddlSalesManager.Text;
            DataSet ds = obj.filter_BBL(date, id, name, rep);
            Cache.Remove("ds");
            Cache.Insert("ds", ds);
            labelCID.Text = "CID: " +(String) ViewState["CID"];
            GridViewOrders.DataSource = Cache.Get("ds");
            GridViewOrders.DataBind();
        }

        protected void txtCName_TextChanged(object sender, EventArgs e)
        {
            filter();
        }

        protected void ddlSalesManager_TextChanged(object sender, EventArgs e)
        {
            filter();
        }

        protected void GridViewOrders_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = GridViewOrders.SelectedRow;
            Label trackNo = (Label)row.FindControl("OrderTrackingNumber");
            Label orderDate = (Label)row.FindControl("OrderDates");
            Label cID = (Label)row.FindControl("OrderCustomerNumber");
            Label cName = (Label)row.FindControl("CustName");
            Label address = (Label)row.FindControl("Address");
            Label routeNo = (Label)row.FindControl("OrderRouteNumber");
            txtPanel.Text = "Order track No: " + trackNo.Text
                + "<br/>Order Date: " + orderDate.Text
                + "<br/> Customer ID: " + cID.Text
                + "<br/> Customer Name: " + cName.Text
                + "<br/> Address: " + address.Text
                + "<br/> Route No: " + routeNo.Text + "<br/>";
            mp1.Show();
        }

        [WebMethod]
        public static List<String> getAutoCompleteName(String s)
        {
            autoCompleteSoapClient obj = new autoCompleteSoapClient();
            ArrayOfString a = obj.getAutoCompleteName2(s);
            List<string> l = new List<string>();

            foreach (string ss in a)
            {
                l.Add(ss);
            }
            return l;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public static List<String> getAutoCompleteID(String prefixText)
        {
            TropicalServer.BLL.OrdersBLL obj2 = new BLL.OrdersBLL();
            return obj2.getAutoCompleteID_BLL(prefixText);
        }
    }
}