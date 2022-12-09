package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;



public interface UserAttachmentsRepository extends JpaRepository<UserAttachments, Long>{

	
	
	@Query("select ua from UserAttachments ua where user=?1")
	List<UserAttachments> selectById(Users user);
	
	@Query("select ua.user from UserAttachments ua where ua.userAttachmentsFileNo=?1")
	Users selectUser(Long serAttachmentsFileNo);
	
}
