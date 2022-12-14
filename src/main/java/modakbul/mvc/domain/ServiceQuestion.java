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
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.lang.Nullable;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
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
	
	@JsonIgnore
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	@Column(nullable = false)
	private String serviceQuestionSubject;
	
	@Column(nullable = false, length = 3000)
	private String serviceQuestionContent;
	
	@CreationTimestamp
	private LocalDateTime serviceQuestionDate;
	
	private String serviceQuestionPwd;
	
	@Column(length = 3000)
	private String serviceQuestionReply;
	
	@UpdateTimestamp
	private LocalDateTime serviceQuestionReplyDate;
}
