package semi.scheduler;

import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import semi.challenge.beans.ChallengeDao;

public class TestScheduler extends HttpServlet{
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
					
					// DAO : 서버 켜지는 순간 4번의 메소드 실행
					ChallengeDao challengeDao = new ChallengeDao();
					
					// 포인트 정산 작업 처리
					challengeDao.challengeResultDone();
					challengeDao.challengeResultGood();
					challengeDao.challengeResultPerfect();
					
					// 포인트 정산 후 정산결과를 완료 처리
					challengeDao.challengeResult();
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
		
		// DAO 구문 발동 조절용
		timer.scheduleAtFixedRate(task,1000, 6000);
	}
	
	@Override
	public void destroy() {
		super.destroy();
	}
}
