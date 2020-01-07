package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Notice;

public interface NoticeService {
	/**
	* 코드번호로 검색
	 * */
	Notice selectByCode(int code);
	
	/**
	* 전체검색
	 * */
	List<Notice> select();
		
	/**
	* 공지사항 등록
	* */
	int insert(Notice dto);
		
	/**
	* 공지사항 삭제
	* */
	int delete(int code);
	
	/**
	 * 공지사항 수정
	 * */
	int update(Notice code);
}
