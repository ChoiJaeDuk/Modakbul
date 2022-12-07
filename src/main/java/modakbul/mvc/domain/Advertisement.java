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
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

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
@ToString
public class Advertisement {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "advertisement_no_seq")
	@SequenceGenerator(name = "advertisement_no_seq" , allocationSize = 1 , sequenceName = "advertisement_no_seq")
	private Long advertisementNo;
	
	@ManyToOne(fetch = FetchType.LAZY) //지연로딩!!
	@JoinColumn(name = "user_no")
	private Users user;
	
	@OneToOne(fetch = FetchType.LAZY) //지연로딩!!
	@JoinColumn(name = "gather_no")
	private Gather gather;
	
	@Column(nullable = false)
	private String adStatus;
	
	@Column(nullable = false)
	private LocalDateTime adRegisDate;
	
	private LocalDateTime adApproveDate;
	
	private LocalDateTime deadLine;
	
	@Column(nullable = false)
	private String adFileName;
	
	@Column(nullable = false)
	private int adPrice;
	
}
