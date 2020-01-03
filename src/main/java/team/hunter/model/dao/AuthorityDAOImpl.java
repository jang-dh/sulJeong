package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Authority;
@Repository
public class AuthorityDAOImpl implements AuthorityDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertAuthority(Authority authority) {
		return sqlSession.insert("authorityMapper.insertAuthority", authority);
	}

	@Override
	public List<Authority> selectAuthorityByMemberCode(int memberCode) {
		return sqlSession.selectList("authorityMapper.selectAuthorityByMemberCode", memberCode);
	}

}
