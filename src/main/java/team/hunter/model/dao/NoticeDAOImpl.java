package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Notice;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public List<Notice> selectByCode(int code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Notice> select() {
		
		return session.selectList("noticeMapper.selectAll");
	}

	@Override
	public int insert(Notice dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Notice code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Notice code) {
		// TODO Auto-generated method stub
		return 0;
	}

}
