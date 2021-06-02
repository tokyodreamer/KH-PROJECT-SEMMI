package semi.review.beans;

import java.sql.Date;

public class ReviewDto {

	private int reviewNo;
	private int reviewNick; // 후기 작성자
	private Date reviewTime;
	private int reviewStar;
	private String reviewContent;
	public ReviewDto() {
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
}
