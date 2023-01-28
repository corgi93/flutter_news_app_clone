# news_app

news flutter app clone


------
# step2

## 디렉토리 구조
```
lib
├── src
│   ├── injector.dart  : get_it 패키지를 사용해 DI(의존성 주입) 하는 역할
│   ├── config  : 앱에 대한 config정보들 (themes, routes, etc)
│   ├── core    :core 는 핵심 폴더로 앱 전반에서 필요한 핵심 기능, 계층에 필요한 작업을 포함(recoures파일, utils, etc..)
│   └── data 
│   │    ├── datasource
│   │    │        ├── local
│   │    │        └── remote
│   │    ├── models
│   │    └── repositories 
│   │
│   └── domain    :  추상클래스, 엔티티, 유스케이스.. presentation계층에서 Entity로 데이터 포맷을 주고 받음 
│   │    ├── entities
│   │    ├── repositories
│   │    └── usecases  
│   └── presentation   : 표현 계층. BloC패턴에서 wigets
│        ├── blocs
│        ├── views
│        └── widgets  
└── main.dart
``` 

## 아키텍쳐
```
<Presentation계층 - ui와 state , event제어>
    BloC  -> (states) -> UI [hooks, widgets , animations...]
    BloC  <- (Events) <- UI
        |
        |  Entity
        | 
        V
    <Domain계층> abstracted classes, entities, use cases ...
        |
        |  Model
        |
        V
    <Data 계층>  
        |
      /  \  Raw Data to Models
     /    \
Remove      Local
data        Data
source      Source 
(REST API)  (Sqlite, Hive...)

```

### data 계층 
맨 아래 레이어인 Data계층은 REST API, GraphQL 같은 http통신으로 받은 data , sqlite같은 local DB의 raw data를 <br>
  직접 처리하는 것. 그 다음 raw data(Json, Xml ..등)을 매핑하거나 직렬화하는 방법으로 Model(dart객체)로 변환해 매핑합니다. 
  
data계층의 models은 Domain계층의 entities와 다릅니다. 
이런 계층으로 나누는 이유는 raw data 직렬화를  Json에서 xml로 변견하려는 경우 이런 변경사항이 내부 entity (domain계층의 entity)에
영향을 끼치지 않기 때문.
Data계층의 Model은 Domain계층의 entities에서 property(속성)들을 확장하고 Model이 entities에서 모든 속성을 확장하므로 
항상 Domain계층에 종속됨.

<br>
domain계층에서 인터페이스(추상화된 클래스)를 정의.
data계층에서 repository를 포함하는 domain계층의 추상화 클래스의 실제 구현.
domain계층과 상호작용하지 않고 관심사를 분리해 여러 구현을 변경, 추가할 수 있어서 의존성을 낮출 수 있습니다.

### presentation 계층
이 계층은 2가지 중요한 부분이 있습니다. Bloc(ViewModel 포함)과 UI (widgets, state, animation..)

 * Bloc
 Bloc에서는 외부(remote또는 local)로부터 데이터를 필요로 하는 모든 상호작용을 이 bloc이 처리함 (redux같은..)
   bloc의 패턴은 단일 클래스를 갖는 대신 이러한 상호 작용을 Event로 분리하고 event를 처리하고 state의 결과를 UI로 리턴
   UI쪽에선 state의 상태를 (stream of states) 받아 action하고 위젯을 빌드해서 업데이트
   
bloc을 써서 event, state, bloc으로  role을 나누고 더 클린한 코드 베이스를 가져감.
presentation계층도 domain계층에 의존 - bloc이 주입(injected)된 domain종속성(ex. usecase)를 사용해서 작업 처리해서.


### domain 계층
- domain계층은 내의 entities만 포함하고, 우리 domain의 entities가 domain 계층 외부에서 발생할 변경 사항과
완전히 독립적임.
  
- persentation 계층과 data계층모두 domain계층에 의존함. (필수적인 의존성)
- data계층의 domain계층에서 작성된 계약(추상클래스)를 실제 구현 / presentation계층은 주입된 종속성으로 사용할 때 이런 계약들을 사용.

- presentation계층은 model이 아닌 entity로만 데이터를 얻어 각 계층을 독립적으로 분리해야함.
- 대형 프로젝트는 각 계층에 매핑 객체를 사용해 각 계층별로 상호작용하고 서로 종속되지 않도록 하는게 좋음 (해당 프로젝트는 작아서 그렇게까지은 안함!)

