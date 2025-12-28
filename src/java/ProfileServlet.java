import java.io.IOException;
import java.sql.*;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    //derby database connection
    private static final String DB_URL = "jdbc:derby://localhost:1527/student_profiles";
    
    //write sql using html form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        //1. grab data
        //declare data type for each input, then grab input from html POST request
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String intro = request.getParameter("intro");
        
        //2. wrap in javabean/ create ProfileBean object
        ProfileBean profile = new ProfileBean(studentId, name, program, email, hobbies, intro);
        
        //3. jdbc insert
        try {
            
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(DB_URL);
            
            //sql command
            String sql = "insert into profiles (student_id, name, program, email, hobbies, intro) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, profile.getStudentId());
            pstmt.setString(2, profile.getName());
            pstmt.setString(3, profile.getProgram());
            pstmt.setString(4, profile.getEmail());
            pstmt.setString(5, profile.getHobbies());
            pstmt.setString(6, profile.getIntro());
            
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            //collect all collected input everything into request so jsp can read
            request.setAttribute("name", name);
            request.setAttribute("studentId", studentId);
            request.setAttribute("program", program);
            request.setAttribute("email", email);
            request.setAttribute("hobbies", hobbies);
            request.setAttribute("intro", intro);

            //4. send collected input into jsp page
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (IOException | ClassNotFoundException | SQLException | ServletException e){
        }
    }
    
    //view all data
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //action to delete
        String action = request.getParameter("action");
        //view a student card
        String studentIdParam = request.getParameter("id");
        //search by name
        String searchName = request.getParameter("searchName");
        
        try {
            
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(DB_URL);
            
            //delete sql action
            if ("delete".equals(action) && studentIdParam != null) {
                String deleteSql = "delete from profiles where student_id = ?";
                PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
                deletePstmt.setString(1, studentIdParam);
                deletePstmt.executeUpdate();
                //setting tempstudent id into null after finishing execute for removing from current list pulled by sql earlier
                studentIdParam = null;
            }
            
            //display a profile card but using sutdent_id for each button reference for sql request
            if (studentIdParam != null && !studentIdParam.isEmpty()){
            
                String sql = "select * from profiles where student_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, studentIdParam);
                
                //exec query for single card
                ResultSet rs = pstmt.executeQuery();
                
                ProfileBean p = null;

                if (rs.next()) {
                    p = new ProfileBean();
                    p.setStudentId(rs.getString("student_id"));
                    p.setName(rs.getString("name"));
                    p.setProgram(rs.getString("program"));
                    p.setEmail(rs.getString("email"));
                    p.setHobbies(rs.getString("hobbies"));
                    p.setIntro(rs.getString("intro"));
                }

                //send collected input into jsp page
                if (p != null){
                    request.setAttribute("profile", p);
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                    conn.close();
                    return; //stop here to prevent load list too
                } else {
                    //if id dont exist, go back to list
                    response.sendRedirect("ProfileServlet");
                }
                
            } else { //display all
                
                List<ProfileBean> profileList = new ArrayList<>();
                String sql = "select * from profiles";

                // if user search name, use sql
                if (searchName != null && !searchName.isEmpty()) {
                    sql += " where lower(name) like lower('%" + searchName + "%')";
                }

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    ProfileBean p = new ProfileBean();
                    p.setStudentId(rs.getString("student_id"));
                    p.setName(rs.getString("name"));
                    p.setProgram(rs.getString("program"));
                    p.setEmail(rs.getString("email"));
                    p.setHobbies(rs.getString("hobbies"));
                    p.setIntro(rs.getString("intro"));
                    profileList.add(p);
                }
                
                //error text for jsp page
                if (profileList.isEmpty() && searchName != null) {
                    request.setAttribute("error", "Student name not found!");
                }
                
                //send the list to viewProfile
                request.setAttribute("profileList", profileList);
                request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
                
            }
            
            conn.close();
            
        } catch (IOException | ClassNotFoundException | SQLException | ServletException e){
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Profile Servlet";
    }


}
