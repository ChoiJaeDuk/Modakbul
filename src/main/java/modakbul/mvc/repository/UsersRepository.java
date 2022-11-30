package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import modakbul.mvc.domain.Users;

public interface UsersRepository extends JpaRepository<Users, Long> {

}
