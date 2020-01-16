package team.hunter.model.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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
	
	@Autowired
	protected JavaMailSender  mailSender;
	
	
	
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
	public List<Member> selectByPhone(Member member) {
		return memberDAO.selectByPhone(member);
	}

	@Override
	public int newPassword(Member member) throws Exception {
		
		//가입 전에 비밀번호 평문을 암호화 해서 저장한다.
		String pwd = passwordEncoder.encode(member.getPwd());
		member.setPwd(pwd);
				
		int result = memberDAO.newPassword(member);
		return result;
	}

	@Override
	public Member changeMyInfo(Member member) {
		String pwd = passwordEncoder.encode(member.getPwd());
		member.setPwd(pwd);
				
		int result = memberDAO.changeMyInfo(member);
		Member memberDB = memberDAO.selectMemberById(member.getId());
		
		return memberDB;
	}
	
	@Transactional
	@Override
	public int membershipWithdrawal(Member member) {
		Member memberDB = memberDAO.selectMemberById(member.getId());
		if(!passwordEncoder.matches(member.getPwd(), memberDB.getPwd())) {
			throw new RuntimeException("비밀번호를 확인해주세요 ");
		}
		int result = authorityDAO.membershipWithdrawal(memberDB.getCode());
		System.out.println(result);
		if(result!=0) {
			result = memberDAO.membershipWithdrawal(member);
			System.out.println(result);
		}
		
		return result;
	}

	@Override
	public Member selectMemberByCode(int memberCode) {
		return memberDAO.selectMemberByCode(memberCode);
	}

	@Override
	public Member idDuplicateCheck(String id) {
		Member member = memberDAO.idDuplicateCheck(id);

		return member;
	}

}
