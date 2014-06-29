package kyuri_guestbook.guestbook;

import java.util.List;
import java.util.Map;

public class GuestbookMGR {
	/*
	    ��� ����Ʈ ��ȯ
	 */
	public List<Map> getAllList() {
	    List<Map> results = null;
	
	    try
	    {
	        GuestbookDAO dao = new GuestbookDAO();
	        results = dao.getAllList();
	    }
	    catch (Exception e)
	    {
	        e.printStackTrace();
	    }
	
	    return results;
	}
	
	/*
	    �� �Է�
	 */
	public boolean insert(GuestbookVO guestbookVO)
	{
	    boolean result = false;
	
	    try
	    {
	    	GuestbookDAO dao = new GuestbookDAO();
	
	        if(dao.insert(guestbookVO)) {
	        	result = true;
	        } else {
	        	result = false;
	        }
	    }
	    catch (Exception e)
	    {
	        e.printStackTrace();
	    }
	
	    return result;
	}
	
	/*
	    �� ����
	 */
	public boolean delete(GuestbookVO guestbookVO)
	{
	    try
	    {
	    	GuestbookDAO dao = new GuestbookDAO();
	
	        if(dao.delete(guestbookVO))
	            return true;
	    }
	    catch (Exception e)
	    {
	        e.printStackTrace();
	    }
	
	    return false;
	}
	
	/*
	    ����
	 */
	public boolean modify(GuestbookVO guestbookVO)
    {
        try
        {
        	GuestbookDAO dao = new GuestbookDAO();
        	
	        if(dao.modify(guestbookVO))
	            return true;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return false;
    }
}
