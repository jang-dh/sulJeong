package team.hunter.model.dao;

import team.hunter.model.dto.Likes;

public interface LikesDAO {
	
	/*
	 * 펀딩상세페이지에서 좋아요 누르기
	 */
	int insert(Likes likes);
	

}
