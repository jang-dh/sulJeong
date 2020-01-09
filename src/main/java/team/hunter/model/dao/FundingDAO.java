package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;

public interface FundingDAO {
	/**
	 * 펀딩 목록
	 * */
	public List<Funding> select(String categoryCode, String order, String where, String val);

	/**
	 * 판매자 이름
	 * */
	public List<Funding> selectByMdName(String categoryCode, String order, String where, String val);

	/**
	 * 좋아요
	 * */
	public List<Funding> selectLikesOrder(String categoryCode, String order, String where, String val);

	/**
	 * 판매자 이름 & 좋아요
	 * */
	public List<Funding> selectByMdNameLikesOrder(String categoryCode, String order, String where, String val);

	/**
	 * 펀딩 코드로 검색
	 * */
	public Funding selectByCode(int code);
	
	/**
	 * 좋아요 순 4개
	 * */
	public List<Funding> selectLikesRankFour();
	
	/**
	 * 최신오픈 4개
	 * */
	public List<Funding> selectNewestFour();
	
	/**
	 * 마감임박 4개
	 * */
	public List<Funding> selectLastestFour();
	
	/**
	 * 오픈 예정 펀딩을 오픈 상태로 갱신
	 * */
	public int updateFundingStateOpen();
	
	/**
	 * 진행된 펀딩을 마감
	 * */
	public int updateFundingStateClose();
	
	/**
	 * 달성금액 업데이트
	 * */
	public int updateStackPrice();
}
