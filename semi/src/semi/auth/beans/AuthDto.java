package semi.auth.beans;

import java.sql.Date;

public class AuthDto {

	private double authNo;
	private double authChallengeNo;
	private double authWriter;
	private double authCategoryType;
	private String authTitle;
	private String authContent;
	private Date authTimeLine;
	private String authResult;
	private String authReason;
	//파일 이름, 파일 타임, 파일 사이즈 추가해야 됨 (인증 사진) 
	public double getAuthNo() {
		return authNo;
	}
	public void setAuthNo(double authNo) {
		this.authNo = authNo;
	}
	public double getAuthChallengeNo() {
		return authChallengeNo;
	}
	public void setAuthChallengeNo(double authChallengeNo) {
		this.authChallengeNo = authChallengeNo;
	}
	public double getAuthWriter() {
		return authWriter;
	}
	public void setAuthWriter(double authWriter) {
		this.authWriter = authWriter;
	}
	public double getAuthCategoryType() {
		return authCategoryType;
	}
	public void setAuthCategoryType(double authCategoryType) {
		this.authCategoryType = authCategoryType;
	}
	public String getAuthTitle() {
		return authTitle;
	}
	public void setAuthTitle(String authTitle) {
		this.authTitle = authTitle;
	}
	public String getAuthContent() {
		return authContent;
	}
	public void setAuthContent(String authContent) {
		this.authContent = authContent;
	}
	public Date getAuthTimeLine() {
		return authTimeLine;
	}
	public void setAuthTimeLine(Date authTimeLine) {
		this.authTimeLine = authTimeLine;
	}
	public String getAuthResult() {
		return authResult;
	}
	public void setAuthResult(String authResult) {
		this.authResult = authResult;
	}
	public String getAuthReason() {
		return authReason;
	}
	public void setAuthReason(String authReason) {
		this.authReason = authReason;
	}
	public AuthDto() {
		super();
	}
	
	
}