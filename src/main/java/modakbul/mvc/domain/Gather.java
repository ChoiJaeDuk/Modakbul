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

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
public class Gather {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gather_no_seq")
	@SequenceGenerator(name = "gather_no_seq" , allocationSize = 1 , sequenceName = "gather_no_seq")
	private Long gatherNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "category_no")
	private Category category;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "regular_gather_no")
	private RegularGather regularGather;
	
	@Column(nullable = false)
	private String gatherName;
		
	private int gatherMinUsers;
	private int gatherMaxUsers;
	
	private String gatherSelectGender;
	private int gatherMinAge;
	private int gatherMaxAge;
	
	@Column(nullable = false)
	private Date gatherDate;
	@Column(nullable = false)
	private Date gatherDeadline;
	private int gatherTime;
	@Column(nullable = false)
	private String gatherPlace;
	private String gatherPlaceDetail;
	
	@Column(length = 500)
	private String gatherComment;
	
	@Column(nullable = false)
	private String gatherState;
	
	@CreationTimestamp
	private LocalDateTime gatherRegisDate;
	
	private int gatherBid;
	private String gatherImg;
	
	
	public Gather(Long gatherNo) {
		super();
		this.gatherNo = gatherNo;
	}
	
}
