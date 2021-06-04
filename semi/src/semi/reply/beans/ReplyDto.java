package semi.reply.beans;

import java.sql.Date;

public class ReplyDto {
	private int replyNo;
	private String replyContent;
	private Date replyTime;
	private int replyWriter;
	private int replyOrigin;
	public ReplyDto() {
		super();
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
	public int getReplyWriter() {
		return replyWriter;
	}
	public void setReplyWriter(int replyWriter) {
		this.replyWriter = replyWriter;
	}
	public int getReplyOrigin() {
		return replyOrigin;
	}
	public void setReplyOrigin(int replyOrigin) {
		this.replyOrigin = replyOrigin;
	}
	
	
	
}
