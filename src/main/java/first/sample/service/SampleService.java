package first.sample.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import first.sample.vo.UserVO;

public interface SampleService {
	List<UserVO> getUserList(int pageNo, int rowSize);
	int getUserTotalSize();
	void deleteUserList(String userList);
	String loginUser(String userId, String userPassword, HttpSession session);
	String logoutUser(HttpSession session);
	void updateUser(String userId, String userPassword, String userName);
	String insertUser(String userId, String userPassword, String userName);
}