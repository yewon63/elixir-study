# MVC

- 요리 프로세스
  - 식재료, 도구, 사람이 필요하다.
  - 식재료 -> Model
  - 도구 -> View
  - 사람 -> Controller
- MVC
  - Model, View, Controller가 필요하다.
  - Model: The raw data of the topic
    - 데이터다
  - View: A template that takes the model and makes it look nice
    - 유저가 보는 부분이다
  - Controller: Figures out what the user is looking for, grabs the correct model, stuffs it into the view, returns the result to the user
    - 모델과 뷰를 사용해서 유저에게 결과를 반환한다
- MVC(Model-View-Controller) 아키텍처는 객체지향 프로그래밍(OOP, Object-oriented Programming)에 국한되지 않는다. 함수형 프로그래밍(Functional Programming)에 국한되지도 않는다.

# Phoenix 프로젝트 구조

- controllers, models, views 폴더
- 이미 변경사항이 생기는 순간 즉시 웹브라우저에 반영되는 HTML 파일이 있는데 왜 이런 폴더가 따로 있는건가?

# Pheonix 요청 ~ 응답
- Request -> Router -> (Database -> Model ->) Controller -> (Template ->) View -> Response
- Router
  - `router.ex`
  - `scope` 키워드
    - 라우팅 규칙 정의
  - `get` 키워드
    - 특정 컨트롤러의 특정 함수 실행
- Controller
  - `page_controller.ex`
  - PageController 이름은 index.html 파일만큼 일반적인 이름이라 별 의미가 없다

# Templates vs Views

- Templates
  - `*.html.heex`
- Views
  - 강의 속 `page_view.ex` 파일과 `discuss/lib/discuss_web/controllers/page_html.ex` 파일이 상당히 유사하다
  - Views는 Templates을 임베드한다
- Pheonix 동작 순서
  - Views(Page View) -> Templates Folder -> 해당 폴더 안에 있는 모든 파일을 가져와서 함수로 추가한다(`embed_templates "page_html/*"`)
    - ex) `page_html/home.html.heex` 템플릿 -> `page_controllers.ex`에서 쓰인 `home` 함수가 됨
- Pheonix 명명규칙
  - 비슷한 기능에 관련된 View, Controller라면 비슷한 이름을 가져야 한다
- `iex -S mix phx.server`

```elixir
# 강의 내용
iex(2)> Discuss.PageView.render("index.html")
** (UndefinedFunctionError) function Discuss.PageView.render/1 is undefined (module Discuss.PageView is not available)
    Discuss.PageView.render("index.html")
    iex:2: (file)
```

```elixir
# 로컬 환경에 맞게 변경한 내용
iex(2)> DiscussWeb.PageHTML
DiscussWeb.PageHTML
```

```elixir
# 로컬 환경에 맞게 변경한 내용
DiscussWeb.PageHTML.module_info
[
  module: DiscussWeb.PageHTML,
  exports: [
    __info__: 1,
    __components__: 0,
    __mix_recompile__?: 0,
    __phoenix_component_verify__: 1,
    __phoenix_verify_routes__: 1,
    abc: 1,
    home: 1,
    module_info: 0,
    module_info: 1
  ],
  attributes: [
    vsn: [167914055400556048810136355344291872845],
    external_resource: ["/Users/yewonkim/IdeaProjects/elixir-cards/discuss/lib/discuss_web/controllers/page_html/abc.html.heex"],
    external_resource: ["/Users/yewonkim/IdeaProjects/elixir-cards/discuss/lib/discuss_web/controllers/page_html/home.html.heex"]
  ],
  compile: [
    version: '8.2.3',
    options: [:no_spawn_compiler_process, :from_core,
     :no_core_prepare, :no_auto_import],
    source: '/Users/yewonkim/IdeaProjects/elixir-cards/discuss/lib/discuss_web/controllers/page_html.ex'
  ],
  md5: <<126, 83, 18, 27, 225, 190, 250, 43, 215, 111,
    117, 187, 224, 38, 64, 77>>
]
```

```elixir
# 로컬 환경에 맞게 변경한 내용
iex(2)> DiscussWeb.PageHTML.home("asdf")
%Phoenix.LiveView.Rendered{
  static: ["",
   "\n<div class=\"left-[40rem] fixed inset-y-0 right-0 z-0 hidden lg:block xl:left-[50rem]\">\n\n</div>"],
  dynamic: #Function<1.66230416/1 in DiscussWeb.PageHTML.home/1>,
  fingerprint: 317115749541989002582508278061879938510,
  root: false,
  caller: :not_available
}
```

