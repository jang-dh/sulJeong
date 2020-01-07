package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.PersonalQuestion;


public interface PersonalAnswerDAO {

	List<PersonalQuestion> selectAll();
}
