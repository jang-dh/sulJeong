package team.hunter.model.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.MemberDAO;
import team.hunter.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int memberJoin(Member member) {
		int result = memberDAO.memberJoin(member);
		return result;
	}

}
