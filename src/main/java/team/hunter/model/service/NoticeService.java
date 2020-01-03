package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Notice;


public interface NoticeService {
	/**
	* 전체출력
	 * */
	Notice selectByCode(int code);
	
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
