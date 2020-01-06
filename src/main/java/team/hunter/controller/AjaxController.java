package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import team.hunter.model.dto.Likes;
import team.hunter.model.dto.Member;
import team.hunter.model.service.LikesService;
import team.hunter.model.service.MemberService;

@RestController
public class AjaxController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private LikesService likesService;

	@PostMapping("/findId")
	public Member findId(Member member) {
		System.out.println(member.getName() + member.getPhone());
		return memberService.selectByPhone(member);
	}

	@RequestMapping(value = "/funding/insertLikes", method = RequestMethod.POST)
	public int insertLikes(String fundingCode) {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication();
		Likes likes = new Likes(member.getCode(), Integer.parseInt(fundingCode));
		return likesService.insert(likes);
	}
	
}
