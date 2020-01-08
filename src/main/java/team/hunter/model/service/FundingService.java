package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Funding;

public interface FundingService {
	/**
	 * 조건 별 펀딩 목록
	 * */
	public List<Funding> selectList(int categoryCode, String order, String where, String val);

	/**
	 * 펀딩 코드로 펀딩 찾기
	 * */
	public Funding selectByCode(int code);

	/**
	 * 좋아요 순 4개
	 * */
	public List<Funding> selectLikesRankFour();

	/**
	 * 마감임박 4개
	 * */
	public List<Funding> selectLastestFour();

	/**
	 * 최신오픈 4개
	 * */
	public List<Funding> selectNewestFour();
	
	/**
	 * 오픈 예정 펀딩을 오픈 상태로 갱신
	 * */
	public int updateFundingState();
}
