package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import team.hunter.model.dao.PersonalAnswerDAO;
import team.hunter.model.dto.PersonalAnswer;
import team.hunter.model.dto.PersonalQuestion;

@Service
public class PersonalAnswerServiceImpl implements PersonalAnswerService {

	@Autowired
	private PersonalAnswerDAO personalAnswerDAO;
	
	@Override
	public List<PersonalQuestion> selectAll() {
		
		List<PersonalQuestion> list = personalAnswerDAO.selectAllQuestion();
		
		return list;
	}
	
	@Override
	public PersonalQuestion selectByCodeQuestion(int code) {
		
		PersonalQuestion question = personalAnswerDAO.selectByCodeQuestion(code);
		
		System.out.println("###################################################");
		System.out.println(question);
		
		return question;
	}
	
	
	@Override
	@Transactional
	public int insertPersonalAnswer(PersonalAnswer answer) {
		
		int result = personalAnswerDAO.insertPersonalAnswer(answer);
		int result2 = personalAnswerDAO.updatePersonalQuestionState(answer.getQuestionCode());
		if(result == 0) throw new RuntimeException("1:1 문의사항 답변 등록 실패");
		if(result2 == 0) throw new RuntimeException("1:1 문의사항 상태 갱신 실패");
		
		return result;
	}
	

}
