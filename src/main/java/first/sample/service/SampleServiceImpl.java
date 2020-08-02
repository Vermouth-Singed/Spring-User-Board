package first.sample.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import first.sample.dao.SampleDAO;
import first.sample.vo.UserVO;

@Service("sampleService")
public class SampleServiceImpl implements SampleService{
	@Resource(name="sampleDAO")
	private SampleDAO sampleDAO;

	@Override
	public List<UserVO> getUserList(int pageNo, int rowSize) {
		HashMap<String, Object> params = new HashMap<>();
		addPageIndex(params, pageNo, rowSize);
		return sampleDAO.getUserList(params);
	}

	@Override
	public int getUserTotalSize() {
		HashMap<String, Object> params = new HashMap<>();
		return sampleDAO.getUserTotalSize(params);
	}
	
	@Override
	public void deleteUserList(String userList) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_list", userList.split(","));
		sampleDAO.deleteUserList(params);
	}
	
	@Override
	public String loginUser(String userId, String userPassword, HttpSession session) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id", userId);
		params.put("user_password", userPassword);
		params.put("first", 1);
		params.put("last", 1);
		
		List<UserVO> list =  sampleDAO.getUserList(params);
		
		if(list.size() > 0) {
			session.setAttribute("user_id", list.get(0).getUser_name());
			session.setAttribute("user_name", list.get(0).getUser_name());
			return "success/"+list.get(0).getUser_id();
		}
		
		return "fail";
	}
	
	private HashMap<String, Object> addPageIndex(HashMap<String, Object> param, int pageNo, int rowSize){
		param.put("first", (pageNo-1)*rowSize+1);
		param.put("last", pageNo*rowSize);
		return param;
	}

	@Override
	public String logoutUser(HttpSession session) {
		session.invalidate();
		return "success";
	}

	@Override
	public void updateUser(String userId, String userPassword, String userName) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id", userId);
		params.put("user_password", userPassword);
		params.put("user_name", userName);
		sampleDAO.updateUser(params);
	}

	@Override
	public String insertUser(String userId, String userPassword, String userName) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id", userId);
		params.put("first", 1);
		params.put("last", 1);
		
		if(sampleDAO.getUserList(params).size() > 0) {
			return "fail";
		}
		
		params.put("user_password", userPassword);
		params.put("user_name", userName);
		
		sampleDAO.insertUser(params);
		
		return "success";
	}
}