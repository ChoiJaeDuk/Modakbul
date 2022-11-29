package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.ColumnDefault;
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
public class Users {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_no_seq")
	@SequenceGenerator(name = "user_no_seq" , allocationSize = 1 , sequenceName = "user_no_seq")
	private Long userNo;
	
	@Column(unique = true, nullable = true)
	private String userId;
	
	@Column(nullable = false)
	private String userpwd;
	private String userName;//
	
	@Column(unique = true, nullable = true)
	private String userNick;
	
	@Column(nullable = false)
	private String userGender;
	
	@Column(unique = true)
	private String userEmail;
	
	@Column(nullable = false)
	private String userValidateNo;
	
	@Column(nullable = false)
	private String userPhone;
	
	@Column(nullable = false)
	private Date userPostCode;
	
	@Column(nullable = false)
	private String userAddr;
	
	@Column(nullable = false)
	private String userAddrDetail;
	
	@Column(nullable = false)
	private String userJob;
	
	@CreationTimestamp
	private LocalDateTime userJoinDate;
	
	@ColumnDefault("50")
	private int temper;
	private int temperCount;
	private String userProfileImg;
	
}
