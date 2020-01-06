package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.PersonalQuestion;

@Repository
public class PersonalAnswerDAOImpl implements PersonalAnswerDAO {
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<PersonalQuestion> selectAll() {
		
		return session.selectList("personalAnswerMapper.selectAll");
	}

}
