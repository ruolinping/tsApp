using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace TropicalServer.BLL
{
    public class OrdersBLL
    {
        TropicalServer.DAL.OrdersDAL obj = new DAL.OrdersDAL();
        public DataSet GetUserOrders_BLL()
        {
            return (obj.GetCustomersOrders_DAL());
        }

        public void UpdateRow_BBL(String id, String trackNo, String date)
        {
            obj.UpdateRow_DAL(id,trackNo, date);
        }

        public DataSet GetSalesManager_BBL()
        {
            return obj.GetSalesManager_DAL();
        }

        public DataSet GetOrdersOnOrderDate_BBL(String s)
        {
            return obj.GetOrdersOnOrderDate_DAL(s);
        }
        public DataSet GetOrdersOnCID_BBL(String s)
        {
            return obj.GetOrdersOnCID_DAL(s);
        }
        public void DeleteRow_BBL(String s)
        {
           obj.DeleteRow_DAL(s);
        }

        public DataSet filter_BBL(String date,String id,String name, String rep)
        {
            return obj.filter_DAL(date, id, name, rep);
        }

        public List<String> getAutoCompleteID_BLL(String s)
        {
            DataSet ds = obj.getAutoCompleteID_DAL(s);
            List<String> ss = new List<string>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ss.Add(Convert.ToString(dr["CustNumber"]));
            }
            return ss;
        }
    }
}
