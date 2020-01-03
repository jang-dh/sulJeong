package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Notice;

public interface NoticeDAO {
	/**
	* ��ü���
	 * */
	List<Notice> selectByCode(int code);
	
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
	int delete(Notice code);
	
	/**
	 * �Խù� ����
	 * */
	int update(Notice code);
}
