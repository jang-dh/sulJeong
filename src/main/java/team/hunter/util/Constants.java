package team.hunter.util;
public interface Constants {
	//권한 authority
	String ROLE_ADMIN = "ROLE_ADMIN";
	String ROLE_MEMBER = "ROLE_MEMBER";

  //전통주 카테고리 funding category
	String TAKJU = "301"; // 탁주
	String RICE_WINE = "302"; //청주
	String DISTILL = "303"; //증류주
	String FRUIT_WINE = "304"; //과실주
	String WINE = "305"; //와인

	// 펀딩 오픈 funding open request state
	String REJECTED = "100";
	String APPROVED = "101";
	String CONSIDERING = "102";
	String DONE = "103";

	// 문의 답변 question answer state
	String BEFORE_ANSWER = "200";
	String AFTER_ANSWER = "201";

	// 펀딩 상태 funding state
	String FUNDING_ING = "501";
	String FUNDING_PRE = "502";
	String FUNDING_SUCCESSED = "503";
	String FUNDING_FAILED = "504";
	
	//후원 상태 purchase state
	String PURCHASE_SUCCESSED = "601";
	String PURCHASE_FAILED = "602";
	String PURCHASE_BEFORE = "603";

}
