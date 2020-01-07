package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.PersonalQuestion;

public interface PersonalQuestionService {
	List<PersonalQuestion> personalQuestionList(int memberCode);
	
	int personalQuestionInsert(PersonalQuestion personalQuestion);
}
