package team.hunter.model.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.AuthorityDAO;
import team.hunter.model.dao.MemberDAO;
import team.hunter.model.dto.Authority;
import team.hunter.model.dto.Member;
import team.hunter.util.Constants;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private AuthorityDAO authorityDAO;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@Transactional
	@Override
	public int memberJoin(Member member) {
		
		//가입 전에 비밀번호 평문을 암호화 해서 저장한다.
		String pwd = passwordEncoder.encode(member.getPwd());
		member.setPwd(pwd);
		
		
		//가입하기
		int result = memberDAO.memberJoin(member);
		if(result == 0) throw new RuntimeException("가입되지 않았습니다."); //예외처리...
		
		//id에 해당하는 회원 가져오기
		Member memberById = memberDAO.selectMemberById(member.getId());
		
		//UserType에 따른 권한 등록
		result = authorityDAO.insertAuthority(new Authority(memberById.getCode(), Constants.ROLE_MEMBER));
		
		return result;
	}

	@Override
	public Member selectByPhone(Member member) {
		return memberDAO.selectByPhone(member);
	}

	@Override
	public void newPassword(Member member) throws Exception {
		
		//가입 전에 비밀번호 평문을 암호화 해서 저장한다.
		String pwd = passwordEncoder.encode(member.getPwd());
		member.setPwd(pwd);
				
		memberDAO.newPassword(member);
	}

}
