<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Welcome to My World</title>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<link rel="stylesheet" href="css/main.css"/>
		<link rel="shortcut icon" href="./favicon.ico">
		<style>
			@media screen and (min-width:501px){
				.mobile-br,.mobile-show{display:none;}				
			}

			@media screen and (max-width:500px){
				.table-wrapper th:nth-child(2),
				.table-wrapper th:nth-child(3),
				.table-wrapper td:nth-child(2),
				.table-wrapper td:nth-child(3){
					display : none;
				}

				.mobile-bt,.mobile-noshow{display:none;}
			}
			
			#divPop{
				position:absolute;
				background:linear-gradient(-45deg, #020024, #00d4ff);
				width:216px;
				top:34px;
				right:30px;
				border:1px solid darkgray;
			}
			
			[v-cloak]{display:none;}
		</style>
	</head>
	<body>
		<div id="app">
			<section id="main" v-cloak>
				<div class="inner">
					<section id="one" class="wrapper style1">
						<header class="special">
							<h2>유저 게시판
								<span style="position:absolute;right:-20px;">
									<a class="button small special" @click="popupView = true;" v-show="!popupView&&loginUserId === ''">로그인</a>
									<a class="button small special" @click="fnLoginUser()" v-show="popupView&&loginUserId === ''">로그인 엔터</a>
									<a class="button small special" @click="fnLogoutUser()" v-show="loginUserId !== ''">로그아웃</a>
								</span>
							</h2>
						</header>
						<div class="content">
							<div class="table-wrapper">
								<table>
									<thead>
										<tr>
											<th v-show="loginUserId !== ''"></th>
											<th>순번</th>
											<th>아이디</th>
											<th>이름</th>
											<th>업데이트 날짜</th>
											<th></th>
										</tr>
									</thead>
									<tbody v-show="userList.length > 0">
										<tr v-for="item in userList" @dblclick="fnChangeUpdateView(item)">
											<td v-show="loginUserId !== ''">
												<div class="6u 12u$(small)">
													<input type="checkbox" :id="item.rank" v-model="item.delete_checked">
													<label :for="item.rank"></label>
												</div>
											</td>
											<td>{{item.rank}}</td>											
											<td>{{item.user_id}}</td>
											
											<td>{{item.user_name}}</td>
											<td>{{item.update_date}}</td>
											
											<td>
												<input type="text" :value="item.user_name" ref="item_user_name"
													@keyup.enter="fnUpdateUser(item)" v-if="loginUserId !== ''&&item.update_checked"/>
												<input type="password" v-model="item.user_password" placeholder="비밀번호" 
													@keyup.enter="fnUpdateUser(item)" v-if="loginUserId !== ''&&item.update_checked"/>
												<input type="password" v-model="item.user_password_re" placeholder="비밀번호 확인" 
													@keyup.enter="fnUpdateUser(item)" v-if="loginUserId !== ''&&item.update_checked"/>
												<a class="button small special" @click="fnUpdateUser(item)" v-show="loginUserId !== ''&&item.update_checked">수정</a>
											</td>
										</tr>
										<tr v-show="insertView">
											<td colspan="2">
												<input type="text" v-model="userVO.user_id" @keyup.enter="fnInsertUser()" placeholder="아이디"/>
											</td>
											<td>
												<input type="password" v-model="userVO.user_password" @keyup.enter="fnInsertUser()" placeholder="비밀번호"/>
											</td>
											<td>
												<input type="password" v-model="userVO.user_password_re" @keyup.enter="fnInsertUser()" placeholder="비밀번호 확인"/>
											</td>
											<td>
												<input type="text" v-model="userVO.user_name" @keyup.enter="fnInsertUser()" placeholder="이름"/>
											</td>
										</tr>
									</tbody>
									<tfoot v-show="userList.length === 0">
										<tr style="text-align:center;">
											<td colspan="5">데이터가 없습니다.</td>
										</tr>
									</tfoot>
								</table>
								<div style="text-align:center;">
									<a class="button small alt special" v-show="userPaging.blockNo > 1" @click="userPaging.blockNo--">◀</a>
									<a class="button small alt" v-for="index in userPaging.totalBlockSize" 
										v-show="userPaging.blockNo*userPaging.blockSize >= index&&(userPaging.blockNo-1)*userPaging.blockSize+1<=index"
										:class="{special : index === userPaging.pageNo}" @click="fnChangePage(index)">{{index}}</a>
									<a class="button small alt special" v-show="userPaging.blockNo*userPaging.blockSize<userPaging.totalBlockSize" @click="userPaging.blockNo++">▶</a>
								</div>
								<div style="text-align:right;">
									<a class="button small special" @click="insertView = true;" v-show="loginUserId !== ''&&!insertView">삽입 창</a>
									<a class="button small special" @click="fnInsertUser()" v-show="loginUserId !== ''&&insertView">삽입</a>
									<a class="button small special" @click="insertView = false;" v-show="loginUserId !== ''&&insertView">삽입 취소</a>
									<a class="button small special" @click="fnDeleteUserList()" v-show="loginUserId !== ''">삭제</a>
								</div>
							</div>
						</div>
					</section>
				</div>
			</section>
			<div id="divPop" class="6u 12u$(small)" v-show="popupView">
				<h2><a class="pull-right" @click="popupView = false;">
				<img src="images/close.png" style="cursor:pointer;">&nbsp;&nbsp;</a></h2>
				<br/>
				<div>
					<input style="width:100%;" placeholder="아이디"  
						v-model="userVO.user_id"
						@keyup.enter="fnLoginUser()"><br/>
					<input style="width:100%;" placeholder="비밀번호" 
						v-model="userVO.user_password"
						@keyup.enter="fnLoginUser()">
				</div>
			</div>
		</div>
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.poptrox.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/util.js"></script>
		<script src="js/main.js"></script>		
		<script src="js/assignment-controller.min.js"></script>
	</body>
</html>