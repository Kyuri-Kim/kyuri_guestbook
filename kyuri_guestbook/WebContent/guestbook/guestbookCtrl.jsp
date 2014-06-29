<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="kyuri_guestbook.guestbook.GuestbookMGR" %>
<%@ page import="kyuri_guestbook.guestbook.GuestbookVO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String act = request.getParameter("act");

    JSONObject jsonObject = new JSONObject();

    GuestbookMGR guestbookMGR = new GuestbookMGR();         

    if ("insert".equals(act)) {
    	String email = request.getParameter("email");
    	String pass = request.getParameter("pass");
    	String content = request.getParameter("content");
    	
        GuestbookVO guestbookVO = new GuestbookVO();                
        guestbookVO.setEmail(email);
        guestbookVO.setPass(pass);
        guestbookVO.setContent(content);

        if(guestbookMGR.insert(guestbookVO)) {
            jsonObject.put("result", true);
            out.print(jsonObject);
        } else {
            jsonObject.put("result", false);
            out.print(jsonObject);
        }
    } else if ("delete".equals(act)) {
    	String id = request.getParameter("id");
    	String pass = request.getParameter("pass");
    	
    	GuestbookVO guestbookVO = new GuestbookVO();
    	guestbookVO.setId(id);
        guestbookVO.setPass(pass);

    	if(guestbookMGR.delete(guestbookVO)) {
            jsonObject.put("result", true);
            out.print(jsonObject);
        } else {
            jsonObject.put("result", false);
            out.print(jsonObject);
        }
    } else if ("modify".equals(act)) {
    	String id = request.getParameter("id");
    	String pass = request.getParameter("pass");
    	String content = request.getParameter("content");
    	
    	GuestbookVO guestbookVO = new GuestbookVO();
    	guestbookVO.setId(id);
        guestbookVO.setPass(pass);
        guestbookVO.setContent(content);
        
    	if(guestbookMGR.modify(guestbookVO)) {
            jsonObject.put("result", true);
            out.print(jsonObject);
        } else {
            jsonObject.put("result", false);
            out.print(jsonObject);
        }
    }
%>