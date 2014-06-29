<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
%>

<body style="margin:0px">

<div style="padding-top:20px">
    <div style="margin:0px auto;width:600px;text-align:center">
		<div>Password :</div>
		<input type="password" id="inp_pass" name="inp_pass" style="width:250px;ime-mode:active;font-family: Arial, Helvetica, sans-serif;font-size: 12px;height: 18px;line-height: 18px;border: 1px solid #d7d7d7;color: #666666;padding: 0 5px;vertical-align: middle;"/>
    </div>
</div>

<div style="height:25px">
    <div style="width:600px;height:20px;margin:5px auto;background-repeat:no-repeat;position:relative;text-align:center">
        <input type="button" value="delete" onclick="del('<%=id%>', '<%=pass%>');" style="width:60px;height:20px;border:1px solid #4f4f4f;font-family:'돋움', Dotum, AppleGothic;font-size:9pt;vertical-align:middle;line-height:20px"/>
    </div>
</div>
</body>