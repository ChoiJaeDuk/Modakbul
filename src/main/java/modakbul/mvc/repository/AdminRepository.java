package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import modakbul.mvc.domain.Advertisement;

public interface AdminRepository extends JpaRepository<Advertisement, Long>, QuerydslPredicateExecutor<Advertisement> {

	
}
