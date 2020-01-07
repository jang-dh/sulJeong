package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.PersonalQuestion;

public interface PersonalQuestionDAO {
	List<PersonalQuestion> personalQuestionList(int memberCode);
	
	int personalQuestionInsert(PersonalQuestion personalQuestion);

}
