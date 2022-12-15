package modakbul.mvc.groupby;

import java.time.LocalDateTime;

public interface SelectGatherStateByUserNo {
	Long getGatherNo();
	
	String getGatherImg();
	
	String getGatherName();
	
	LocalDateTime getGatherDate();
	
	Long getUserReviewNo();
}
