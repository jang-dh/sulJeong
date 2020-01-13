package team.hunter.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Notice;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public Notice selectByCode(int code) {
		
		return session.selectOne("noticeMapper.selectByCode", code);
	}

	@Override
	public List<Notice> select() {
		
		return session.selectList("noticeMapper.selectAll");
	}

	@Override
	public int insert(Notice dto) {

		return session.insert("noticeMapper.insert",dto );
	}

	@Override
	public int delete(int code) {
		// TODO Auto-generated method stub
		return session.delete("noticeMapper.delete", code);
	}

	@Override
	public int update(Notice notice) {
		
		return session.update("noticeMapper.update", notice);
	}

	@Override
	public List<FundingRequest> selectFundingRequest() {
		
		return session.selectList("noticeMapper.selectFundingRequest");
	}

	@Override
	public int fundInsert(Funding funding) {
		
		return session.insert("noticeMapper.fundInsert", funding);
	}

	@Override
	public FundingRequest selectFundingRequestByCode(int code) {
		
		return session.selectOne("noticeMapper.selectFundingRequestByCode", code);
	}

	@Override
	public int fundingRequestReject(int code) {

		return session.update("noticeMapper.fundingRequestReject", code);
	}

	@Override
	public int fundingRequestApprove(int code) {
		
		return session.update("noticeMapper.fundingRequestApprove", code);
	}


	@Override
	public int fundingRequestStateChange(int code) {
		
		return session.update("noticeMapper.fundingRequestStateChange", code);
	}

	@Override
	public int listCount() {
		
		return session.selectOne("noticeMapper.listCount");
	}

	@Override
	public List<Notice> NoticeList(int startIndex, int cntPerPage) {
		Map<String , Integer> map = new HashMap<String, Integer>();
		map.put("startIndex", startIndex);
		map.put("cntPerPage", cntPerPage);
		
		return session.selectList("noticeMapper.noticeList", map);
	}

	@Override
	public int fundingRequestlistCount() {
		
		return session.selectOne("noticeMapper.fundingRequestlistCount");
	}

	@Override
	public List<FundingRequest> fundingRequestList(int startIndex, int cntPerPage) {
		Map<String , Integer> map = new HashMap<String, Integer>();
		map.put("startIndex", startIndex);
		map.put("cntPerPage", cntPerPage);
		return session.selectList("noticeMapper.fundingRequestList", map);
	}

}
