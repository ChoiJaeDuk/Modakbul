package modakbul.mvc.groupby;

import java.time.LocalDateTime;

public interface SelectReplyState {
	Integer getIngNo();
	String getGatherName();
	String getInqSubject();
	LocalDateTime getInqRegisDate();
	Integer getState();
}
