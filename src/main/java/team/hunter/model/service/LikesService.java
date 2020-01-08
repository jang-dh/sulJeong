package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Likes;

public interface LikesService {
	/*
	 * 펀딩상세페이지에서 좋아요 누르기
	 */
	int insert(Likes likes);
	
	/**
	 * 멤버 코드로 '좋아요'한 펀딩 목록 검색
	 * */
	List<Funding> selectFundingByMemberCode(int memberCode);
	
	/**
	 * 좋아요 삭제
	 * */
	int delete(Likes likes);
	
	/**
	 * 특정 좋아요 찾기
	 * */
	Likes select(Likes likes);
}
