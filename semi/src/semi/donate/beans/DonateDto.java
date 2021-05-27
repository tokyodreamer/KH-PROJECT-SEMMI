package semi.donate.beans;

public class DonateDto {
	private int donateNo; // DB : donate_no
	private int donateChallengeNo; // DB : challenge_no (FK : 도전글 DB의 PK)
	private int donateMemberNo; // DB : member_no (FK : 회원 DB의 PK)
	private int donateCategoryNo; // DB : category_no (FK : 카테고리 DB의 PK)
	private int donatePushPoint; // DB : 후원금
	
	public DonateDto() {
		super();
	}

	public int getDonateNo() {
		return donateNo;
	}

	public void setDonateNo(int donateNo) {
		this.donateNo = donateNo;
	}

	public int getDonateChallengeNo() {
		return donateChallengeNo;
	}

	public void setDonateChallengeNo(int donateChallengeNo) {
		this.donateChallengeNo = donateChallengeNo;
	}

	public int getDonateMemberNo() {
		return donateMemberNo;
	}

	public void setDonateMemberNo(int donateMemberNo) {
		this.donateMemberNo = donateMemberNo;
	}

	public int getDonateCategoryNo() {
		return donateCategoryNo;
	}

	public void setDonateCategoryNo(int donateCategoryNo) {
		this.donateCategoryNo = donateCategoryNo;
	}

	public int getDonatePushPoint() {
		return donatePushPoint;
	}

	public void setDonatePushPoint(int donatePushPoint) {
		this.donatePushPoint = donatePushPoint;
	}
	
}
