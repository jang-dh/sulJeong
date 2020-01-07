package team.hunter.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.LikesDAO;
import team.hunter.model.dto.Likes;

@Service
public class LikesServiceImpl implements LikesService {
	
	@Autowired
	private LikesDAO likesDAO;

	@Override
	public int insert(Likes likes) {
		int result = likesDAO.insert(likes);
		return result;
	}

}
