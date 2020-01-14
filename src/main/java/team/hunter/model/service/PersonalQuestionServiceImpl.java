package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.PersonalQuestionDAO;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.PersonalQuestion;

@Service
public class PersonalQuestionServiceImpl implements PersonalQuestionService {
	@Autowired
	private PersonalQuestionDAO personalqDAO;

	@Override
	public List<PersonalQuestion> personalQuestionList(Member member) {
		return personalqDAO.personalQuestionList(member);
	}

	@Override
	public int personalQuestionInsert(PersonalQuestion personalQuestion) {
		
		return personalqDAO.personalQuestionInsert(personalQuestion);
	}
	
	@Override
	public int listCount(int memberCode) {
		return personalqDAO.listCount(memberCode);
	}
}
