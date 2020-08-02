package first.sample.vo;

public class UserVO {
	private int rank;
	private boolean delete_checked;
	private boolean update_checked;
	private String user_id;
	private String user_password = "";
	private String user_password_re = "";
	private String user_name;
	private String update_date;
	private String register_date;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public boolean isDelete_checked() {
		return delete_checked;
	}
	public void setDelete_checked(boolean delete_checked) {
		this.delete_checked = delete_checked;
	}
	public boolean isUpdate_checked() {
		return update_checked;
	}
	public void setUpdate_checked(boolean update_checked) {
		this.update_checked = update_checked;
	}
	public String getUser_password_re() {
		return user_password_re;
	}
	public void setUser_password_re(String user_password_re) {
		this.user_password_re = user_password_re;
	}
}