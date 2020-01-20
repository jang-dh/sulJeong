package team.hunter.model.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.AuthorityDAO;
import team.hunter.model.dao.MemberDAO;
import team.hunter.model.dto.Authority;
import team.hunter.model.dto.Member;


@Service //id="memberAuthenticationProvider"
public class MemberAuthenticationProvider implements AuthenticationProvider {
	@Autowired private MemberDAO memberDAO;
	@Autowired private AuthorityDAO authorityDAO;
	@Autowired private PasswordEncoder passwordEncoder;
	
	/**
	 * 사용자가 인증을 위해 id, password를 입력해서 전송하면 Authentication을 만들어서
	 * authenticate()메소드의 매개변수로 전달해준다.
	 * 
	 * 전달된 매개변수(Authentication)에서 id(name)를 DB에 꺼낸다.
	 * 꺼낸 id에 해당하는 회원정보를 DB에서 검색한다.
	 * DB에 정보가 있다면 DB에 있는 암호화된 비밀번호와 인수로 전달된
	 * 평문비밀번호를 서로 비교한다. - PasswordEncoder 필요
	 * 
	 * 만약, 일치하지 않는다면 예외를 발생시켜 AuthenticationFailureHandler가 실행되게 한다.
	 * 모두 일치 한다면 인증된 사용자의 정보와 권한을 Authentication에 저장하고 리턴한다. - UsernamePasswordAuthenticationToken
	 */
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		//아이디 꺼내기
		String id = authentication.getName(); // 입력된 id
		Member member = memberDAO.selectMemberById(id);
		if(member == null) {
			throw new UsernameNotFoundException("ID 또는 비밀번호를 확인해주세요");
		}
		
		//비밀번호 비교
		String inputPwd = authentication.getCredentials().toString();
		if(!passwordEncoder.matches(inputPwd, member.getPwd())) {
			throw new UsernameNotFoundException("ID 또는 비밀번호를 확인해주세요 ");
		}
		
		//인증 성공하였으니 모든 권한을 검색한다.
		List<Authority> authList = authorityDAO.selectAuthorityByMemberCode(member.getCode());
		List<SimpleGrantedAuthority> list = new ArrayList<SimpleGrantedAuthority>();
		for(Authority au : authList){
			list.add(new SimpleGrantedAuthority(au.getRole()));
		}
		
		return new UsernamePasswordAuthenticationToken(member, null, list);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

}
