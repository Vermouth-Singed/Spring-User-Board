package first.sample.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import first.sample.service.SampleService;
import first.sample.viewmodel.SampleViewmodel;

@Controller
public class SampleController {
	
	@Resource(name="sampleService")
	private SampleService sampleService;
	
	@RequestMapping(value="main.do", method=RequestMethod.GET)
	public String main(){
		return "/../../index";
	}
	
	@RequestMapping(value="user.do", method=RequestMethod.GET)
	public @ResponseBody SampleViewmodel getUserList(SampleViewmodel vm, HttpSession session){
		vm.setUserList(sampleService.getUserList(vm.getPageNo(), vm.getRowSize()));
		vm.setTotalSize(sampleService.getUserTotalSize());
		vm.setUserId((String)session.getAttribute("user_id"));
		return vm;
	}
	
	@RequestMapping(value="user.do", method=RequestMethod.PUT)
	public @ResponseBody SampleViewmodel updateUser(@RequestBody SampleViewmodel vm){
		sampleService.updateUser(vm.getUserId(),vm.getUserPassword(),vm.getUserName());
		return vm;
	}
	
	@RequestMapping(value="user.do", method=RequestMethod.POST)
	public @ResponseBody SampleViewmodel insertUser(@RequestBody SampleViewmodel vm){
		vm.setStatus(sampleService.insertUser(vm.getUserId(),vm.getUserPassword(),vm.getUserName()));
		return vm;
	}
	
	@RequestMapping(value="user.do", method=RequestMethod.DELETE)
	public @ResponseBody SampleViewmodel deleteUserList(SampleViewmodel vm){
		sampleService.deleteUserList(vm.getUserId());
		return vm;
	}
	
	@RequestMapping(value="loginUser.do", method=RequestMethod.POST)
	public @ResponseBody SampleViewmodel loginUser(@RequestBody SampleViewmodel vm, HttpSession session){
		vm.setStatus(sampleService.loginUser(vm.getUserId(),vm.getUserPassword(),session));
		return vm;
	}
	
	@RequestMapping(value="logoutUser.do", method=RequestMethod.POST)
	public @ResponseBody SampleViewmodel logoutUser(@RequestBody SampleViewmodel vm, HttpSession session){
		vm.setStatus(sampleService.logoutUser(session));
		return vm;
	}
}