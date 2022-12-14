# news_app

news flutter app clone

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

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
