package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import modakbul.mvc.domain.UserAttachments;



public interface UserAttachmentsRepository extends JpaRepository<UserAttachments, Long>{

}
