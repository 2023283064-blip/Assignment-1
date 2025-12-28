<%-- 
jsp is like entire html templete but runs on server like after processing, the html will be sent to client, unlike html-javascript runs in client
javascript: document.getElementByid("name"), .appendChild()
jsp: <%= request.getAttribute("name") =%>, html stuff <%= %>
el (expression language): ${profile.name}, the 'profile' is pulled from servlet with request.setAttribute(string, element). el look for string, then, javabean extract the value from the object name
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            padding: 20px;
            margin: 0;
            min-height: 100vh;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding-bottom: 20px;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .search-section { padding: 20px; text-align: center; border-bottom: 1px solid #eee; }
        .search-input { padding: 8px; width: 250px; border: 1px solid #ddd; border-radius: 5px; }
        
        /* Table with rounded corners */
        .table-wrapper { padding: 20px; }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border: 1px solid #eee;
            border-radius: 12px;
            overflow: hidden;
        }
        th { background: #667eea; color: white; padding: 15px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; background: #fff; }
        tr:last-child td { border-bottom: none; }
        
        .view-btn {
            background: #667eea;
            color: white;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 13px;
        }
        .view-btn:hover { background: #5568d3; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Student Management System</h1>
        </div>

        <div class="search-section">
            <form action="ProfileServlet" method="get">
                <input type="text" name="searchName" class="search-input" placeholder="Search by name...">
                <button type="submit" class="view-btn">Search</button>
            </form>
        </div>
        
        <c:if test="${not empty error}">
            <div style="color: red; text-align: center;">
                <p> ${error} </p>
                <a href="ProfileServlet" style="color: #667eea; font-size: 14px; text-decoration: underline;"> Display All Students Again </a>
            </div>
        </c:if>
        
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Program</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${profileList}">
                        <tr>
                            <td>${p.studentId}</td>
                            <td><strong>${p.name}</strong></td>
                            <td>${p.program}</td>
                            <td style="padding: 12px; text-align: center;">
                                
                                <a href="ProfileServlet?id=${p.studentId}" class="view-btn">View Card</a>
                                
                                <a href="ProfileServlet?action=delete&id=${p.studentId}" 
                                   style="color: #f5576c; margin-left: 10px; font-size: 13px; text-decoration: none; font-weight: bold;"
                                   onclick="return confirm('Are you sure you want to delete ${p.name}? This cannot be undone!');">
                                   Delete
                                </a>
                                   
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div style="text-align: center;">
            <a href="index.html" style="color: #667eea; text-decoration: none; font-weight: bold;">+ Add New Student</a>
        </div>
    </div>
</body>
</html>