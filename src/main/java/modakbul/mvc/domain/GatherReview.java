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
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.CreationTimestamp;

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
@RequiredArgsConstructor
public class GatherReview {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gather__review_no_seq")
	@SequenceGenerator(name ="gather_review_no_seq" , allocationSize = 1 , sequenceName = "gather_review_no_seq")
	@NonNull
	private Long gatherReviewNo;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "regularGather_no")
	private RegularGather regularGather;
	

	@JsonIgnore
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "writerUser_no")
	private Users writerUser;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "hostUser_no")
	private Users hostUser;
	
	@Column(nullable = true) 
	private double gatherTemper;
	
	@Column(nullable = false, length = 3000)
	private String gatherReviewContent;
	
	@CreationTimestamp
	private LocalDateTime reviewRegisDate;
	
	@JsonIgnore
	@OneToMany(mappedBy = "gatherReview", cascade=CascadeType.ALL)
	private List<GatherReviewReply> gatherReviewReplyList;

//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(name = "gather_no")
//	private Gather gather;
}
