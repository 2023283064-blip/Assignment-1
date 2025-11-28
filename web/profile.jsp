<%-- 
jsp is like entire html templete but runs on server like after processing, the html will be sent to client, unlike html-javascript runs in client
javascript: document.getElementByid("name"), .appendChild()
jsp: <%= request.getAttribute("name") =%>, html stuff <%= %>
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <title>Profile Card</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            padding: 20px;
            margin: 0;
            min-height: 100vh;
        }
        
        .profile-card {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        
        .header h1 {
            margin: 0 0 10px 0;
            font-size: 32px;
        }
        
        .student-id {
            font-size: 14px;
            opacity: 0.9;
        }
        
        .content {
            padding: 30px;
        }
        
        .info-row {
            display: flex;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .info-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        
        .label {
            font-weight: bold;
            color: #667eea;
            min-width: 120px;
            font-size: 14px;
        }
        
        .value {
            color: #333;
            flex: 1;
        }
        
        .intro-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
            border-left: 4px solid #667eea;
        }
        
        .back-btn {
            display: inline-block;
            margin: 20px 30px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .back-btn:hover {
            background: #5568d3;
        }
    </style>
</head>
<body>
    <div class="profile-card">
        <div class="header">
            <!-- pull data from ProfileServlet.java -->
            <h1><%= request.getAttribute("name") %></h1>
            <div class="student-id">ID: <%= request.getAttribute("studentId") %></div>
        </div>
        
        <div class="content">
            <div class="info-row">
                <div class="label">Program:</div>
                <div class="value"><%= request.getAttribute("program") %></div>
            </div>
            
            <div class="info-row">
                <div class="label">Email:</div>
                <div class="value"><%= request.getAttribute("email") %></div>
            </div>
            
            <div class="info-row">
                <div class="label">Hobbies:</div>
                <div class="value">
                    <% 
                        // check if hobbies exist first or it will cause error
                        // using getParamater() because input already a String. using getAttribute() need to declare and confirm (String) again when declaring new variable
                        String hobbies = request.getParameter("hobbies");
                        if ( hobbies != null && !hobbies.isEmpty() ) {
                            out.print(hobbies);
                        } else {
                            out.print("Not specified");
                        }
                    %>
                </div>
            </div>
            
            <% 
                String intro = request.getParameter("intro");
                if ( intro != null && !intro.isEmpty() ) {
            %>
            <div class="intro-box">
                <div class="label" style="margin-bottom: 10px;">About Me:</div>
                <div class="value"><%= intro %></div>
            </div>
            <% } %>
        </div>
        
        <a href="index.html" class="back-btn">⬅ Return</a>
    </div>
</body>
