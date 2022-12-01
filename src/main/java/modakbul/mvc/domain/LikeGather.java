package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

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
public class LikeGather {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "attention_no_seq")
	@SequenceGenerator(name = "attention_no_seq" , allocationSize = 1 , sequenceName = "attention_no_seq")
	private Long attentionNo;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gather_no")
	private Gather gather;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	
	/*
	 * @OneToMany(mappedBy = "Gather", cascade = CascadeType.ALL) private
	 * List<Gather> gatherList;
	 */
	
	
}
