package modakbul.mvc.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

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
@RequiredArgsConstructor
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "category_no_seq")
	@SequenceGenerator(name = "category_no_seq" , allocationSize = 1 , sequenceName = "category_no_seq")
	@NonNull
	private Long categoryNo;
	
	private String categoryName;

}
