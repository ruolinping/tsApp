using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace WcfHostTablet
{
    class Program
    {
        static void Main(string[] args)
        {
            ServiceHost sh = new ServiceHost(typeof(WcfServiceTablet.Service1));
            sh.Open();
            Console.WriteLine("server started");
            Console.ReadLine();
        }
    }
}
