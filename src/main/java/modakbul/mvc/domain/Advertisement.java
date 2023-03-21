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
import org.springframework.format.annotation.DateTimeFormat;

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
@ToString
@RequiredArgsConstructor
public class Advertisement {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "advertisement_no_seq")
	@SequenceGenerator(name = "advertisement_no_seq" , allocationSize = 1 , sequenceName = "advertisement_no_seq")
	@NonNull
	private Long advertisementNo;
	
	@ManyToOne(fetch = FetchType.LAZY) //지연로딩!!
	@JoinColumn(name = "user_no")
	private Users user;
	
	@OneToOne(fetch = FetchType.LAZY) //지연로딩!!
	@JoinColumn(name = "gather_no")
	private Gather gather;
	
	@Column(nullable = false)
	@NonNull
	private String adStatus;
	
	@CreationTimestamp
	@Column(nullable = false)
	private LocalDateTime adRegisDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-ddTHH:mm")
	private LocalDateTime adApproveDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-ddTHH:mm")
	private LocalDateTime deadLine;
	
	@Column(nullable = false)
	@NonNull
	private String adFileName;
	
	@Column(nullable = false)
	private int adPrice;

	
}
