package kyuri_guestbook.guestbook;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class GuestbookDAO {
	/*
	    DB 계정 정보
	 */
	String url = "jdbc:cubrid:127.0.0.1:30000:guestbook:::";
	String user = "dba";
	String passwd = "kyuri";
	
	public List<Map> getAllList() throws SQLException, ClassNotFoundException {
	    List<Map> results = new ArrayList<Map>();
	
	    StringBuilder sql = new StringBuilder();
	
	    sql.append("select  \n");
	    sql.append("    * \n");
	    sql.append("from guestbook \n");
	    sql.append("order by write_time desc\n");
	    
	 	Class.forName("cubrid.jdbc.driver.CUBRIDDriver");
	    Connection con = DriverManager.getConnection(url, user, passwd);
	    Statement stat = con.createStatement();
	
	    ResultSet val = stat.executeQuery(sql.toString());
	
	    while (val.next()) {
	        Map info = new HashMap();
	        info.put("id", val.getString("id"));
	        info.put("pass", val.getString("pass"));
	        info.put("email", val.getString("email"));
	        info.put("content", val.getString("content"));
	        info.put("write_time", val.getString("write_time"));
	        info.put("modify_time", val.getString("modify_time"));
	        results.add(info);
	    }
	
	    stat.close();
	    con.close();
	
	    return results;
	}
	
	/*
	    글 작성
	 */
	public boolean insert(GuestbookVO guestbookVO) throws SQLException, ClassNotFoundException {
		String content = guestbookVO.getContent();
        content = content.replaceAll("\\'", "\\\\'");
        
	    StringBuilder sql = new StringBuilder();
	    sql.append("insert into guestbook \n");
	    sql.append(" ( \n");
	    sql.append(" id \n");
	    sql.append(" ,pass \n");
	    sql.append(" ,email \n");
	    sql.append(" ,content \n");
	    sql.append(" ,write_time \n");
	    sql.append(" ,modify_time \n");
	    sql.append(" ) \n");
	    sql.append(" values \n");
	    sql.append(" ( \n");
	
	    sql.append("'" + UUID.randomUUID().toString() + "' \n");
	    sql.append(", '" + guestbookVO.getPass() + "' \n");
	    sql.append(", '" + guestbookVO.getEmail() + "' \n");
	    sql.append(", '" + content + "' \n");
	    sql.append(", now() \n");
	    sql.append(", now() \n");
	    sql.append(" ) \n");
	
	    Class.forName("cubrid.jdbc.driver.CUBRIDDriver");
	    Connection con = DriverManager.getConnection(url, user, passwd);
	    Statement stat = con.createStatement();
	
	    stat.executeUpdate(sql.toString());
	    stat.close();
	    con.close();
	
	    return true;
	}
	
	/*
	    글 삭제
	 */
	public boolean delete(GuestbookVO guestbookVO) throws SQLException, ClassNotFoundException {
	    StringBuilder sql = new StringBuilder();
	    sql.append("delete from guestbook \n");
	    sql.append("where id  = '" + guestbookVO.getId() + "' and pass = '" + guestbookVO.getPass() + "' \n");
	
	    Class.forName("cubrid.jdbc.driver.CUBRIDDriver");
	    Connection con = DriverManager.getConnection(url, user, passwd);
	    Statement stat = con.createStatement();
	
	    stat.executeUpdate(sql.toString());
	    stat.close();
	    con.close();
	
	    return true;
	}
	
	/*
	   글 수정
	 */
	public boolean modify(GuestbookVO guestbookVO) throws SQLException, ClassNotFoundException {
        String content = guestbookVO.getContent();
        content = content.replaceAll("\\'", "\\\\'");
        
        StringBuilder sql = new StringBuilder();
        sql.append("update guestbook \n");
        sql.append(" set \n");
        sql.append(" content = '" + content + "' \n");
        sql.append(" ,modify_time = now() \n");

        sql.append("where id  = '" + guestbookVO.getId() + "' and pass = '" + guestbookVO.getPass() + "' \n");

        Class.forName("cubrid.jdbc.driver.CUBRIDDriver");
	    Connection con = DriverManager.getConnection(url, user, passwd);
	    Statement stat = con.createStatement();

        stat.executeUpdate(sql.toString());
        stat.close();
        con.close();

        return true;
    }
}
