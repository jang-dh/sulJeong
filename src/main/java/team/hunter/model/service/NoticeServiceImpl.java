package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.NoticeDAO;
import team.hunter.model.dto.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDAO dao;

	@Override
	public Notice selectByCode(int code) {
		Notice dto = dao.selectByCode(code);
		if(dto==null) throw new RuntimeException("�������� �󼼺��⸦ �����߽��ϴ�.");
		return dto;
	}

	@Override
	public List<Notice> select() {
		List<Notice> list = dao.select();
		if(list ==null) throw new RuntimeException("�������� ��� ����");
		return list;
	}

	@Override
	public int insert(Notice dto) {
		int result = dao.insert(dto);
		if(result==0) throw new RuntimeException("�������� ��� ����");
		return result;
	}

	@Override
	public int delete(Notice code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Notice code) {
		// TODO Auto-generated method stub
		return 0;
	}

}
