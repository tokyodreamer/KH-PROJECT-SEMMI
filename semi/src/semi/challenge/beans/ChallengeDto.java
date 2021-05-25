package semi.challenge.beans;

import java.util.Date;

public class ChallengeDto {
	private int challengeNo;
	private int challengeWriter; // FK : memberNo
	private int categoryNo; // FK : categoryNo -> categoryType
	private String challengeTitle;
	private int challengePushPoint;
	private Date challengeStartDate;
	private Date challengeEndDate;
	private int challengePercent;
	private int challengeReward;
	private int challengeDonate;
	private String challengeContent;
	
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

	public Date getChallengeStartDate() {
		return challengeStartDate;
	}

	public void setChallengeStartDate(Date challengeStartDate) {
		this.challengeStartDate = challengeStartDate;
	}

	public Date getChallengeEndDate() {
		return challengeEndDate;
	}

	public void setChallengeEndDate(Date challengeEndDate) {
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
	
}