* usecase
usecase는 어떻게 사용되냐면 repository에 의존하는 개별 클래스로, 하나의 정확한 작업(기사 가져오기, data 게시, 로그인 등)만을 수행.
  usecase에 주입된 여러 repository를 취할 수 있고 bloc(viewmodel)은 그것에 주입된 여러 usecase를 사용할 수 있음.

-----

# step2
News Api [News Api](https://newsapi.org/docs/get-started)를 이용해서 API를 처리하는 방법을 정리

### 매개변수
우선 GET으로만 가져오도록 구현
- core/params/article_request.dart 생성
REST API에서 항목을 가져오기 위해서 매개변수를 메서드에 전달할 때 이 클래스를 전달함.
  (일종의 reqParam Dto를 하나 생성한 것)
  
### 자원 (core)
core 내부에 resources를 만들고 resources 내부에 data_state.dart라는 wrapper클래스 생성
API 통신 후 서버의 응답을 받고 문제가 생길 경우 네트워크 오류 발생..
여기서 전체 네트워크 응답을 Dio라이브러리를 써서 DioError 유형의 오류로 DataState로 래핑하는 래퍼 클래스를 생성해 받는다! (성공 or 실패 2가지 상태로 가질 수 있음)

## 사용사례?(usecase)
core/usecases/usecase.dart 생성
UseCase는 .. 호출 가능한 클래스가 뭔지 고민해볼 필요가 있음..
호출 가능한 클래스는 call()이라는 메서드의 구현을 포함하는 클래스며
이 call()메서드는 호출 메서드 대신 인스턴스 호출을 가능하게 만드는 역할을 함!

- 추상클래스인 UseCase를 만들어 상속받아 UseCase 클래스를 구현한다. 
ex)
```
abstract class UseCase<T, P>{
 Future<T> call({ P params });
}

class DataUseCase implements UseCase<String, int>{
  @override
  Future<String> call({int params}){
    return 'data is $params';
  }
}

final dataUseCase = DataUseCase();
final data = dataUseCase(10); // we directly call the 'call' by the instance
```

## 도메인 계층 (domin)
### 엔터티 (entities)
domain/entities 폴더를 열고 source.dart,article.dart라는 entity(객체 클래스)를 생성


ex) domain/entities/article.dart

```
import 'package:equatable/equatable.dart';
import 'package:news_app/src/domain/entities/source.dart';

class Article extends Equatable {
  final int id;
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  // nullable이 아니면 required로 넣어줘야 함.
  const Article({
    required this.id,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object> get props {
    return [
      id,
      source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }

  @override
  bool get stringify => true;
}
```

ex) domain/entities/source.dart
```
import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String id;
  final String name;

  const Source({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;
}\
```

### 저장소(repository)
domain/repository/item_repository.dart 생성

domain 계층에선 추상화만(계약) 포함되고 실제 구현은 data 계층에서 작성함.
여기서는 Future유형의 메서드 하나만 포함하고 response 상태를 알기 위해 DataState로 
래핑된 List<Article> 유형의 데이터를 반환하는 추상화된 클래스를 정의함.

### 사용사례(usecases)
domain/usecases/get_articles_usecase.dart 생성하기 

{ DataState<List<Article>>을 return타입으로 사용. ArticlesRequestParams를 재정의된 call메서드에 대한 매개변수 여기서
GetArticlesUseCase는 ArticlesRepository클래스에 의존하지만 이 UseCase클래스 내부에서 인스턴스화 하지않음! get_it을 사용해 추후 종속성
주입할 것! (Dependency Injection)
지금까지 작성한건 entity와 추상화이고 실제 구현은 data계층에서 이루어짐 data계층 내부에서 모든 변경사항이 발생하고 domain계층에 영향이 x}


## 데이터 계층(data)
### model
article_model.dart를 생성.
model클래스는 멋진 건 없다 ㅎㅎ. entity에서 만든 source.dart같은 entity를 확장하는 model을 만듦.
이런 model클래스는 (fromJson, toJson)을 포함해 직렬화를 담당하는 클래스! 

