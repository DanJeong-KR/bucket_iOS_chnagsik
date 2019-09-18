# bucket_iOS_chnagsik
* 기간 : 9월 16일 오후 3시 ~ 9월 18일 오후 3시 (3일)
* 목표 : 콘텐츠 리스트페이지 / 콘텐츠 상세페이지 만들기

# 설계단계

### 1. 디자인
* [마인드맵]("/images/design_mindmap.pdf")
<a href="/images/design_mindmap.pdf" target="_blank"><img src="/images/design_mindmap.png"></a>

### 2.체크할 것
* ~~Swift를 사용해 주세요.~~
* ~~Deployment: iOS 10.0 이상, Universal, Portrait/Landscape~~
* ~~UI 구현 관련 open source는 사용하지 않아야 합니다. 기타 open source library를 사용할 경우, 사용목적을 적어 주세요.~~
* ~~pod, carthage 등 Xcode로 build 전에 필요한 step이 있으면 적어주세요.~~

### 3.[Commit Message 규칙](https://changsic.github.io/CommitMessage/)

* `feat` : 새로운 기능 추가
* `fix` : 버그 수정
* `docs` : 문서 수정
* `style` : 파일 그룹화, 세미콜론 누락, 코드 변경이 없는 경우
* `refactor` : 코드 리펙토링
* `test` : 테스트 코드, 리펙토링 테스트 코드 추가
<a href="/images/commit.png" target="_blank"><img src="/images/commit.png" width = 600></a>

# 구현단계
* 1.리스트
  - ~~콘텐츠 내용으로 이루어진 list 부분과 정렬, 필터 부분이 있습니다.~~
  - ~~필터의 내용과 페이지를 parameter로 api를 호출하여 리스트의 내용을 받아옵니다.~~
  - ~~디자인 가이드에 맞춰 정렬, 공간, 주거형태 필터를 만들어주세요.~~
  - ~~디자인 가이드에 맞춰 리스팅 아이템을 만들어주세요.~~
  - ~~리스트의 각 콘텐츠는 img_url, description 을 사용하여 구성합니다.~~    - ~~리스트 하단에 도달하면 자동으로 같은 데이터를(Page를 변화하지 않고) 조회하여 콘텐츠를 아래로 추가합니다.~~

* 2.콘텐츠 상세보기
  - ~~자유롭게 Facebook 예시와 유사하게 만들어주세요.~~
  - ~~리스트의 특정 콘텐츠 터치 시 검은 배경 위에 image와 description이 가운데에 노출됩니다.~~    - ~~image를 pinch zoom으로 확대할 수 있습니다.~~
  - ~~상세보기 상태에서 image panning 시 image가 손가락을 따라 이동하고,~~
  - ~~배경의 투명도가 조절됩니다.~~
  - ~~image가 center 위치에서 어느 정도 벗어난 상태에서 손가락을 떼면 상세보기 상태에서 다시 리스트로 전환되고, 이미지는 원래 위치로 이동합니다.~~
