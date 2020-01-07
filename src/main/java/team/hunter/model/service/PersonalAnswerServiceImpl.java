package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.PersonalAnswerDAO;
import team.hunter.model.dto.PersonalQuestion;

@Service
public class PersonalAnswerServiceImpl implements PersonalAnswerService {

	@Autowired
	private PersonalAnswerDAO personalAnswerDAO;
	
	@Override
	public List<PersonalQuestion> selectAll() {
		
		List<PersonalQuestion> list = personalAnswerDAO.selectAll();
		
		return list;
	}

}
