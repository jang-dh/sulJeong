package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.LikesDAO;
import team.hunter.model.dto.Funding;
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

	@Override
	public List<Funding> selectFundingByMemberCode(int memberCode) {
		List<Funding> list = likesDAO.selectFundingByMemberCode(memberCode);
		return list;
	}

	@Override
	public int delete(Likes likes) {
		int result = likesDAO.delete(likes);
		return result;
	}

	@Override
	public Likes select(Likes likes) {
		Likes result = likesDAO.select(likes);
		return result;
	}
}
