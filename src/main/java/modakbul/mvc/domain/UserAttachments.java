package modakbul.mvc.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class UserAttachments {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_attachments_no_seq")
	@SequenceGenerator(name = "user_attachments_no_seq" , allocationSize = 1 , sequenceName = "user_attachments_no_seq")
	private Long userAttachmentsFileNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="user_no")
	@NonNull
	@JsonIgnore
	private Users user;
	
	@Column(nullable = false)
	private String userAttachmentsFileName;
	
	@Column(nullable = false)
	private String userAttachmentsFileSubject;
	

}
