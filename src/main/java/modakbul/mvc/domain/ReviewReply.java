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
public class ReviewReply {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "reviewReply_no_seq")
	@SequenceGenerator(name = "reviewReply_no_seq" , allocationSize = 1 , sequenceName = "reviewReply_no_seq")
	private Long reviewReplyNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "review_no")
	private Review review;
	
	@Column(nullable = false)
	private String replycontent;
	
	@CreationTimestamp
	private LocalDateTime replyRegisDate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private Users user;
	
	
}
