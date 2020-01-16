package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;

@Repository
public class EmailAlertDAOImpl implements EmailAlertDAO {
	
	@Autowired SqlSession session;

	@Override
	public List<Funding> fundingSuccessAlert() {
		List<Funding> fundingSuccessList = session.selectList("emailAlertMapper.emailFundingSuccess");
		System.out.println("다오 들리니??");
		for(Funding funding : fundingSuccessList) {
			System.out.println(funding.getRewardName());
			for(Member member : funding.getMemberList()) {
				System.out.println(member.getEmail());
			}
		}
		return fundingSuccessList;
	}

	@Override
	public List<Funding> fundingFailAlert() {
		List<Funding> fundingFailList = session.selectList("emailAlertMapper.emailFundingFail");
		return fundingFailList;
	}

	@Override
	public List<Member> emailAcceptMember() {
		List<Member> emailAcceptList = session.selectList("emailAlertMapper.emailAgreeMember");
		return emailAcceptList;
	}

	@Override
	public List<Funding> fundingOneDayBefore() {
		List<Funding> fundingBeforeList = session.selectList("emailAlertMapper.emailFundingMember");
		return fundingBeforeList;
	}

	@Override
	public List<Funding> fundingOneDayBeforeLikes() {
		List<Funding> fundingBeforeLikesList = session.selectList("emailAlertMapper.emailFundingMemberLike");
		return fundingBeforeLikesList;
	}

	

}
