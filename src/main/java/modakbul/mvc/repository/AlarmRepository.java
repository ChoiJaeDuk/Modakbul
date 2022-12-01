package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import modakbul.mvc.domain.Alarm;

public interface AlarmRepository extends JpaRepository<Alarm, Long>{
	
}
