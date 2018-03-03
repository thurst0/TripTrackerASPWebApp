using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using Newtonsoft.Json.Linq;
namespace TripTrackerASPWebApp
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
   // [ScriptService]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class TripTracker : System.Web.Services.WebService
    {
        public class Student
        {
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string StudentID { get; set; }
        }
        public class Teacher
        {
            public string FullName { get; set; }
            public string School { get; set; }
        }
        public class TripSum
        {
            public int TotalTrips { get; set; }
            public decimal Dollars { get; set; }
            public string TripType { get; set; }
            public int Year { get; set; }
            public int Month { get; set; }
            public string FullName { get; set; }
        }
        //private static int nextId = 0;

        public void Add(Student student)
        {
           // student.StudentID = 1234;
            // nextId++;
            //students.Add(student);
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<Student> ListStudents(string vTeacher)
       // public void ListStudents(string  vTeacher)
        {
//not working with parms
            //string vTeacher = "";
            //vTeacher = data["vTeacher"].ToObject<string>();
            string commandText = "SELECT FirstName, LastName, ID FROM Students WHERE Teacher = @TeacherID ORDER BY LastName ASC ";
           // string commandText = "SELECT FirstName, LastName, ID FROM Students ORDER BY LastName ASC ";

            List<Student> students = new List<Student>();
            // SqlConnection con = new SqlConnection(@"data source=triptrackerapp.database.windows.net;initial catalog=TripTrackerApp;user id=phurst@triptrackerapp;password=TTflatiron!;integrated security=True;trusted_connection=true;MultipleActiveResultSets=True;App=EntityFramework");
            SqlConnection con = new SqlConnection(@"data source=localhost;initial catalog=TripTrackerApp;user id=sa;password=TTflatiron!;integrated security=True;trusted_connection=true;MultipleActiveResultSets=True;App=EntityFramework");

           // SqlConnection con = new SqlConnection (@"Server = tcp:triptrackerapp.database.windows.net,1433; Initial Catalog = TripTrackerApp; Persist Security Info = False; User ID = phurst@triptrackerapp; Password =TTflatiron!; MultipleActiveResultSets = False; Encrypt = True; TrustServerCertificate = False; Connection Timeout = 30");
            SqlCommand cmd = new SqlCommand(commandText, con);
            
            cmd.Parameters.Add("@TeacherID", SqlDbType.VarChar);
            cmd.Parameters["@TeacherID"].Value = vTeacher;
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            try
            {
                //int i = cmd.ExecuteNonQuery();
                using (dr)
                {
                    //int i = 0;
                    while (dr.Read())
                    {
                        //strStudentID = dr[0].ToString();
                        students.Add(new Student() { FirstName = dr[0].ToString(), LastName = dr[1].ToString(), StudentID = dr[2].ToString() });
                       // i++;
                    }
                    dr.Close();
                }
                con.Close();
            }
            catch (Exception e)
            {
                con.Close();
            }
            return students;
            //JavaScriptSerializer js = new JavaScriptSerializer();
            //Context.Response.Write(js.Serialize(students));
            //return new List<Student> { new Student() { StudentID = 12345 } };
        }
        [WebMethod]
        public List<Teacher> ListTeachers()
        {
            List<Teacher> teachers = new List<Teacher>();
             SqlConnection con = new SqlConnection(@"data source=localhost;initial catalog=TripTrackerApp;user id=sa;password=TTflatiron!;integrated security=True;trusted_connection=true;MultipleActiveResultSets=True;App=EntityFramework");
            //SqlConnection con = new SqlConnection(@"Server = tcp:triptrackerapp.database.windows.net,1433; Initial Catalog = TripTrackerApp; Persist Security Info = False; User ID = phurst@triptrackerapp; Password =TTflatiron!; MultipleActiveResultSets = False; Encrypt = True; TrustServerCertificate = False; Connection Timeout = 30");

            SqlCommand cmd = new SqlCommand(@"SELECT FullName FROM Teachers ORDER BY FullName ASC", con);// TODO Limit on school
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            try
            {
                using (dr)
                {
                    while (dr.Read())
                    {
                        teachers.Add(new Teacher() { FullName = dr[0].ToString() }); 
                   
                    }
                    dr.Close();
                }
                con.Close();
            }
            catch (Exception e)
            {
                con.Close();
            }
            return teachers;
        }
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod]
        public int MyInt(int Amount)
        {
            return Amount;
        }

        [WebMethod]
        public string Track(int ID, int TripType, decimal Distance)
        {
            SqlConnection conn = new SqlConnection(@"Server = tcp:triptrackerapp.database.windows.net,1433; Initial Catalog = TripTrackerApp; Persist Security Info = False; User ID = phurst@triptrackerapp; Password =TTflatiron!; MultipleActiveResultSets = False; Encrypt = True; TrustServerCertificate = False; Connection Timeout = 30");

           // SqlConnection conn = new SqlConnection(@"data source=localhost;initial catalog=TripTrackerApp;user id=sa;password=TTflatiron!;integrated security=True;trusted_connection=true;MultipleActiveResultSets=True;App=EntityFramework");
            conn.Open();
            int retval = 0;
            string msg = "";
            SqlCommand comm = new SqlCommand();
            comm.Connection = conn;
            comm.CommandType = System.Data.CommandType.StoredProcedure;
            comm.CommandText = "spMakeEntry";
            comm.Parameters.AddWithValue("@StudentID", ID);
            comm.Parameters.AddWithValue("@TripType", TripType);
            comm.Parameters.AddWithValue("@retval", retval);
            comm.Parameters.AddWithValue("@Distance", Distance);
            comm.Parameters["@retval"].Direction = ParameterDirection.Output;
            comm.Parameters.AddWithValue("@errmess", msg);
            comm.Parameters["@errmess"].Direction = ParameterDirection.Output;
            // comm.Parameters.AddWithValue("@TripType", name);
            try
            {
                comm.ExecuteNonQuery();
                msg = comm.Parameters["@errmess"].Value.ToString(); // TODO why E? Trace message returned
                return msg ;
            }
            catch (Exception e)
            {
                return e.Message.ToString();
            }
            finally
            {
                conn.Close();
            }
        }

        [WebMethod]
        public void ListTripSum()
        {
            List<TripSum> tripsum = new List<TripSum>();
             SqlConnection con = new SqlConnection(@"data source=localhost;initial catalog=TripTrackerApp;user id=sa;password=TTflatiron!;integrated security=True;trusted_connection=true;MultipleActiveResultSets=True;App=EntityFramework");
          // SqlConnection con = new SqlConnection(@"Server = tcp:triptrackerapp.database.windows.net,1433; Initial Catalog = TripTrackerApp; Persist Security Info = False; User ID = phurst@triptrackerapp; Password =TTflatiron!; MultipleActiveResultSets = False; Encrypt = True; TrustServerCertificate = False; Connection Timeout = 30");

            SqlCommand cmd = new SqlCommand(@"SELECT TOP 200 FullName, Year, Month, Dollars, TripType, TotalTrips FROM vTripSum ORDER BY Year, Month, FullName ASC", con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            try
            {
                using (dr)
                {
                    while (dr.Read())
                    {
                        tripsum.Add(new TripSum()
                        {
                            FullName = dr[0].ToString()
                            ,Year = Convert.ToInt32(dr[1])
                            ,Month = Convert.ToInt32(dr[2])
                            ,Dollars = Convert.ToDecimal(dr[3])
                            ,TripType = dr[4].ToString()
                            ,TotalTrips = Convert.ToInt32(dr[5])
                        });
                    }
                    dr.Close();
                }
                con.Close();
            }
            catch (Exception e)
            {
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(tripsum));
        }
    }
}
