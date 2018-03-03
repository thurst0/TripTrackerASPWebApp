namespace TripTrackerASPWebApp
{
    public class Student
    {
        public string Name { get; set; }
        public int UserId { get; set; }
    }
    private static readonly List<Student> students = new List<Student>();
    //private static int nextId = 0;

    public void Add(Student student)
    {
        student.UserId = 1234;
       // nextId++;
        users.Add(user);
    }

}
