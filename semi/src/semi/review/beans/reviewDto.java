package semi.review.beans;

import java.sql.Date;

public class reviewDto {

	private int reviewNo;
	private int reviewNick;
	private Date reviewTime;
	private String reviewStar;
	private String reviewContent;
	public reviewDto() {
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
	public String getReviewStar() {
		return reviewStar;
	}
	public void setReviewStar(String reviewStar) {
		this.reviewStar = reviewStar;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

}