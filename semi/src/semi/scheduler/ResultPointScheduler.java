package semi.scheduler;

import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import semi.challenge.beans.ChallengeDao;

public class ResultPointScheduler extends HttpServlet{
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.println("정산 작업 실행");	
		Timer timer = new Timer();
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
				try {
					// 달성기간이 지났으면서 아직 정산이 이루어지지 않은 항목들에 대해서 정산하는 작업 코드를 작성
					
					ChallengeDao challengeDao = new ChallengeDao();
					
					// 1. 달성률에 따라 정산 작업을 다르게 한다 (달성률 조회)
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
		
		// DAO 구문 실행 조절 (1분에 1번씩 1초 딜레이로 실행)
		timer.scheduleAtFixedRate(task,1000, 1000*60);
	}
	
	@Override
	public void destroy() {
		System.out.println("정산 작업 종료");	
	}
	
}
