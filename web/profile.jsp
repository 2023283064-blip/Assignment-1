<%-- 
jsp is like entire html templete but runs on server like after processing, the html will be sent to client, unlike html-javascript runs in client
javascript: document.getElementByid("name"), .appendChild()
jsp: <%= request.getAttribute("name") =%>, html stuff <%= %>
el (expression language): ${profile.name}, the 'profile' is pulled from servlet with request.setAttribute(string, element). el look for string, then, javabean extract the value from the object name
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            <h1>${profile.name}</h1>
            <div class="student-id">ID: ${profile.studentId}</div>
        </div>
        
        <div class="content">
            <div class="info-row">
                <div class="label">Program:</div>
                <div class="value">${profile.program}</div>
            </div>
            
            <div class="info-row">
                <div class="label">Email:</div>
                <div class="value">${profile.email}</div>
            </div>
            
            <div class="info-row">
                <div class="label">Hobbies:</div>
                <div class="value">
                    ${empty profile.hobbies ? 'Not specified' : profile.hobbies}
                </div>
            </div>
            
            <c:set var="i" value="${not empty profile.intro ? profile.intro : intro}" />
                <div class="intro-box">
                    <div class="label" style="margin-bottom: 10px;">About Me:</div>
                    <div class="value">
                        ${not empty i ? i : "<i>No introduction</i>"}
                    </div>
                </div>
        </div>
        
        <div style="text-align: justified; padding-bottom: 20px;"> 
            <a href="ProfileServlet" class="back-btn">☰ View All Students</a> <a href="index.html" style="color: #667eea; text-decoration: none; font-weight: bold;">+ Add New Student</a>
        </div>
    </div>
</body>
