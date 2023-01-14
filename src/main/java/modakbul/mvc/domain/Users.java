package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicInsert;

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
public class Users {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_no_seq")
	@SequenceGenerator(name = "user_no_seq" , allocationSize = 1 , sequenceName = "user_no_seq")
	@NonNull
	private Long userNo;
	
	@Column(unique = true, nullable = true)
	private String userId;
	
	@Column(nullable = false)
	private String userpwd;
	private String userName;
	
	@Column(unique = true, nullable = true)
	private String userNick;
	

	private String userGender;
	
	@Column(unique = true)
	private String userEmail;
	
	@Column(nullable = false)
	private String userValidateNo;
	
	@Column(nullable = false)
	private String userPhone;
	
	@Column(nullable = false)
	private String userPostCode;
	
	@Column(nullable = false)
	private String userAddr;
	
	@Column(nullable = false)
	private String userAddrDetail;
	
	@Column(nullable = false)
	private String userJob;
	
	@CreationTimestamp
	private LocalDateTime userJoinDate;
	
	@ColumnDefault("50")
	private double temper;
	
	@ColumnDefault("1")
	private int temperCount;
	private String userProfileImg;
	
	@JsonIgnore
	@Column(name = "state")
	@Enumerated(EnumType.STRING)
	private Role state;

//	@JsonIgnore
//	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
//	private List<UserAttachments> userAttachList;
//	
	@JsonIgnore
	@OneToMany(mappedBy = "followingUser", cascade = CascadeType.ALL)
	private List<Follow> followingList;
	
	@JsonIgnore
	@OneToMany(mappedBy = "followerUser", cascade = CascadeType.ALL)
	private List<Follow> followerList;
//	
//	@JsonIgnore
//	@OneToMany(mappedBy = "hostUser", cascade = CascadeType.ALL)
//	private List<UserReview> userReviewList;
//	
//	@JsonIgnore
//	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
//	private List<ServiceQuestion> serviceQuestionList;
	/*
	 * @OneToMany(mappedBy = "user", cascade = CascadeType.ALL) private
	 * List<GatherReview> gatherReviewList;
	 */
	

}
