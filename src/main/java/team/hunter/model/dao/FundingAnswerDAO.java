package team.hunter.model.dao;

import team.hunter.model.dto.FundingAnswer;

public interface FundingAnswerDAO {
	
	int contentInsert(FundingAnswer fundingAnswer);
	
	FundingAnswer selectByCode(int code);
	
	/**
	 * 펀딩 문의에 대한 답변 등록하기
	 * */
	int fundingAnswerinsert(FundingAnswer fundingAnswer);
	
	/**
	 * 펀딩 문의데 대한 답변 상태고드 변환
	 * */
	int updateAnswerCode(int code);

}
