package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Likes;
import team.hunter.model.dto.Member;
import team.hunter.model.service.LikesService;

@Controller
public class LikesController {

	@Autowired
	private LikesService likesService;

	@RequestMapping("/mypage/likes")
	public String likesList(Model model) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Funding> list = likesService.selectFundingByMemberCode(member.getCode());
		if (list.size() > 3)
			list = list.subList(0, 3);
	
		model.addAttribute("list", list);

		return "mypage/likesList";
	}

	@RequestMapping("/mypage/fetchLikesList")
	public @ResponseBody List<Funding> fetchLikesList(int listCnt) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Funding> list = likesService.selectFundingByMemberCode(member.getCode());

		if (list.size() > listCnt + 3)
			list = list.subList(listCnt, listCnt + 3);
		else
			list = list.subList(listCnt, list.size());

		return list;
	}

	@RequestMapping("/likes/delete")
	public @ResponseBody int deleteLikes(int fundingCode) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int result = likesService.delete(new Likes(member.getCode(), fundingCode));
		
		return result;
	}
}
