using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TropicalServer.DAL
{
    public class OrdersDAL
    {
        public DataSet GetCustomersOrders_DAL()
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("exec SelectCustomersOrders", sqlcon);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            sqlcon.Close();
            return ds;
        }

        public void UpdateRow_DAL(String id, String trackNo, String date)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("UpdateRowOrders", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
            cmd.Parameters.Add("@trackNo", SqlDbType.VarChar).Value = trackNo;
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = date;
            cmd.ExecuteNonQuery();
            sqlcon.Close();
        }

        public DataSet GetSalesManager_DAL()
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("exec SelectSalesManager", sqlcon);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            sqlcon.Close();
            return ds;
        }

        public DataSet GetOrdersOnOrderDate_DAL(String s)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("GetOrdersOnOrderDate", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@s", SqlDbType.VarChar).Value = s;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            sqlcon.Close();
            return ds;
        }

        public DataSet GetOrdersOnCID_DAL(String s)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("GetOrdersOnCID", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@s", SqlDbType.VarChar).Value = s;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            sqlcon.Close();
            return ds;
        }

        public void DeleteRow_DAL(String s)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("DeleteRow", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = s;
            cmd.ExecuteNonQuery();
            sqlcon.Close();
        }

        public DataSet filter_DAL(String date, String id, String name, String rep) {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("filter", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = date;
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
            cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
            cmd.Parameters.Add("@rep", SqlDbType.VarChar).Value = rep;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            sqlcon.Close();
            return ds;
        }

        public DataSet getAutoCompleteID_DAL(String s)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("GetAutoComplete", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "CustNum";
            cmd.Parameters.Add("@word", SqlDbType.VarChar).Value = s;
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet toReturn = new DataSet();
            da.Fill(toReturn);
            sqlcon.Close();
            return toReturn;
        }
    }
}
