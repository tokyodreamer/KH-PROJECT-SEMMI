package semi.auth.beans;

import java.sql.Date;

public class AuthDto {
	//기존 double -> int 로 수정(05/27) 인증글 등록 서블릿 만들면서 형변환 때문에 변경함

	private int authNo;
	private int authChallengeNo;
	private int authWriter;
	private int authCategoryType;
	private String authTitle;
	private String authContent;
	private Date authTimeLine;
	private String authResult;
	private String authReason;
	//파일 이름, 파일 타임, 파일 사이즈 추가해야 됨 (인증 사진) 
	//authFile 관련 Dto 추가
	private String authUploadName;
	private String authSaveName;
	private String authContentType;
	private long authFileSize;
	
	public int getAuthNo() {
		return authNo;
	}
	public void setAuthNo(int authNo) {
		this.authNo = authNo;
	}
	public int getAuthChallengeNo() {
		return authChallengeNo;
	}
	public void setAuthChallengeNo(int authChallengeNo) {
		this.authChallengeNo = authChallengeNo;
	}
	public int getAuthWriter() {
		return authWriter;
	}
	public void setAuthWriter(int authWriter) {
		this.authWriter = authWriter;
	}
	public int getAuthCategoryType() {
		return authCategoryType;
	}
	public void setAuthCategoryType(int authCategoryType) {
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
	
	public String getAuthUploadName() {
		return authUploadName;
	}
	public void setAuthUploadName(String authUploadName) {
		this.authUploadName = authUploadName;
	}
	public String getAuthSaveName() {
		return authSaveName;
	}
	public void setAuthSaveName(String authSaveName) {
		this.authSaveName = authSaveName;
	}
	public String getAuthContentType() {
		return authContentType;
	}
	public void setAuthContentType(String authContentType) {
		this.authContentType = authContentType;
	}
	public long getAuthFileSize() {
		return authFileSize;
	}
	public void setAuthFileSize(long authFileSize) {
		this.authFileSize = authFileSize;
	}
	public AuthDto() {
		super();
	}
	
	
}
