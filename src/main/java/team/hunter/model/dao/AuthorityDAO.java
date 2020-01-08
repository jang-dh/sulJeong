package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Authority;

public interface AuthorityDAO {
	int insertAuthority(Authority authority);
	List<Authority> selectAuthorityByMemberCode(int memberCode);
	
	int membershipWithdrawal(int memberCode);
}
