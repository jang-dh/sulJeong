package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Likes;

@Repository
public class LikesDAOImpl implements LikesDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insert(Likes likes) {
		return session.insert("likesMapper.insert", likes);
	}

	@Override
	public List<Funding> selectFundingByMemberCode(int memberCode) {
		return session.selectList("likesMapper.selectFundingByMemberCode", memberCode);
	}

	@Override
	public int delete(Likes likes) {
		return session.delete("likesMapper.delete", likes);
	}

	@Override
	public Likes select(Likes likes) {
		return session.selectOne("likesMapper.select", likes);
	}

	@Override
	public int cntByFundingCode(int fundingCode) {
		return session.selectOne("likesMapper.cntByFundingCode", fundingCode);
	}

}
