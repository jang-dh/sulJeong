package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.EmailAlertDAO;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;

@Service
public class EmailAlertServiceImpl implements EmailAlertService {
	
	@Autowired EmailAlertDAO emailAlertDAO;

	@Override
	public List<Funding> fundingSuccessAlert() {
		System.out.println("서비스 들리니?");
		List<Funding> fundingSuccessList = emailAlertDAO.fundingSuccessAlert();
		return fundingSuccessList;
	}

	@Override
	public List<Funding> fundingFailAlert() {
		List<Funding> fundingFailList = emailAlertDAO.fundingFailAlert();
		return fundingFailList;
	}

	@Override
	public List<Member> emailAcceptMember() {
		List<Member> emailAcceptList = emailAlertDAO.emailAcceptMember();
		return emailAcceptList;
	}

	@Override
	public List<Funding> fundingOneDayBefore() {
		List<Funding> fundingBeforeList = emailAlertDAO.fundingOneDayBefore();
		return fundingBeforeList;
	}

	@Override
	public List<Funding> fundingOneDayBeforeLikes() {
		List<Funding> fundingBeforeLikesList = emailAlertDAO.fundingOneDayBeforeLikes();
		return fundingBeforeLikesList;
	}

}
