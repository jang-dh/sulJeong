package team.hunter.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Funding {
	private int code;
	private int mdCode;
	private String title;
	private String rewardName;
	private int rewardPrice;
	private int goalPrice;
	private int stackPrice;
	private String image;
	private String category;
	private String openDate;
	private String endDate;
	private String fundingState;
	
	//좋아요 갯수 때문에 추가
	private int cnt;
	
	private Member member;
	
	//이메일 여러사람에게 보내기 할 때 사용(한개의 펀딩에 여러 사람이 펀딩 했을 수 있으니 리스트 필요) - 수녕
	private List<Member> memberList;
}
