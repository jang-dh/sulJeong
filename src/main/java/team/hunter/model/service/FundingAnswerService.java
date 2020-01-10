package team.hunter.model.service;

import team.hunter.model.dto.FundingAnswer;
import team.hunter.model.dto.FundingQuestion;

public interface FundingAnswerService {
	int contentInsert(FundingAnswer fundingAnswer);
	
	FundingAnswer selectByCode(int code);
	
	/**
	 * 펀딩 문의에 대한 답변 등록하기
	 * */
	int fundingAnswerinsert(FundingAnswer fundingAnswer);
	
	
	FundingQuestion selectByCodeQuestion(int code);
	
}
