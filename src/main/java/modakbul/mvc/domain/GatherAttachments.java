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
public class GatherAttachments {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gather_attachments_no_seq")
	@SequenceGenerator(name = "gather_attachments_no_seq" , allocationSize = 1 , sequenceName = "gather_attachments_no_seq")
	private Long gatherAttachmentsFileNo;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "gather_no")
	private Gather gather;
	
	@Column(nullable = false)
	private String gatherAttachmentsFileName;
	
	@Column(nullable = false)
	private String gatherAttachmentsFileSubject;
}
