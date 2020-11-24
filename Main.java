import java.util.Scanner;

public class Main {
    private static DatabaseHelper db;
    private static Scanner input = new Scanner(System.in);

    public static void main(String[] args) {
        db = new DatabaseHelper();
        String choice = "";

        while (!choice.equals("3")) {

            System.out.println("");
            System.out.println("Available Applications");
            System.out.println("*".repeat(40));
            System.out.print("1: Student Registration \n2: Class List Generation \n3: End Program\nSelect Application: ");
            choice = input.nextLine().strip();
    
            switch (choice) {
                case "1":
                    registerStudent();
                    break;
                case "2":
                    generateClassList();
                    break;
                case "3":
                    System.out.println("Bye!");
                    break;
            }
        }
    }

    private static void generateClassList() {
        System.out.print("Enter Section No (Press Enter for All): ");
        String section_no = input.nextLine().strip().toUpperCase();
        db.generateClassList(section_no);
    }

    private static void registerStudent() {

        System.out.println("\nRegister Student");
        System.out.println("-".repeat(40));

        int s_id = 0;
        while (s_id<=0) {
            try {
                System.out.print("Enter Student ID: ");
                s_id = Integer.parseInt(input.nextLine().strip());
            } catch (NumberFormatException e) {
                System.out.println("Invalid Student ID. Must be a number");
                s_id = 0;
            }
        }

        String s_name = db.getStudent(s_id);
        if (s_name.contains("Error")) return;

        System.out.print("Enter Section No: ");
        String section_no = input.nextLine().strip().toUpperCase();
        if (!db.checkVacancy(section_no)) return;

        String course_no = db.getCourseBySectionNo(section_no);
        if (course_no.contains("Error")) return;

        db.addRegistration(s_id, section_no, course_no);

    }

}
