package team.hunter.model.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

@Service // id="memberAuthenticationFailureHandler"
public class MemberAuthenticationFailureHandler implements AuthenticationFailureHandler {

	/**
	 * ������ �������� �� onAuthenticationFailure �� ȣ��ȴ�.
	 */
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		request.setAttribute("errorMessage", exception.getMessage());
		//request.getRequestDispatcher("/WEB-INF/views/member/loginForm.jsp").forward(request, response);
		request.getRequestDispatcher("/login").forward(request, response);
	}

}
