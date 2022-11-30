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

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
public class GatherReviewReply {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gather_review_reply_no_seq")
	@SequenceGenerator(name = "gather_review_reply_no_seq" , allocationSize = 1 , sequenceName = "gather_review_reply_no_seq")
	private Long gatherReviewReplyNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gather_review_no")
	private GatherReview gatherReview;
	
	@Column(nullable = false, length = 5000)
	private String gatherReplyContent;
	
	@CreationTimestamp
	private LocalDateTime gatherReviewReplyRegisDate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	
}
