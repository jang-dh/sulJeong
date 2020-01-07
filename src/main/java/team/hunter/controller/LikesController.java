package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Likes;
import team.hunter.model.dto.Member;
import team.hunter.model.service.LikesService;

@Controller
public class LikesController {

	@Autowired
	private LikesService likesService;

//	@ResponseBody
//	@RequestMapping(value = "/funding/serialize", method = RequestMethod.POST)
//	public int insertLikes(String fundingCode) {
//		Likes likes = new Likes(3, Integer.parseInt(fundingCode));
//		System.out.println("likes");
//		return likesService.insert(likes);
//	}

	@RequestMapping("/mypage/likes")
	public String likesList(Model model) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Funding> list = likesService.selectFundingByMemberCode(member.getCode());
		if (list.size() > 4)
			list = list.subList(0, 4);

		model.addAttribute("list", list);

		return "mypage/likesList";
	}

	@RequestMapping("/mypage/fetchLikesList")
	public @ResponseBody List<Funding> fetchLikesList(int listCnt) {
		System.out.println("call");
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Funding> list = likesService.selectFundingByMemberCode(member.getCode());

		if (list.size() > listCnt + 4)
			list = list.subList(listCnt, listCnt + 4);
		else
			list = list.subList(listCnt, list.size());

		return list;
	}

}
