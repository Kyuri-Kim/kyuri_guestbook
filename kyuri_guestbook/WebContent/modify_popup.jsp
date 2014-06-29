<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String content = request.getParameter("content");
	content = new String(content.getBytes("8859_1"), "euc-kr");
%>

<body style="margin:0px">

<div id="modify_pass_div" style="display:block">
	<div style="height:30px">
	</div>

	<div style="padding-top:20px">
	    <div style="margin:0px auto;width:600px;text-align:center">
	    	<div>Password :</div>
			<input type="password" id="modify_pass" name="modify_pass" style="width:250px;ime-mode:active;font-family: Arial, Helvetica, sans-serif;font-size: 12px;height: 18px;line-height: 18px;border: 1px solid #d7d7d7;color: #666666;padding: 0 5px;vertical-align: middle;"/>
	    </div>
	</div>
	
	<div style="height:25px">
	    <div style="width:600px;height:20px;margin:5px auto;background-repeat:no-repeat;position:relative;text-align:center">
	        <input type="button" value="Submit" onclick="change_modify_mode('<%=id%>', '<%=pass%>');" style="width:60px;height:20px;border:1px solid #4f4f4f;font-family:'돋움', Dotum, AppleGothic;font-size:9pt;vertical-align:middle;line-height:20px"/>
	    </div>
	</div>
	
	<div style="height:30px">
	</div>
</div>

<div id="modify_content_div" style="display:none">
	<div style="padding-top:20px">
	    <div style="margin:0px auto;width:600px;text-align:center">
	    	<div>Content :</div>
			<textarea id="content_modify" name="content_modify" rows="5" cols="50" style="width:250px;ime-mode:active;font-family: Arial, Helvetica, sans-serif;font-size: 12px;border: 1px solid #d7d7d7;color: #666666;padding: 0 5px;overflow-y: auto;"><%=content%></textarea>
	    </div>
	</div>
	
	<div style="height:25px">
	    <div style="width:600px;height:20px;margin:5px auto;background-repeat:no-repeat;position:relative;text-align:center">
	        <input type="button" value="Modify" onclick="modify('<%=id%>', '<%=pass%>');" style="width:60px;height:20px;border:1px solid #4f4f4f;font-family:'돋움', Dotum, AppleGothic;font-size:9pt;vertical-align:middle;line-height:20px"/>
	    </div>
	</div>
</div>
</body>