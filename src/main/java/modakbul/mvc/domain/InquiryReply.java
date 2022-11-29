package modakbul.mvc.domain;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;

public class InquiryReply {
	private Long replyNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "inq_no")
	private Inquiry inquiry;
	
	@Column(nullable = false)
	private String replycontent;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private Users user;
	
	@CreationTimestamp
	private LocalDateTime replyRegisDate;
	
}
