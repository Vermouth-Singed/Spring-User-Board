package first.sample.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import first.common.dao.AbstractDAO;
import first.sample.vo.UserVO;

@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO{
	@SuppressWarnings("unchecked")
	public List<UserVO> getUserList(HashMap<String, Object> params) {
		return selectList("sample.getUserList", params);
	}

	public int getUserTotalSize(HashMap<String, Object> params) {
		return (Integer)selectOne("sample.getUserTotalSize", params);
	}

	public void deleteUserList(HashMap<String, Object> params) {
		delete("sample.deleteUserList",params);
	}

	public void updateUser(HashMap<String, Object> params) {
		update("sample.updateUser",params);
	}

	public void insertUser(HashMap<String, Object> params) {
		insert("sample.insertUser",params);
	}
}