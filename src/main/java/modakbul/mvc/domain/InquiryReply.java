package modakbul.mvc.domain;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class InquiryReply {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "inquiry_reply_no_seq")
	@SequenceGenerator(name = "inquiry_reply_no_seq" , allocationSize = 1 , sequenceName = "inquiry_reply_no_seq")
	private Long inquiryReplyNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "inq_no")
	private Inquiry inquiry;
	
	@Column(nullable = false, length = 500)
	private String inquiryReplycontent;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	@CreationTimestamp
	private LocalDateTime inquiryReplyRegisDate;
	
}