```elixir
# 로컬 환경에 맞게 변경한 내용 (2)
iex(3)> DiscussWeb.Layouts.module_info  
[
  module: DiscussWeb.Layouts,
  exports: [
    __info__: 1,
    __components__: 0,
    __mix_recompile__?: 0,
    __phoenix_component_verify__: 1,
    __phoenix_verify_routes__: 1,
    app: 1,
    root: 1,
    module_info: 0,
    module_info: 1
  ],
  attributes: [
    vsn: [309315634274482586899314730865891837649],
    external_resource: ["/Users/yewonkim/IdeaProjects/elixir-cards/discuss/lib/discuss_web/components/layouts/app.html.heex"],
    external_resource: ["/Users/yewonkim/IdeaProjects/elixir-cards/discuss/lib/discuss_web/components/layouts/root.html.heex"]
  ],
  compile: [
    version: '8.2.3',
    options: [:no_spawn_compiler_process, :from_core,
     :no_core_prepare, :no_auto_import],
    source: '/Users/yewonkim/IdeaProjects/elixir-cards/discuss/lib/discuss_web/components/layouts.ex'
  ],
  md5: <<232, 180, 6, 52, 11, 98, 201, 202, 6, 117, 216,
    60, 117, 193, 134, 209>>
]
```

```elixir
# 로컬 환경에 맞게 변경한 내용 (2)
iex(5)> DiscussWeb.Layouts.root("asdf")
%Phoenix.LiveView.Rendered{
  static: ["<!DOCTYPE html>\n<html lang=\"en\" style=\"scrollbar-gutter: stable;\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <meta name=\"csrf-token\"",
   ">\n    ",
   "\n\n    <link phx-track-static rel=\"stylesheet\"",
   ">\n    <script defer phx-track-static type=\"text/javascript\"",
   ">\n    </script>\n\n    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD\" crossorigin=\"anonymous\">\n  </head>\n  <body class=\"bg-white antialiased\">\n    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN\" crossorigin=\"anonymous\"></script>\n\n    <nav class=\"navbar bg-primary\">\n      <div class=\"container-fluid\">\n        <a href=\"/\" class=\"brand-logo\">\n          <h1>\n            Discussions\n          </h1>\n        </a>\n      </div>\n    </nav>\n",
   "\n  </body>\n</html>"],
  dynamic: #Function<1.122003505/1 in DiscussWeb.Layouts.root/1>,
  fingerprint: 159488481804839360016857451774329155170,
  root: false,
  caller: :not_available
}
```

# Model Layer

- Pheonix 입장에서 DB는 블랙박스다
  - DB 안에 어떤 테이블이 있고 이런 걸 알 수가 없다
  - 그래서 모델 계층이 있다
  - 모델 파일에서 정의한 것에 따라 Pheonix는 DB에 어떤 테이블이 있는지 알 수 있다
- DB 마이그레이션
  - PostgreSQL 테이블이 추적하게 만든다
  - 마이그레이션 파일에서 정의한 것에 따라 데이터베이스에 내가 원하는 구조가 무엇인지 구체적으로 알려줄 수 있다

# Migration Files

- `mix ecto.gen.migration add_topics`
- 마이그레이션 파일을 여러개 생성할 수 있기 때문에 파일명 맨 앞에 타임스탬프가 붙는다
  - 타임스탬프에 따라 마이그레이션 파일이 순차적으로 실행된다
- `mix ecto.migrate`

# PostgreSQL Client

- Postico

# Controller Function Naming Convention

- Controller 함수명은 관례를 따르지 않는다고 오류가 나진 않지만, 관례를 따르면 문제생길 부분이 줄어든다

# Pheonix Error Page

- 스택 트레이스를 제공한다

# Controller 동작방식

- ControllerBaseClass를 다른 컨트롤러 클래스가 상속한다
- ControllerBaseClass
  - `init`
  - `handle_request`
- Topic
  - `new`

# 코드를 재사용하기 위한 Pheonix 키워드

- `import`
  - 모듈을 불러온다
  - 키워드를 쓴 해당 모듈을 통해 함수를 호출할 수 있다
- `alias`
  - 모듈을 불러와서 해당 모듈 내부에 있는 함수를 호출할때 모듈명을 안써도 되게 해준다
  - 키워드를 쓴 해당 모듈을 통해 함수를 호출할 수 없다 (해당 모듈 내에서만 호출할 수 있다)
- `use`
  - 셋업을 위해 사용한다

# 코드 공유 in Pheonix

- `discuss_web.ex`
