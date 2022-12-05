package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.RegularGather;

public interface RegularGatherRepository extends JpaRepository<RegularGather, Long>, QuerydslPredicateExecutor<RegularGather> {

}
