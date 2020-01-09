package team.hunter.model.listener;



import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import team.hunter.model.dao.StatisticsDAO;






@WebListener
public class SessionListener implements HttpSessionListener {
	@Autowired
	private StatisticsDAO dao;
	
    public void sessionCreated(HttpSessionEvent arg0) {
    	
        
        int todayCount = 0;

        
        
        try {
            
             // 오늘 방문자 수 + 1
        	dao.insertTodayVisit();
          
             // 전체 방문자 수
             
        } catch (Exception e) {
               
               e.printStackTrace();
          }
        
        HttpSession session = arg0.getSession();
        
        // 세션 속성에 담아준다.

        session.setAttribute("todayCount", todayCount); // 오늘 방문자 수
    }
 
     @Override
     public void sessionDestroyed(HttpSessionEvent arg0) {
      // TODO Auto-generated method stub
     }
}

