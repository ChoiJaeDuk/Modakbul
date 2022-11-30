package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Gather;

public interface GatherRepository extends JpaRepository<Gather, Long> , QuerydslPredicateExecutor<Gather> {

}
