package team.hunter.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.PersonalAnswer;
import team.hunter.model.dto.PersonalQuestion;

@Repository
public class PersonalAnswerDAOImpl implements PersonalAnswerDAO {
	
	@Autowired
	private SqlSession session;
	
	@Override
	public int listCount() {
		
		return session.selectOne("personalAnswerMapper.listCount");
	}
	
	@Override
	public PersonalQuestion selectByCodeQuestion(int code) {
		return session.selectOne("personalAnswerMapper.selectByCodeQuestion",code);
	}
	
	@Override
	public int insertPersonalAnswer(PersonalAnswer answer) {

		return session.insert("personalAnswerMapper.insertPersonalAnswer", answer);
	}
	
	@Override
	public int updatePersonalQuestionState(int code) {
		
		return session.update("personalAnswerMapper.updatePersonalQuestionState", code);
	}
	
	@Override
	public List<PersonalQuestion> selectPersonalQuestionPaging(int startIndex, int cntPerPage) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startIndex", startIndex);
		map.put("cntPerPage", cntPerPage);
		
		return session.selectList("personalAnswerMapper.selectPersonalQuestionPaging",map);
	}
	

}
