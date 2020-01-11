package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Member;

public interface FundingQuestionDAO {
	/*
	 * 펀딩 문의 등록하기
	 */
	int insert(FundingQuestion fundingQuestion);

	List<FundingQuestion> fundingQuestionList(Member member);
	
	FundingQuestion selectByCode(int code);
	
	int listCount(int memberCode);

}
