package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.GatherAttachments;
import modakbul.mvc.domain.RegularGather;

public interface GatherAttachmentsRepository extends JpaRepository<GatherAttachments, Long>, QuerydslPredicateExecutor<RegularGather> {

}
