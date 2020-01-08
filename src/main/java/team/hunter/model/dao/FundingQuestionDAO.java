package team.hunter.model.dao;

import team.hunter.model.dto.FundingQuestion;
import java.util.List;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;

public interface FundingQuestionDAO {
	/*
	 * 펀딩 문의 등록하기
	 */
	int insert(FundingQuestion fundingQuestion);

	List<FundingQuestion> fundingQuestionList(int memberCode);
	
	FundingQuestion selectByCode(int code);
}
