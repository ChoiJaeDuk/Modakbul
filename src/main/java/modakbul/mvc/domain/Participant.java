package modakbul.mvc.domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
public class Participant {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "participant_no_seq")
	@SequenceGenerator(name = "participant_no_seq" , allocationSize = 1 , sequenceName = "participant_no_seq")
	private Long participantNo;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gather_no")
	private Gather gather;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_no")
	private Users user;
	
	
	private String applicationState;
}
