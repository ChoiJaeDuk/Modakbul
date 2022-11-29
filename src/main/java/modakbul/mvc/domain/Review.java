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
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
public class Review {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "review_no_seq")
	@SequenceGenerator(name = "review_no_seq" , allocationSize = 1 , sequenceName = "review_no_seq")
	private Long reviewNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "regularGather_no")
	private RegularGather regularGather;
	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "writerUser_no")
	private Users writerUser;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "hostUser_no")
	private Users hostUser;
	
	@Column(nullable = true)
	private int field;
	
	@CreationTimestamp
	private LocalDateTime reviewRegisDate;
	
	
	
	
	
}
