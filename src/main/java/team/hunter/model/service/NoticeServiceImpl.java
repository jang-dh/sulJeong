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
		if(dto==null) throw new RuntimeException("공지사항 상세보기를 실패했습니다.");
		return dto;
	}

	@Override
	public List<Notice> select() {
		List<Notice> list = dao.select();
		if(list ==null) throw new RuntimeException("공지사항 출력 실패");
		return list;
	}

	@Override
	public int insert(Notice dto) {
		int result = dao.insert(dto);
		if(result==0) throw new RuntimeException("공지사항 등록 실패");
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
