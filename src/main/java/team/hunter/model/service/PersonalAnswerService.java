package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.PersonalAnswer;
import team.hunter.model.dto.PersonalQuestion;

public interface PersonalAnswerService {

	int listCount();
	
	PersonalQuestion selectByCodeQuestion(int code);
	
	int insertPersonalAnswer(PersonalAnswer answer);
	
	List<PersonalQuestion> selectPersonalQuestionPaging(int startIndex, int cntPerPage);

}
