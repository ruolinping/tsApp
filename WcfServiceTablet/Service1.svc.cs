using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfServiceTablet
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service1 : IService1
    {


        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }

        public DataSet getItemsandCustomers(DateTime syncDate)
        {
            String con = System.Configuration.ConfigurationManager.ConnectionStrings["rping"].ConnectionString;
            SqlConnection sqlcon = new SqlConnection(con);
            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("GetItemsandCustomers", sqlcon);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@syncDate", SqlDbType.DateTime).Value = syncDate;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            sqlcon.Close();
            return ds;
        }
    }
}
