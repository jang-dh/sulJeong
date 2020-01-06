package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.PersonalQuestion;
@Repository
public class PersonalQuestionDAOImpl implements PersonalQuestionDAO {
	@Autowired
	private SqlSession session;
	
	@Override
	public List<PersonalQuestion> personalQuestionList(int memberCode) {
		List<PersonalQuestion> list = session.selectList("personalQuestionMapper.personalQuestionList", memberCode);
		return list;
	}

	@Override
	public int personalQuestionInsert(PersonalQuestion personalQuestion) {
		int result = session.insert("personalQuestionMapper.personalQuestionInsert", personalQuestion);
		return result;
	}

}
