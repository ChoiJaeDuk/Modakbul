package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonProperty;

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
public class RegularGather {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "regularGather_no_seq")
	@SequenceGenerator(name = "regularGather_no_seq" , allocationSize = 1 , sequenceName = "regularGather_no_seq")
	@NonNull
	private Long regularGatherNo;
	
	private int regularGatherCycle;
	
	@Column(nullable = false)
	@JsonProperty("regularGatherDay")
	private String regularGatherDay;//정기모임요일
	
	@ColumnDefault("50")
	private double gatherTemper;
	
	@ColumnDefault("0")
	private int gatherTemperCount;
	
	@Column(nullable = false)
	private String regularGatehrState;
	
	@CreationTimestamp
	private LocalDateTime regularGatherRegisDate;

	@OneToMany(mappedBy = "regularGather", cascade = CascadeType.ALL) //모임에 대한 후기 
	private List<GatherReview> gatherReivew;
	
	@OneToMany(mappedBy = "hostUser", cascade = CascadeType.ALL)
	private List<UserReview> userReviewList;
}
