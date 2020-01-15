package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Member;
import team.hunter.model.dto.PersonalQuestion;

public interface PersonalQuestionService {
	List<PersonalQuestion> personalQuestionList(Member member);
	
	int personalQuestionInsert(PersonalQuestion personalQuestion);
	
	int listCount(int memberCode);
}
