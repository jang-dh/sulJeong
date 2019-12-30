package team.hunter.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int code;
	private String id;
	private String pwd;
	private String addr;
	private String email;
	private String emailAccept;
	private String name;
	private String phone;
}
