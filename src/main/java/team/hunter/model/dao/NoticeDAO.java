package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Notice;

public interface NoticeDAO {
	/**
	* 전체출력
	 * */
	List<Notice> selectByCode(int code);
	
	/**
	* 상세보기
	 * */
	List<Notice> select();
		
	/**
	* 등록
	* */
	int insert(Notice dto);
		
	/**
	* 삭제
	* */
	int delete(Notice code);
	
	/**
	 * 게시물 수정
	 * */
	int update(Notice code);
}
