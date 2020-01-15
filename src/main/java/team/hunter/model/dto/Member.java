package team.hunter.model.dto;

import java.util.ArrayList;
import java.util.List;

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
	
	private int startIndex;
	private int cntPerPage;
	
	private Purchase purchase;
	
	//이메일 인증으로 속성값 2개 추가
	private String authkey; //권한키
	private int authstatus; //권한상태
}
