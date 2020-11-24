import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DatabaseHelper {
    protected Connection connection;

    final String USER = "root";
    final String PASS = "";
    final String DATABASE = "80";

    public DatabaseHelper() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            this.connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/" + DATABASE, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public String getStudent(int s_id){
        String sql = "", response = "";
        ResultSet resultSet = null;
        try {
            sql = "select s_name, s_ssn from student where s_id = " + s_id;
            Statement statement = this.connection.createStatement();
            statement.execute(sql);
            resultSet = statement.getResultSet();
            if(resultSet.next()) {
                response = resultSet.getString(1) + ", " + resultSet.getString(2);
            } else {
                response = "Error: Student record not found";
            }
        } catch (SQLException throwables) {
            response =  throwables.getMessage();
        }
        System.out.println(">> " + response);
        return response;
    }

    public String getCourse(String course_no){
        String sql = "", response = "";
        ResultSet resultSet = null;
        try {
            sql = "select * from courses where course_no = '" + course_no + "'";
            Statement statement = this.connection.createStatement();
            statement.execute(sql);
            resultSet = statement.getResultSet();
            if(resultSet.next()) {
                response = resultSet.getString(1);
            } else {
                response = "Error: Course  not found";
            }
        } catch (SQLException throwables) {
            response =  throwables.getMessage();
        }
        System.out.println(response);
        return response;
    }

    public boolean checkVacancy(String section_no){
        ResultSet resultSet;
        boolean response;

        String sql = "SELECT MAX(section.Max_enroll) Capacity, COUNT(registration.S_ID) Enrollment\n" +
                "FROM section left join registration ON section.Sec_No = registration.Sec_No\n" +
                "WHERE section.sec_no = '" + section_no + "'";

        try {
            Statement statement = this.connection.createStatement();
            statement.execute(sql);
            resultSet = statement.getResultSet();
            resultSet.next();
            int capacity = resultSet.getInt(1);
            int enrollment = resultSet.getInt(2);
            response = capacity > enrollment;
            if (!response)
                System.out.println(">> Maximum Enrollment of " + enrollment + " Reached.");
        } catch (SQLException throwables) {
            response = false;
            System.out.println(">> " + throwables.getMessage());
        }
        return response;
    }

    public String getCourseBySectionNo(String section_no){
        ResultSet resultSet = null;
        String response, displayText;
        String sql = "select course_no, c_year, semester from section where sec_no = '" + section_no + "'";

        try {
            Statement statement = this.connection.createStatement();
            statement.execute(sql);
            resultSet = statement.getResultSet();
            if(resultSet.next()) {
                displayText = resultSet.getString(1) + ", " + resultSet.getInt(2) + " - " + resultSet.getString(3);
                response = resultSet.getString(1);
            } else {
                response = "Error: Section not found";
                displayText = response;
            }
        } catch (SQLException throwables) {
            response =  throwables.getMessage();
            displayText = response;
        }
        System.out.println(">> " + displayText);
        return response;
    }

    public void addRegistration(int s_id, String sec_no, String course_no) {
        String response = "";

        String sql = "INSERT INTO registration (s_id, sec_no, course_no) VALUES ";
        sql += "(" + s_id + ", '" + sec_no + "', '" + course_no + "')";

        try {
            PreparedStatement preparedStatement =  connection.prepareStatement(sql);
            int numRows = preparedStatement.executeUpdate(sql);
            response  = "Student Registered successfully.";
        } catch (SQLException throwables) {
            response = "Error while Student Registration " + "\n\r" + throwables.getMessage();
        }
        System.out.println(">> " + response);
    }

    public void generateClassList(String section_no){
        ResultSet resultSet;
        String response = "";

        String sql = "SELECT\n" +
                "\tcourses.Course_No,\n" +
                "\tcourses.Course_Name,\n" +
                "\tsection.Sec_No,\n" +
                "\tsection.C_Year,\n" +
                "\tsection.Semester,\n" +
                "\tsectioninroom.Room_No,\n" +
                "\tsectioninroom.Weekday,\n" +
                "\tsectioninroom.Time,\n" +
                "\tstaff.T_NAME\n" +
                "FROM \n" +
                "\tsection LEFT JOIN \n" +
                "\tcourses ON section.Course_No = courses.Course_No LEFT JOIN \n" +
                "\tsectioninroom ON section.Sec_No = sectioninroom.Sec_No LEFT JOIN\n" +
                "\tstaff ON section.Instructor_SSN = staff.T_SSN";

        if (section_no != "")
            sql += " WHERE section.sec_no = '" + section_no + "'";

        try {
            Statement statement = this.connection.createStatement();
            statement.execute(sql);
            resultSet = statement.getResultSet();
        } catch (SQLException throwables) {
            System.out.println ("Error while generating class list");
            return;
        }
        String[] cols = {"Course_No", "Course_Name","Sec_No","Year","Semester","Room_No","Weekday","Time","Instructor"};
        String formatStr = " %-10s %-30s %-10s %-10s %-10s %-10s %-12s %-12s %-20s";
        System.out.println("");
        while(true) {
            try {
                if (!resultSet.next()) break;
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                int columnsNumber = resultSetMetaData.getColumnCount();
                String[] format = formatStr.split(" ");
                for (int i = 1; i <= columnsNumber; i++) {
                    System.out.println(String.format("%-15s : %-25s", cols[i-1], resultSet.getString(i)));
                }
                listStudentsBySection(resultSet.getString(3));
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    public void listStudentsBySection(String sec_no){
        ResultSet resultSet;
        String response = "";

        String sql = "SELECT student.S_ID, S_SSN, S_Name, S_Year, Major FROM registration LEFT JOIN student ON registration.S_ID = student.S_ID" +
                "\nWHERE registration.Sec_No = '" + sec_no + "'" +
                "\nORDER BY S_Name";

        try {
            Statement statement = this.connection.createStatement();
            statement.execute(sql);
            resultSet = statement.getResultSet();
        } catch (SQLException throwables) {
            System.out.println ("Error while generating class list");
            return;
        }

        String formatStr = " %-10s %-10s %-20s %-10s %-20s";
        while(true) {
            try {
                if (!resultSet.next()) break;
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                int columnsNumber = resultSetMetaData.getColumnCount();
                String[] format = formatStr.split(" ");
                for (int i = 1; i <= columnsNumber; i++) {
                    response += String.format(format[i], resultSet.getString(i));
                }
                response += "\n\r";
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        String columnNames = String.format(formatStr.replaceAll(" ",""),
                "S_ID", "S_SSN","S_Name","Year","Major");
        columnNames += "\n" + "-".repeat(80) + "\n";
        if (response.length()>5) {
            response = "\n" + columnNames + response;
            System.out.println(response);
        } else {
            System.out.println("\n>> No Registration for this Section\n");
        }
    }

}

