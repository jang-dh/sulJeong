package team.hunter.model.dao;

import java.util.List;

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
	public List<PersonalQuestion> selectAllQuestion() {
		
		return session.selectList("personalAnswerMapper.selectAllQuestion");
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
	

}
