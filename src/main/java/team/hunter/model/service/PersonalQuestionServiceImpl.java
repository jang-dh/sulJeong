package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.PersonalQuestionDAO;
import team.hunter.model.dto.PersonalQuestion;
@Service
public class PersonalQuestionServiceImpl implements PersonalQuestionService {
	@Autowired
	private PersonalQuestionDAO personalqDAO;
	@Override
	public List<PersonalQuestion> personalQuestionList(int memberCode) {
		return personalqDAO.personalQuestionList(memberCode);
	}
	@Override
	public int personalQuestionInsert(PersonalQuestion personalQuestion) {
		personalqDAO.personalQuestionInsert(personalQuestion);
		return 0;
	}

}
