package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Member;
import team.hunter.model.dto.PersonalQuestion;

public interface PersonalQuestionDAO {
	List<PersonalQuestion> personalQuestionList(Member member);
	
	int personalQuestionInsert(PersonalQuestion personalQuestion);
	
	int listCount(int memberCode);

}
