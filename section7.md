# 53. Pheonix 설치

`mix archive.install hex phx_new`

# 54. PostgreSQL 설치

`brew install postgresql`

`brew services start postgresql`

`postgres -V`

`initdb /usr/local/var/postgres` (피닉스의 기본 DB 위치)

`psql`

# 55. Pheonix 란?

- Database <-> Phoenix <-> HTML / JSON / Web Sockets
- DB는 애플리케이션과 관련된 모든 데이터를 저장하는 역할을 한다. ex) PostgreSQL, MySQL, SQLite
- 웹소켓은 일반적으로 싱글 페이지 앱과의 실시간 통신에 사용된다.

- 사용자 요청을 처리하는 방법을 알면 피닉스를 정말 잘 알 수 있다~!
  - ex) input -> pipelines -> output
  - Incoming Request -> Ensure its an HTML request -> See if it has a session -> Do a security check -> Put on HTML headers for a browser -> See what the request was trying to access -> Formulate and return a request

# 56

- `mix phx.new discuss`
  - 피닉스 프로젝트를 새로 생성한다
- discuss 앱 기능
  - Github(OAuth) 로그인
  - 토론할 주제 게시
    - 토론할 주제 편집
    - 토론할 주제 삭제
  - 특정 토론 주제에 댓글 게시

# 57

- `mix ecto.create`
  - 지정된 리포지토리에 대한 스토리지를 생성한다
- `mix phx.server`
  - 피닉스 서버를 실행한다

# 58

- 서버사이드 템플릿
  - HTML을 생성해서 클라이언트에게 보낸다.
  - 서버사이드 템플릿 동작과정 ex) Node.js EJS
    - User visit page -> HTTP request to server -> New HTML Document -> User clicks a link -> HTTP request to server -> New HTML Document
  - 싱글페이지 앱 동작과정 ex) React
    - User visit page -> HTTP request to server -> New HTML Document -> React/Angular boots up, shows page -> User clicks link -> React/Angular shows new content
  - 피닉스는 서버사이드 템플릿, 싱글페이지 앱 모두 잘 지원한다.

# 59

`discuss/lib/discuss_web/components/layouts`

1. templates
2. layouts

- 최신 버전 피닉스에서는 헤더 / 바디 / 푸터 세 부분으로 구성됨
