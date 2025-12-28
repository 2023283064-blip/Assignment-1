
import java.io.Serializable;

/**
 *
 * @author habil
 */
public class ProfileBean implements Serializable {
    private int id;
    private String studentId;
    private String name;
    private String program;
    private String email;
    private String hobbies;
    private String intro;
    private String createdAt;
    private String updatedAt;
    
    public ProfileBean() {
    }
    
    //default parameterized constructor
    public ProfileBean(String studentId, String name, String program, String email, String hobbies, String intro){
        this.studentId = studentId;
        this.name = name;
        this.program = program;
        this.email = email;
        this.hobbies = hobbies;
        this.intro = intro;
    }
    
    // Getters
    public int getId() {
        return id;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getName() {
        return name;
    }

    public String getProgram() {
        return program;
    }

    public String getEmail() {
        return email;
    }

    public String getHobbies() {
        return hobbies;
    }

    public String getIntro() {
        return intro;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    //pull all
    @Override
    public String toString() {
        return "ProfileBean{"
                + "id=" + id
                + ", studentId='" + studentId + '\''
                + ", name='" + name + '\''
                + ", program='" + program + '\''
                + ", email='" + email + '\''
                + '}';
    }
    
}
