package modakbul.mvc.domain;

import java.time.LocalDateTime;

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
public class Follow {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "follow_no_seq")
	@SequenceGenerator(name = "follw_no_seq" , allocationSize = 1 , sequenceName = "follow_no_seq")
	private Long followNo;
	
	@ManyToOne
	@JoinColumn(name = "following_no")
	private Users followingUser;
	
	@ManyToOne
	@JoinColumn(name = "follower_no")
	private Users followerUser;
}
