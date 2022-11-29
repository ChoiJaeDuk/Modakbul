package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.Date;

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
import org.springframework.lang.Nullable;

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
public class ServiceQuestion {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "service_question_no_seq")
	@SequenceGenerator(name = "service_question_no_seq" , allocationSize = 1 , sequenceName = "service_question_no_seq")
	private Long serviceQuestionNo;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	@Column(nullable = false)
	private String serviceQuestionSubject;
	@Column(nullable = false)
	private String serviceQuestionContent;
	@CreationTimestamp
	private LocalDateTime serviceQuestionDate;
	private String serviceQuestionPwd;
	private String serviceQuestionReply;
	private String serviceQuestionAnswer;
}
