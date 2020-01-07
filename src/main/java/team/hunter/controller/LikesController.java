package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import team.hunter.model.dto.Likes;
import team.hunter.model.service.LikesService;

@Controller
public class LikesController {
	
//	@Autowired
//	private LikesService likesService;
//	
//	@ResponseBody
//	@RequestMapping(value = "/funding/serialize", method = RequestMethod.POST)
//	public int insertLikes(String fundingCode) {
//		Likes likes = new Likes(3, Integer.parseInt(fundingCode));
//		System.out.println("likes");
//		return likesService.insert(likes);
//	}

}
