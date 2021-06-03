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

					// 포인트 정산 작업 처리
					//challengeDao.challengeResultDone();
					//challengeDao.challengeResultGood();
					//challengeDao.challengeResultPerfect();

					// SQL 실행 : 총 3회
					// 포인트 정산 후 정산결과를 완료 처리
					//challengeDao.challengeResult();

					// 0. 조건 - 정산 작업이 이루어지지 않은 파일이 존재한다면 | 존재하지 않는다면 스케줄러 종료
					//boolean result = challengeDao.checkResult();
					
					//if(result == true) {
						// 1. 도전글 정산 실행 (생성한 뷰 : COMPLETE_CHALLENGE 활용)
						challengeDao.changeChallenge();
						
						// 2. 후원글 정산 실행 (생성한 뷰 : COMPLETE_DONATE 활용)
						challengeDao.changeDonate();
						
						// 3. 해당 기한 만료 도전글에 대하여 정산 결과 변경
						challengeDao.changeResult();
					//} else {
					//destroy();
						System.out.println("정산 작업 종료");
					//}
					
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
		
	}
	
}
