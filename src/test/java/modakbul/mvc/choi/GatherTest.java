package modakbul.mvc.choi;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Category;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.GatherRepository;

@SpringBootTest
@Transactional
@Commit
public class GatherTest {
	
	Users user = new Users(1L);
	Category category = new Category(1L);
	RegularGather regularGather = new RegularGather(1L);
	
	@Autowired
	GatherRepository gatherRep;
	@Test
	void contextLoads() {
		System.out.println("gatherRep = " + gatherRep);
	}
	
	@Test
	void gatherInsert() {
		String sDate = "2022.12.09 20:00";
		String sDate2 = "2022.12.09 10:00";
		SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd hh:mm");
		Date d = null;
		Date d2 = null;
		try {
			d = date.parse(sDate);
			d2 = date.parse(sDate2);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Gather gather = new Gather(1L, category, user, regularGather, "풋살할사람~!", 12, 18, "남자", 20, 35, d, d2, 2, "성남시 야탑", "1층 풋살장", "즐겁게 운동하실분들 많이 모이세요!", "모집중", null , 0, null);
		gatherRep.save(gather);
	}
	
	@Test
	public void selectGather() {
		Optional<Gather> op = gatherRep.findById(5L);
		Gather gather = op.orElse(null);
		System.out.println(gather);
	}
}