이를 통해 향후 변경될 수 있는(ex. json -> xml로 직렬화 하라는?) 변경 사항에 대해
domain의 entity에 영향을 미치지 않고 여기 model에서만 변경할 수 있다.

 [model클래스 작성시 사용되는 factory 예약어(싱글톤)](https://roseline.oopy.io/dev/flutter-tips/what-is-factory)


### datasources/remote
지금까지 구조를 디자인하고 article, news 데이터를 받는 로직은 작성하지 않음.
데이터를 제공하는 서비스를 어디서 요청? dio라는 http 클라이언트 라이브러리를 이용.
news_api_service.dart를 생성.
 
build_runner패키지를 추가 했는데 flutter pub을 해줘야 사용 가능.
```
> flutter pub run build_runner build
```

-- dart의 part / part of로 클래스를 분할해서 클래스 작성 가능.
여기서는 g.dart로 추상클래스를 상속받고 override받아 API Service클래스를 작성했다.
retrofit 내부에서 사용하는 dio를 사용.

BreakingNewsResponseModel을 반환 타입으로 하는데 
HttpResponse이지 상태, 메세지, 요청 등을 필요로하는 전체 http 응답이 필요해 단순 BreakingNewsResponseModel을 return하는게 아니라
HttpResponse (retrofit)클래스에 value로 return함.

### data/repository
이제 진짜 추상화를 구현해보자(멀고 먼 여정이었다ㅎㅎ)
items_repository_impl.dart를 생성.
NewsApiService를 의존하는 클래스로 이 impl클래스 내에서 인스턴스화 하지 않습니다.
(추후 DI 적용할 예정)

이전에 core/resources/data_state.dart에서 작성한 DataState클래스가 여기서 사용됨.
네트워크 요청을 만들고 있으면 잘 진행되면 데이터( List<Article> )와 함께 DataSuccess를 반환하고 
그렇지 않으면 DioError 와 함께 DataFailed를 반환함. 변경 사항이 발생하더라도 프레젠테이션 계층 (Bloc/UI) 에 영향을 미치지 않음.


## 표현 계층 (presentation)
### blocs
각 bloc은 하나 문제(작업)만 해결하도록 해야함!
원격 data를 가져 UI에 있는 결과를 표시해야함

presentation/blocs/remote_articles
remote_artices 폴더 생성(하나의 블록) 후 bloc,state,event를 만들어 준다.


## 의존성 주입 (Dependency Injection)
repository같은 entity및 추상화된 클래스를 포함하는 도메인에서 작업을 마치고 추상화를 구현했다.
그리고 presentation으로 이동해 결과를 표시하는 보기를 만듦.
이제 종속성 주입을 해줘야하는데 get_it패키지를 이용해 GetIt인스턴스로 전역으로 정의한 인젝터를 작성할 것.

Injector는 종속성을 유지하고 정확한 유형을 정확한 위체에 주입할 책임이 있음
```
싱글톤 패턴 : 인스턴스를 등록 후 가져올 때마다 동일한 인스턴스 가져옴
팩토리 패턴 : 얻을 때마다 다른 인스턴스를 얻고 싶을 떄 
```

ApiNewsService가 Dio 인스턴스에 의존하고 있으므로 Dio인스턴스를 싱글톤으로 등록.


-----
# step3 - local data
floor라는 패키지를 이용해 database를 이용하는 법. floor 패키지 내부적으로
[sqflite](https://pub.dev/packages/sqflite) (sqlite 플러그인)를 추상화해서 사용하고 있음

## DAO
Dao(Data Access Objects)는 해당 sqlite 데이터베이스에 대한 액세스 관리를 담당하는 구성 요소이고 항상 추상화된 클래스로 정의되 있어야 함.
데이터베이스 자체는 동시에 여러 DAO를 포함할 수 있으며 각 Dao에는 메서드명 및 쿼리 문이 포함되어 있음.

@dao 애노테이션을 달아 build_runner 와 패키지가 이 클래스가 Dao임을 알 수 있도록 한다.
그리고 article_dao.dart에서 엔티티 구분은 domain/entities/article.dart에서 @Entity로 애노테이션을 달아줌.
이렇게 달아줌으로써 이 Entity가 Database의 엔티티임을 나타내준다.

id값에 @PrimaryKey로 autoGenerate값을 true로 설정해주면 테이블에 엔티티를 추가할 때마다 기본키를 자동 생성한다는 뜻.

## converter
article에는 우리가 정의한 Source타입을 사용하는데 floor는 타입변환기를 제공하므로 Source클래스를 floor가 데이터베이스에 저장하도록 변환할 수 있음.
data/datasources/local/converter에 source_type_converter.dart생성

## app_database
* FloorDatabase에서 확장되는 추상화된 클래스를 정의하고 그 안에 DAO가 있고
* 해당 Dao를 구현해야한다고 DB에 알림.
* dart:async를 import하고, sqflite가 floor에 추상화되어 있지만 import해줘야 build_runner로 build시 에러 x.

```
 // news_api_service에서 news_api_service.g.dart를  part로 지정해주고 build_runner로 아래 명령어로 
 // 실행해줬던 것처럼 작성.
 > flutter pub run build_runner build --delete-conflicting-outputs
```
