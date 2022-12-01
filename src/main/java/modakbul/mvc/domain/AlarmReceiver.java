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
public class AlarmReceiver {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "alarm_receiver_no_seq")
	@SequenceGenerator(name = "alarm_receiver_no_seq" , allocationSize = 1 , sequenceName = "alarm_receiver_no_seq")
	private Long alarmReceiveNo;
	
	@OneToOne(fetch=FetchType.LAZY) //onetoone 맞나영
	@JoinColumn(name = "user_no")
	private Users user;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "alarm_no")
	private Alarm alarm;
	
	@Column(nullable = false)
	private String alarmStatus;
}
