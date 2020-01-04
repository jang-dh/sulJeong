package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Likes;

@Repository
public class LikesDAOImpl implements LikesDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insert(Likes likes) {
		int result = session.insert("likesMapper.insertLike", likes);
		
		return result;
	}

}
