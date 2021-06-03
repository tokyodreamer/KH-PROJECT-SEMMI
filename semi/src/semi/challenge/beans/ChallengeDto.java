package semi.challenge.beans;

import java.util.Date;

public class ChallengeDto {
	private int challengeNo;
	private int challengeWriter; // FK : memberNo
	private int categoryNo; // FK : categoryNo -> categoryType
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
	
	public ChallengeDto() {
		super();
	}

	public int getChallengeNo() {
		return challengeNo;
	}

	public void setChallengeNo(int challengeNo) {
		this.challengeNo = challengeNo;
	}

	public int getChallengeWriter() {
		return challengeWriter;
	}

	public void setChallengeWriter(int challengeWriter) {
		this.challengeWriter = challengeWriter;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
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
	
	
}
