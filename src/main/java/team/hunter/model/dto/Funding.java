package team.hunter.model.dto;

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
	
	private Member member;
}
