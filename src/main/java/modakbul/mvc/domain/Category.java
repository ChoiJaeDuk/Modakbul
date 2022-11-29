package modakbul.mvc.domain;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "category_no_seq")
	@SequenceGenerator(name = "category_no_seq" , allocationSize = 1 , sequenceName = "category_no_seq")
	private String categoryNo;
	
	private String categoryName;
}
