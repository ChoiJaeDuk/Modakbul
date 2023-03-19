package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.CreationTimestamp;

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
public class Alarm {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	//@SequenceGenerator(name = "alarm_no_seq" , allocationSize = 1 , sequenceName = "alarm_no_seq")
	private Long alarmNo;
	
	@Column(nullable = false)
	private String alarmSubject;
	
	@Column(length = 300)
	private String alarmContent;
	@CreationTimestamp
	private LocalDateTime issueDate;
	                                                                                                                                                                                                                                                                                                                                                            
}
