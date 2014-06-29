<%@ page contentType="text/html;charset=euc-kr" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="kyuri_guestbook.guestbook.GuestbookMGR" %>

<% 	
 	/* Manager */
 	GuestbookMGR guestbookMGR = new GuestbookMGR();
 	
 	List<Map> guestbookList = guestbookMGR.getAllList();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>Kyuri GuestBook</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link rel="stylesheet" type="text/css" href="./css/basic.css">

    <!-- JQuery js files: -->
    <script type="text/javascript" src="./js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="./js/jquery.bpopup.min.js"></script>
    
    <script type="text/javascript">
    
	    function insert() {
	        var email = $("#email").val();
	        var pass = $("#pass").val();
	        var content = $("#content").val();
	
	        if (!$("#email").val()) {
	            alert("�����ּҸ� �Է����ּ���.");
	            return false;
	        }
	        if(!validate_email(email)) {
	        	alert("�����ּҸ� �ùٸ��� �Է��� �ּ���.");
	            return false;
	        }
	        if (!$("#pass").val()) {
	            alert("��ȣ�� �Է����ּ���.");
	            return false;
	        }
	        if (!$("#content").val()) {
	            alert("������ �Է����ּ���.");
	            return false;
	        } else {
	           $.post("guestbook/guestbookCtrl.jsp", {
	                act:"insert",
	                email: email,
	                pass: pass,
	                content: content
	            }, function(resData) {
	                alert("�� ����� �Ϸ� �Ǿ����ϴ�.");
					location.href="index.jsp";
	            }, "json");
	        }
	    }
	    
	    function del(id, pass) {
            if(!confirm("�����Ͻðڽ��ϱ�?"))
                return;
            
            var input_pass = $("#inp_pass").val();
            
            if (pass != input_pass) {
	            alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
	            return false;
	        }

            $.post("guestbook/guestbookCtrl.jsp", {
            	act: "delete",
            	id: id,
            	pass: pass                
            }, function() {
                alert("�ش� ���� �����Ǿ����ϴ�.");
				location.href="index.jsp";
            });
        }
	    
	    function modify(id, pass) {
	    	if(!confirm("�����Ͻðڽ��ϱ�?"))
                return;
	    	
	    	var content = $("#content_modify").val();

            if (!$("#content_modify").val()) {
                alert("������ �Է����ּ���.");
                return false;
            }
            
           	$.post("guestbook/guestbookCtrl.jsp", {
	            act:"modify",
	            id: id,
            	pass: pass,
	            content: content
			}, function(resData) {
				alert("������ �Ϸ� �Ǿ����ϴ�.");
				location.href="index.jsp";
			}, "json");
        }
	    
	    function validate_email(str) {
	        emailEx1 = /[^@]+@[A-Za-z0-9_-]+.[A-Za-z]+/;
	        emailEx2 = /[^@]+@[A-Za-z0-9_-]+.[A-Za-z0-9_-]+.[A-Za-z]+/;
	        emailEx3 = /[^@]+@[A-Za-z0-9_-]+.[A-Za-z0-9_-]+.[A-Za-z0-9_-]+.[A-Za-z]+/;

	        if (emailEx1.test(str)) return true;
	        if (emailEx2.test(str)) return true;
	        if (emailEx3.test(str)) return true;

	     	return false;
	     } 
	    
	    function del_popup(id, pass) {
	    	$(function() {
	    		$('#pop_up_banner').bPopup({
	    			contentContainer:'.content',
	                loadUrl: 'delete_popup.jsp?id='+id+'&pass='+pass //Uses jQuery.load()
	    		});
	    	});
        }
	    
	    function modify_popup(id, pass, content) {
	    	$(function() {
	    		$('#pop_up_banner').bPopup({
	    			contentContainer:'.content',
	                loadUrl: 'modify_popup.jsp?id='+id+'&pass='+pass+'&content='+content //Uses jQuery.load()
	    		});
	    	});
        }
	    
	    function change_modify_mode(id, pass) {
			var modify_pass = $("#modify_pass").val();
            
            if (pass != modify_pass) {
	            alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
	            return false;
	        }
            
	    	document.getElementById('modify_pass_div').style.display = "none";
	    	document.getElementById('modify_content_div').style.display = "block";
        }
    
    </script>
    
