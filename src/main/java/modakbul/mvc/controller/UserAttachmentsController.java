package modakbul.mvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.service.UserAttachmentsService;

@Controller
@RequiredArgsConstructor
public class UserAttachmentsController {
	private final UserAttachmentsService service;
	
	@ResponseBody
	@RequestMapping("deleteAttach")
	public List<UserAttachments> delete(Long userAttachmentsFileNo) {
		System.out.println("no = " + userAttachmentsFileNo);
		return service.delete(userAttachmentsFileNo);
	}
}
