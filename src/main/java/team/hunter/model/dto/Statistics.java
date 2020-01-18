package team.hunter.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Statistics {
	private String regdate;
	private int visit;
	private int purchasePrice;
	private int purchaseCount;
	private int fundingApply;
	private int cancelPrice;
}
