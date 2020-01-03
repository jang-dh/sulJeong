package team.hunter.model.dao;

import team.hunter.model.dto.Member;

public interface MemberDAO {
	
	Member selectMemberById(String id);
}
