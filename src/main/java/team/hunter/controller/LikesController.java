package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.Likes;
import team.hunter.model.service.LikesService;

@Controller
public class LikesController {
	
	@Autowired
	private LikesService likesService;
	
	@RequestMapping("/funding/likes")
	public String insertLikes(Likes likes) {
		System.out.println("likes");
		likesService.insert(likes);
		return "fundingDetail";
	}

}
