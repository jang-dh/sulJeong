package team.hunter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class AdminController {
	
	@RequestMapping("/introduce")
	public String introduce() {
		return "main/introduce";
	}

}
