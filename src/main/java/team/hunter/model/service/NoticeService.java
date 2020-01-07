package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Notice;


public interface NoticeService {
	/**
	* ��ü���
	 * */
	Notice selectByCode(int code);
	
	/**
	* �󼼺���
	 * */
	List<Notice> select();
		
	/**
	* ���
	* */
	int insert(Notice dto);
		
	/**
	* ����
	* */
	int delete(int code);
	
	/**
	 * �Խù� ����
	 * */
	int update(Notice code);
}
