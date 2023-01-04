package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.CreationTimestamp;

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
@RequiredArgsConstructor
public class Inquiry {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "inq_no_seq")
	@SequenceGenerator(name = "inq_no_seq" , allocationSize = 1 , sequenceName = "inq_no_seq")
	@NonNull
	private Long inqNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gather_no")
	private Gather gather;
	
	@Column(nullable = false)
	private String inqSubject;

	@Column(nullable = false, length = 3000)
	private String inqContent;
	
	@CreationTimestamp
	private LocalDateTime inqRegisDate;
	
//	//댓글과 연결
//	@OneToMany(mappedBy = "inquiry", cascade = CascadeType.ALL)
//	private List<InquiryReply> inquiryReplyList;
	
}
