package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.PersonalQuestion;

public interface PersonalAnswerService {

	List<PersonalQuestion> selectAll();
	
}
