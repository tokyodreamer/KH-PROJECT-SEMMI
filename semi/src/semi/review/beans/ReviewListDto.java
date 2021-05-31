package semi.review.beans;

import java.sql.Date;

public class ReviewListDto {
	
	private int reviewNo;
	private int reviewNick;
	private Date reviewTime;
	private int reviewStar;
	private String reviewContent;
	

	private String memberNick;

	public ReviewListDto() {
		super();
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getReviewNick() {
		return reviewNick;
	}

	public void setReviewNick(int reviewNick) {
		this.reviewNick = reviewNick;
	}

	public Date getReviewTime() {
		return reviewTime;
	}

	public void setReviewTime(Date reviewTime) {
		this.reviewTime = reviewTime;
	}

	public int getReviewStar() {
		return reviewStar;
	}

	public void setReviewStar(int reviewStar) {
		this.reviewStar = reviewStar;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	
	
	
}
