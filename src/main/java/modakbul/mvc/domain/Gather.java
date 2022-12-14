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

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@RequiredArgsConstructor
@ToString
public class Gather {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gather_no_seq")
	@SequenceGenerator(name = "gather_no_seq" , allocationSize = 1 , sequenceName = "gather_no_seq")
	@NonNull
	private Long gatherNo;
	
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "category_no")
	private Category category;
	
	
	//@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_no")
	private Users user;
	
	@JsonIgnore
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
	@DateTimeFormat(pattern = "yyyy-MM-ddTHH:mm")
	private LocalDateTime gatherDate;
	@DateTimeFormat(pattern = "yyyy-MM-ddTHH:mm")
	@Column(nullable = false)
	private LocalDateTime gatherDeadline;
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
	
	@ColumnDefault("0")
	private int gatherBid;
	private String gatherImg;
	
	@ColumnDefault("0")
	private int likeCount;
	


}
