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
	            alert("메일주소를 입력해주세요.");
	            return false;
	        }
	        if(!validate_email(email)) {
	        	alert("메일주소를 올바르게 입력해 주세요.");
	            return false;
	        }
	        if (!$("#pass").val()) {
	            alert("암호를 입력해주세요.");
	            return false;
	        }
	        if (!$("#content").val()) {
	            alert("내용을 입력해주세요.");
	            return false;
	        } else {
	           $.post("guestbook/guestbookCtrl.jsp", {
	                act:"insert",
	                email: email,
	                pass: pass,
	                content: content
	            }, function(resData) {
	                alert("글 등록이 완료 되었습니다.");
					location.href="index.jsp";
	            }, "json");
	        }
	    }
	    
	    function del(id, pass) {
            if(!confirm("삭제하시겠습니까?"))
                return;
            
            var input_pass = $("#inp_pass").val();
            
            if (pass != input_pass) {
	            alert("비밀번호가 틀렸습니다.");
	            return false;
	        }

            $.post("guestbook/guestbookCtrl.jsp", {
            	act: "delete",
            	id: id,
            	pass: pass                
            }, function() {
                alert("해당 글이 삭제되었습니다.");
				location.href="index.jsp";
            });
        }
	    
	    function modify(id, pass) {
	    	if(!confirm("수정하시겠습니까?"))
                return;
	    	
	    	var content = $("#content_modify").val();

            if (!$("#content_modify").val()) {
                alert("내용을 입력해주세요.");
                return false;
            }
            
           	$.post("guestbook/guestbookCtrl.jsp", {
	            act:"modify",
	            id: id,
            	pass: pass,
	            content: content
			}, function(resData) {
				alert("수정이 완료 되었습니다.");
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
	            alert("비밀번호가 틀렸습니다.");
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
        <input type="button" value="작성" onclick="insert();" style="width:60px;height:20px;border:1px solid #4f4f4f;font-family:'돋움', Dotum, AppleGothic;font-size:9pt;vertical-align:middle;line-height:20px"/>
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
                <td><b>email :</b> [<%=guestInfo.get("email")%>] <font color="#ff8a00"><a href="javascript:modify_popup('<%=guestInfo.get("id")%>', '<%=guestInfo.get("pass")%>', '<%=guestInfo.get("content")%>');">수정</a> / <a href="javascript:del_popup('<%=guestInfo.get("id")%>', '<%=guestInfo.get("pass")%>');">삭제</a></font><br><br><b>작성 시각 :</b> [<%=write_time%>] <b>수정 시각 :</b> [<%=modify_time%>]</td>
            </tr>
            
            <tr>
                <td style="padding: 25px 10px 25px 10px;"><font color="#000000"><%=guestInfo.get("content")%></td>
            </tr>

            <% } %>

            <% if(guestbookList.size() == 0) { %>
            <tr height="50px">
                <td>방명록에 글이 존재하지 않습니다.</td>
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
<span class='button b-close' style='border-radius:7px 7px 7px 7px;box-shadow:none;font:bold 131% sans-serif;padding:0 6px 2px;position:absolute;right:-7px;top:-7px; background-color:#2b91af; color:#fff; cursor: pointer; display: inline-block; text-align: center;'><span>X</span></span> <!-- 닫기 버튼 (스타일은 알아서 지정) -->
<div class='content'></div> <!-- 컨텐츠가 들어갈 영역 지정 (이미지, html 등.. 여러가지를 동적으로 부를수 있다. -->
</div>


</body>
</html>