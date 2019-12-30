package team.hunter.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PersonalQuestion {
	private int code;
	private int memberCode;
	private String content;
	private String subject;
	private String regdate;
	private String state;
}