</head>

<body style="margin:0px">

<div style="padding-top:20px">
    <div style="margin:0px auto;width:600px;text-align:left">
    
    	<form class="cssform" name="frm" id="frm" action="guestbook/guestbookCtrl.jsp" method="post">
    	
    	<div><b>GuestBook</b></label></div>
    	<br><br>
	    <div>Email Address :</div>
	    <input type="text" id="email" name="email" style="width:250px;ime-mode:inactive">
		<br><br>
		<div>Password :</div>
		<input type="password" id="pass" name="pass" style="width:250px;ime-mode:inactive"/>
		<br><br>
	    <div>Content :</div>
		<textarea id="content" name="content" rows="5" cols="50" style="width:250px;ime-mode:active"></textarea>
			    
        </form>
    </div>
</div>

<div style="height:25px">
    <div style="width:600px;height:20px;margin:5px auto;background-repeat:no-repeat;position:relative;text-align:right">
        <input type="button" value="�ۼ�" onclick="insert();" style="width:60px;height:20px;border:1px solid #4f4f4f;font-family:'����', Dotum, AppleGothic;font-size:9pt;vertical-align:middle;line-height:20px"/>
    </div>
</div>

<!-- Guestbook Content List -->
<div style="padding-top:5px">
    <div class="css3droppanel" style="margin:0px auto;width:600px;text-align:left">
        <table class="guestbook_tb_01">
            <colgroup>
                <col width="600px" />
            </colgroup>

            <%
                for (int i=0; i < guestbookList.size(); i++) {
                    Map guestInfo = guestbookList.get(i);
                    
                    String write_time = "", modify_time = "";
                    StringTokenizer token; 
                    
                    token = new StringTokenizer(String.valueOf(guestInfo.get("write_time")));
                    
                    if(token.hasMoreTokens()) {    
                    	write_time = token.nextToken(".");
                    }
                    
					token = new StringTokenizer(String.valueOf(guestInfo.get("modify_time")));
                    
                    if(token.hasMoreTokens()) {    
                    	modify_time = token.nextToken(".");
                    }
                    	  

            %>

            <tr height="28px"> 
                <td><b>email :</b> [<%=guestInfo.get("email")%>] <font color="#ff8a00"><a href="javascript:modify_popup('<%=guestInfo.get("id")%>', '<%=guestInfo.get("pass")%>', '<%=guestInfo.get("content")%>');">����</a> / <a href="javascript:del_popup('<%=guestInfo.get("id")%>', '<%=guestInfo.get("pass")%>');">����</a></font><br><br><b>�ۼ� �ð� :</b> [<%=write_time%>] <b>���� �ð� :</b> [<%=modify_time%>]</td>
            </tr>
            
            <tr>
                <td style="padding: 25px 10px 25px 10px;"><font color="#000000"><%=guestInfo.get("content")%></td>
            </tr>

            <% } %>

            <% if(guestbookList.size() == 0) { %>
            <tr height="50px">
                <td>���Ͽ� ���� �������� �ʽ��ϴ�.</td>
            </tr>
            <% } %>

        </table>
    </div>
</div>

<div style="height:50px">
    <div style="width:600px;height:50px;margin:0px auto">
    	&nbsp;
    </div>
</div>

<div id='pop_up_banner' style='display:none; width:600px; background-color:#ffffff'>
<span class='button b-close' style='border-radius:7px 7px 7px 7px;box-shadow:none;font:bold 131% sans-serif;padding:0 6px 2px;position:absolute;right:-7px;top:-7px; background-color:#2b91af; color:#fff; cursor: pointer; display: inline-block; text-align: center;'><span>X</span></span> <!-- �ݱ� ��ư (��Ÿ���� �˾Ƽ� ����) -->
<div class='content'></div> <!-- �������� �� ���� ���� (�̹���, html ��.. ���������� �������� �θ��� �ִ�. -->
</div>


</body>
</html>