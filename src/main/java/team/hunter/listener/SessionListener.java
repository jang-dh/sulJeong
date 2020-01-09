package team.hunter.listener;



import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import team.hunter.model.dao.StatisticsDAO;






public class SessionListener implements HttpSessionListener {
	
//	@Autowired
//	private StatisticsDAO dao;
	
    public void sessionCreated(HttpSessionEvent arg0) {
    	
    	HttpSession session = arg0.getSession();
    	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
    	
    	HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    	StatisticsDAO statisticsDAO = (StatisticsDAO)wac.getBean("statisticsDAOImpl");
    	statisticsDAO.insertTodayVisit();
    	
//        System.out.println("쎄션 시작!!!!!!!!!!!!" + dao);
//        int todayCount = 0;
//        
//        
//        try {
//            
//             // 오늘 방문자 수 + 1
//        	dao.insertTodayVisit();
//          
//             // 전체 방문자 수
//             
//        } catch (Exception e) {
//               
//               e.printStackTrace();
//          }
//        System.out.println("쎄션 시작!!!!!!!!!!!!2222222222222222");
//        
//        HttpSession session = arg0.getSession();
//        
//        // 세션 속성에 담아준다.
//
//        session.setAttribute("todayCount", todayCount); // 오늘 방문자 수
    	
    	
    }
 
     @Override
     public void sessionDestroyed(HttpSessionEvent arg0) {
    	 
     }
     
     
}

