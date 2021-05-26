package semi.beans;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JDBCUtils {
	// DBCP 연결 기능
		// = context.xml 에 적용해놓은 설정을 토대로 운영되는 apache-common-dbcp 라이브러리를 이용하여 연결
		// = 신규 연결을 생성하는 것이 아니라 이미 만들어진 연결을 대여하여 사용하는 방식
		// = 연결에 소모되는 시간이 사라져서 성능적으로 큰 향상이 있다
		
		// = 등록되어 실행중인 라이브러리 자원(DataSource)을 불러와야 연결을 사용할 수 있다. 
		// = 프로그램이 시작하면 최초 1회에 거쳐 context.xml 에 등록된 resource 자원을 불러와야 한다.
		
		// private static DataSource ds = context.xml 에 등록된 <Resource> 중에서 jbdc/oracle란 이름을 가진 도구;
		private static DataSource ds;
		static {
			try {
				// 1. 자원 탐색 도구를 생성한다(Initial Context)
				Context ctx = new InitialContext();
				// 2. 경로를 식으로 알려주고 탐색을 명한다.
				ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/oracle");
			} catch (Exception e) {
				System.err.println("데이터베이스 연결 실패");
				e.printStackTrace();
			}
		}
		
		public static Connection getConnection() throws Exception {
			return ds.getConnection();
		}
}

