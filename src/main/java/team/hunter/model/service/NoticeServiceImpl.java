package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.NoticeDAO;
import team.hunter.model.dao.StatisticsDAO;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDAO dao;
	@Autowired
	private StatisticsDAO statisticsDAO;

	@Override
	public Notice selectByCode(int code) {

		Notice dto = dao.selectByCode(code);
		if(dto==null) throw new RuntimeException("공지사항 조회에 실패했습니다.");
		return dto;

	}

	@Override
	public List<Notice> select() {
		List<Notice> list = dao.select();
		if(list ==null) throw new RuntimeException("상세페이지 조회에 실패했습니다.");
		return list;
	}

	@Override
	public int insert(Notice dto) {
		int result = dao.insert(dto);
		if(result==0) throw new RuntimeException("공지사항 등록에 실패했습니다.");
		return result;
	}

	@Override
	public int delete(int code) {
		int result = dao.delete(code);
		if(result==0) throw new RuntimeException("공지사항 삭제에 실패했습니다.");
		return result;
	}

	@Override
	public int update(Notice code) {
		int result = dao.update(code);
		if(result==0) throw new RuntimeException("공지사항 수정에 실패했습니다.");
		return result;
	}

	@Override
	public List<FundingRequest> selectFundingRequest() {
		List<FundingRequest> list = dao.selectFundingRequest();
		if(list ==null) throw new RuntimeException("오류입니다.");
		return list;
	}

	@Override
	public int fundInsert(Funding funding, int code) {
		int result = dao.fundInsert(funding);
		int result2 = dao.fundingRequestStateChange(code);
		int result3 = statisticsDAO.updateFundingApply();
		if(result==0) throw new RuntimeException("펀딩 등록에 실패했습니다.");
		return result;
	}
	

	@Override
	public FundingRequest selectFundingRequestByCode(int code) {
		FundingRequest fundingRequest = dao.selectFundingRequestByCode(code);
		if(fundingRequest==null) throw new RuntimeException("해당 페이지 조회에 실패했습니다.");
		return fundingRequest;
	}

	@Override
	public int fundingRequestReject(int code) {
		int result = dao.fundingRequestReject(code);
		if(result==0) throw new RuntimeException("펀딩등록 거절 실패");
		return result;
	}

	@Override
	public int fundingRequestApprove(int code) {
		int result = dao.fundingRequestApprove(code);
		if(result==0) throw new RuntimeException("펀딩등록 승인 실패");
		return result;
	}

}
