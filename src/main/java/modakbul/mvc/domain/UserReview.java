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
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.CreationTimestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserReview {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_review_no_seq")
	@SequenceGenerator(name = "user_review_no_seq", allocationSize = 1, sequenceName = "user_review_no_seq")
	private Long userReviewNo;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "writerUser_no")
	private Users writerUser;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "hostUser_no")
	private Users hostUser;
	
	@Column(nullable = true)
	private int userTemper;
	
	@Column(nullable = false, length = 3000)
	private String userReviewContent;
	
	@CreationTimestamp
	private LocalDateTime userRevieweRegisDate;

}
