package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
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
	
	int pageCnt = 3;

	@RequestMapping("/mypage/likes")
	public String likesList(Model model) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Funding> list = likesService.selectFundingByMemberCode(member.getCode());
		if (list.size() > pageCnt)
			list = list.subList(0, pageCnt);
	
		model.addAttribute("list", list);

		return "mypage/likesList";
	}

	@RequestMapping("/mypage/fetchLikesList")
	public @ResponseBody List<Funding> fetchLikesList(int listCnt) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Funding> list = likesService.selectFundingByMemberCode(member.getCode());

		if(list.size() > listCnt + pageCnt)
			list = list.subList(listCnt, listCnt + pageCnt);
		else if(list.size() > listCnt)
			list = list.subList(listCnt, list.size());
		else
			list = list.subList(listCnt, listCnt);
		return list;
	}

	@RequestMapping("/likes/delete")
	public @ResponseBody int deleteLikes(int fundingCode) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int result = likesService.delete(new Likes(member.getCode(), fundingCode));
		
		return result;
	}
	
	
	
	
	
	@ExceptionHandler({Exception.class})
	public String error() {
		return "error/errorPage";
	}
}
