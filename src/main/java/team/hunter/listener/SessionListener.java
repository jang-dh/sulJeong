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
	

    public void sessionCreated(HttpSessionEvent arg0) {
    	System.out.println("sessionCreated(HttpSessionEvent arg0) call..............");
    	HttpSession session = arg0.getSession();
    	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
    	
    	HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    	StatisticsDAO statisticsDAO = (StatisticsDAO)wac.getBean("statisticsDAOImpl");
    	statisticsDAO.insertTodayVisit();
    	
    	
    }
 
     @Override
     public void sessionDestroyed(HttpSessionEvent arg0) {
    	 
     }
     
     
}

