package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.PersonalAnswer;
import team.hunter.model.dto.PersonalQuestion;


public interface PersonalAnswerDAO {

	List<PersonalQuestion> selectAllQuestion();
	

	PersonalQuestion selectByCodeQuestion(int code);
	
	int insertPersonalAnswer(PersonalAnswer answer);
	
	int updatePersonalQuestionState(int code);
}
