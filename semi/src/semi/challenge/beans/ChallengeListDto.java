package semi.challenge.beans;

public class ChallengeListDto {
	//도전글 정보 저장 변수
	private int challengeNo;
	private String challengeTitle;
	private int challengePushPoint;
	private String challengeStartDate;
	private String challengeEndDate;
	private int challengePercent;
	private int challengeReward;
	private int challengeDonate;
	private String challengeContent;
	private String challengeResult;
	private int challengeRead;
	private int challengeReply;
	
	//회원 정보 저장 변수
	private int memberNo;
	private String memberNick;
	private int memberPoint;
	

	//카테고리 정보 저장 변수
	private int categoryNo;
	private String categorytype;
	
	public ChallengeListDto() {
		super();
	}

	public int getChallengeNo() {
		return challengeNo;
	}

	public void setChallengeNo(int challengeNo) {
		this.challengeNo = challengeNo;
	}

	public String getChallengeTitle() {
		return challengeTitle;
	}

	public void setChallengeTitle(String challengeTitle) {
		this.challengeTitle = challengeTitle;
	}

	public int getChallengePushPoint() {
		return challengePushPoint;
	}

	public void setChallengePushPoint(int challengePushPoint) {
		this.challengePushPoint = challengePushPoint;
	}

	public String getChallengeStartDate() {
		return challengeStartDate;
	}

	public void setChallengeStartDate(String challengeStartDate) {
		this.challengeStartDate = challengeStartDate;
	}

	public String getChallengeEndDate() {
		return challengeEndDate;
	}

	public void setChallengeEndDate(String challengeEndDate) {
		this.challengeEndDate = challengeEndDate;
	}

	public int getChallengePercent() {
		return challengePercent;
	}

	public void setChallengePercent(int challengePercent) {
		this.challengePercent = challengePercent;
	}

	public int getChallengeReward() {
		return challengeReward;
	}

	public void setChallengeReward(int challengeReward) {
		this.challengeReward = challengeReward;
	}

	public int getChallengeDonate() {
		return challengeDonate;
	}

	public void setChallengeDonate(int challengeDonate) {
		this.challengeDonate = challengeDonate;
	}
	
	public String getChallengeContent() {
		return challengeContent;
	}

	public void setChallengeContent(String challengeContent) {
		this.challengeContent = challengeContent;
	}
	
	
	public String getChallengeResult() {
		return challengeResult;
	}

	public void setChallengeResult(String challengeResult) {
		this.challengeResult = challengeResult;
	}

	public int getChallengeRead() {
		return challengeRead;
	}

	public void setChallengeRead(int challengeRead) {
		this.challengeRead = challengeRead;
	}
	
	

	public int getChallengeReply() {
		return challengeReply;
	}

	public void setChallengeReply(int challengeReply) {
		this.challengeReply = challengeReply;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	
	public int getMemberPoint() {
		return memberPoint;
	}

	public void setMemberPoint(int memberPoint) {
		this.memberPoint = memberPoint;
	}
	
	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategorytype() {
		return categorytype;
	}

	public void setCategorytype(String categorytype) {
		this.categorytype = categorytype;
	}

	
	
	
	


}
