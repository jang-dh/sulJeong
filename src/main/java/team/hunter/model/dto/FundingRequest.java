package team.hunter.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FundingRequest {
	private int code;
	private int memberCode;
	private String subject;
	private String filename;
	private String state;
}
