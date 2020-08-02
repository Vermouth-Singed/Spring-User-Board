# 프로젝트 세팅
## - 프로젝트 생성
1. Project Update
2. jdk 1.7 & Tomcat 7.0
3. Edit Web Module Path '/'
4. Server Start
5. Success Image
![시작](https://user-images.githubusercontent.com/24692694/88566472-04490e80-d071-11ea-8993-d2ccd162131f.png)

## - 메이븐
1. Repository 오류 시 다운로드

## - 데이터베이스 (MySQL)
1. context-datasource.xml 파일 수정
2. Time Server Zone 은 Asia/Seoul
3. table 생성 쿼리 및 data insert 문 첨부

# 화면 설명
## - 로그인
![로그인](https://user-images.githubusercontent.com/24692694/88567600-af0dfc80-d072-11ea-9465-8d3b82ecdf78.png)
1. 우측 상단에 로그인 버튼 클릭시 로그인창 생성
2. 로그인 안한 상태에서는 데이터만 조회 가능 (삽입, 수정, 삭제 불가능)
3. 로그인 시 엔터를 누르거나 '로그인 엔터' 버튼 클릭
4. 아이디와 비밀번호는 동일 (ex: user01/user01)

## - 페이징
![페이징](https://user-images.githubusercontent.com/24692694/88568250-a36f0580-d073-11ea-90db-114a1f29b5e4.png)
1. 10개씩 데이터들을 10 페이지들 단위로 출력
2. 페이지 클릭 시 조회
3. 처음과 마지막은 화살표 숨김
4. 선택된 페이지와 아닌 페이지들은 버튼 색으로 비교

## - 삽입
![삽입](https://user-images.githubusercontent.com/24692694/88568888-97377800-d074-11ea-913f-25575ca69d23.png)
1. 우측 하단에 '삽입 창' 버튼 클릭 시 테이블 맨 밑줄에 생성
2. 우측 하단에 '삽입' 버튼 클릭하거나 엔터 누르면 실행
3. 우측 하단에 '삽입 취소' 버튼 클릭 시 화면 닫힘

## - 수정
![수정](https://user-images.githubusercontent.com/24692694/88569727-d3b7a380-d075-11ea-943f-09531201a896.png)
1. 수정하고 싶은 줄 더블 클릭 시 수정창 생성
2. '수정' 버튼 클릭하거나 엔터 누르면 실행
3. v-show 와 v-if 로 구별

## - 삭제
![삭제](https://user-images.githubusercontent.com/24692694/88569452-6ad02b80-d075-11ea-940b-fa28fbd4af90.png)
1. 체크박스 선택 후 우측 하단의 '삭제' 버튼 클릭 시 삭제 가능