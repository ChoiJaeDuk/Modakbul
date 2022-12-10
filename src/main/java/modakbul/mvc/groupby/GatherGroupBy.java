package modakbul.mvc.groupby;

import java.time.LocalDateTime;

public interface GatherGroupBy {
	Integer getGatherCount();
	String getGatherMonth();
	
	Long getGatherNo();
	String getGatherImg();
	String getGatherName();
	LocalDateTime getGatherDeadline();
	Integer getGatherMaxUsers();
	Integer getPCount();
	Integer getLikeCount();
}
