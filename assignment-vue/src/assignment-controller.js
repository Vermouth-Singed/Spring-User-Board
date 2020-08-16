import 'es6-promise';
import 'babel-polyfill';
import Vue from 'vue';
import Axios from 'axios';

new Vue({
  el: '#app',
  data: function () {
    return {
      userList: [],
      userPaging: {
        pageNo: 1,
        blockNo: 1,
        rowSize: 10,
        blockSize: 10,
        totalSize: 1,
        totalBlockSize: 1
      },
      popupView: false,
      loginUserId: "",
      userVO: {
        user_id: "",
        user_password: "",
        user_password_re: "",
        user_name: ""
      },
      insertView: false
    }
  },
  computed: {
    checkedUserList: function(){
      return this.userList.filter(item => item.delete_checked);
    }
  },
  mounted: function(){
    this.fnGetUserList();
  },
  methods: {
    fnGetUserList: function(){
      Axios.get(`user.do?pageNo=${this.userPaging.pageNo}&rowSize=${this.userPaging.rowSize}`).
      then(response => {
        this.loginUserId = response.data.userId != null ? response.data.userId : "";
        this.userList = response.data.userList;
        this.userPaging.totalSize = response.data.totalSize;
        this.userPaging.totalBlockSize = this.userPaging.totalSize % this.userPaging.rowSize === 0 ? 
                                          parseInt(this.userPaging.totalSize / this.userPaging.rowSize) : 
                                          parseInt(this.userPaging.totalSize / this.userPaging.rowSize + 1);
      }).catch(ex => console.log(ex));
    },
    fnChangePage: function(pageNo){
      this.userPaging.pageNo = pageNo;

      this.fnGetUserList();
    },
    fnDeleteUserList: function(){
      if(this.checkedUserList.length > 0){
        if(confirm("선택한 유저들을 삭제하시겠습니까?")){
          Axios.delete(`user.do?userId=${this.checkedUserList.map(item => item.user_id).toString()}`).
          then(() => {
            alert("삭제가 완료되었습니다.");

            this.fnChangePage(1);
          }).catch(ex => console.log(ex));
        }
      }else{
        alert("아무것도 선택하지 않았습니다.");
      }
    },
    fnLoginUser: function(){
      if(this.userVO.user_id === ""){
        alert("아이디를 입력하세요.");
        return;
      }

      if(this.userVO.user_password === ""){
        alert("비밀번호를 입력하세요.");
        return;
      }

      Axios.get("loginUser.do",{
        params: {
          userId:this.userVO.user_id,
          userPassword:this.userVO.user_password
        }
      }).
      then(response => {
        let status = response.data.status;

        if(status.startsWith("fail")){
          alert("아이디 및 비밀번호가 잘못되었습니다.");
        }else{
          alert("로그인 완료");
          
          this.loginUserId = status.substring(status.indexOf("/")+1);
          this.popupView = false;
          this.fnInit();
        }
      }).catch(ex => console.log(ex));
    },
    fnLogoutUser: function(){
      if(confirm("로그아웃하시겠습니까?")){
        Axios.get("logoutUser.do").
        then(() => {
          alert("로그아웃 완료");

          this.loginUserId = "";
          this.fnInit();
        }).catch(ex => console.log(ex));
      }
    },    
    fnChangeUpdateView: function(item){
      if(this.loginUserId !== ""){
        item.update_checked = !item.update_checked;
      }
    },
    fnUpdateUser: function(item){
      if(item.user_password !== item.user_password_re){
        alert("비밀번호가 다릅니다.");
        return;
      }else if(confirm("수정하시겠습니까?")){
        Axios.put("user.do",{
          userId: item.user_id,
          userPassword: item.user_password,
          userName: this.$refs.item_user_name[0].value
        }).
        then(() => {
          alert("수정이 완료되었습니다.");

          this.fnInit();
          this.fnChangePage(1);
        }).catch(ex => console.log(ex));
      }
    },
    fnInsertUser: function(){
      if(this.userVO.user_id === "" || this.userVO.user_password === "" || this.userVO.user_password_re === "" || this.userVO.user_name === ""){
        alert("입력안한 값이 있습니다.");
        return;
      }

      if(this.userVO.user_password !== this.userVO.user_password_re){
        alert("비밀번호가 다릅니다.");
        return;
      }

      Axios.post("user.do",{
        userId: this.userVO.user_id,
        userPassword: this.userVO.user_password,
        userName: this.userVO.user_name
      }).
      then(response => {
        if(response.data.status === "success"){
          alert("삽입이 완료되었습니다.");

          this.fnInit();
          this.fnChangePage(1);
        }else{
          alert("존재하는 아이디입니다.");
        }
      }).catch(ex => console.log(ex));
    },
    fnInit: function(){
      this.userVO.user_id = this.userVO.user_password = this.userVO.user_password_re = this.userVO.user_name = "";

      this.insertView = false;
    },
  }
});