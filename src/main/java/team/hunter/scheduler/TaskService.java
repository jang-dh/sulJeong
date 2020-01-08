package team.hunter.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class TaskService {
 
	@Scheduled(cron="0/3 * * * * *")
    public void TestScheduler(){
        System.out.println("스케줄링 테스트");
    }
}


