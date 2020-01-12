package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.PersonalAnswer;
import team.hunter.model.dto.PersonalQuestion;


public interface PersonalAnswerDAO {

	int listCount();
	

	PersonalQuestion selectByCodeQuestion(int code);
	
	int insertPersonalAnswer(PersonalAnswer answer);
	
	int updatePersonalQuestionState(int code);
	
	List<PersonalQuestion> selectPersonalQuestionPaging(int startIndex, int cntPerPage);
	
}
