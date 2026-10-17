# 카미후부키 — Android APK 만들기 (간편 빌드)

기존 `www/index.html` 게임을 Capacitor로 감싼 Android 앱 프로젝트입니다. 게임 로직을 네이티브로 다시 작성하지 않습니다.

## 가장 쉬운 방법: GitHub에서 APK 자동 빌드

이 방법은 내 PC에 Android Studio나 Android SDK를 설치하지 않고, GitHub의 빌드 서버에서 APK를 만들도록 구성되어 있습니다. GitHub 계정이 필요합니다.

1. 이 ZIP 파일을 PC에서 압축 해제합니다.
2. GitHub에서 새 저장소(repository)를 만듭니다. 예: `kamifubuki-android`. 개인 저장소로 만들어도 됩니다.
3. 압축 해제한 폴더 안의 **모든 파일과 폴더**를 저장소에 업로드합니다. `.github/workflows/build-apk.yml` 파일도 반드시 포함해야 합니다.
4. 업로드 후 저장소의 **Actions** 탭을 엽니다. `Build Android APK` 작업이 자동 실행됩니다. 자동 실행되지 않으면 Actions에서 해당 workflow를 선택하고 **Run workflow**를 누릅니다.
5. 작업이 끝나면 초록색 체크 표시가 있는 실행 항목을 열고 아래쪽 **Artifacts**에서 `kamifubuki-debug-apk`를 다운로드합니다.
6. 내려받은 ZIP을 풀면 `app-debug.apk`가 있습니다. 이 APK를 Android 휴대폰으로 옮겨 열어 설치합니다. Android가 출처를 알 수 없는 앱 설치 허용을 요청하면 브라우저/파일 관리자에 대해 허용해야 할 수 있습니다.

GitHub Actions는 클라우드에서 Android 빌드 환경을 설정하고 APK를 결과물로 보관합니다. 이 프로젝트는 **디버그 APK**를 생성합니다. 개인 기기에서 테스트·설치하는 용도이며, Google Play 배포용 서명 릴리스 APK는 별도 서명 구성이 필요합니다.

## 대안: Android Studio에서 직접 빌드

1. Node.js 20 이상과 Android Studio/Android SDK를 설치합니다.
2. 이 폴더에서 터미널을 열고 다음을 실행합니다.

   ```bash
   npm install
   npx cap add android
   npx cap open android
   ```

3. Android Studio에서 **Build → Build Bundle(s) / APK(s) → Build APK(s)** 를 선택합니다.
4. 보통 `android/app/build/outputs/apk/debug/app-debug.apk`에 생성됩니다.

## HTML 수정 후

`www/index.html`을 수정하면 다음 빌드에서 변경 사항이 반영됩니다. GitHub 저장소에 수정 사항을 업로드하면 자동 빌드가 다시 실행됩니다.

## 현재 HTML에서 확인한 사항

- Canvas 렌더링 및 Pointer Events 입력 사용
- 화면 터치 가상 조작 포함
- `localStorage`에 진행 데이터 저장
- Web Audio API로 효과음/배경음 생성
- 웹 폰트는 Google Fonts에서 불러오므로 오프라인에서는 시스템 폰트로 대체될 수 있음

## 주의

- APK 빌드가 성공해도 실제 Android 기기에서 게임 조작, 화면 비율, 오디오, 진동을 별도로 테스트해야 합니다.
- 앱 데이터 삭제 또는 앱 제거 시 `localStorage` 진행 데이터가 사라질 수 있습니다.
- 이 ZIP에는 APK 바이너리가 미리 들어 있지 않습니다. APK는 위 GitHub Actions 빌드가 성공한 뒤 Artifacts에서 내려받습니다.


## 이번 최적화 버전

- 업로드된 최신 `카미후부키.html`을 앱의 `www/index.html`로 반영했습니다.
- 보통/높음 그래픽의 캔버스 픽셀 밀도와 파티클 수를 조정해 모바일 GPU 부하와 발열을 줄이도록 했습니다. 낮음 그래픽 옵션은 그대로 유지했습니다.
- GitHub Actions에서 디버그 서명 키 캐시를 사용하도록 설정해, 이번 빌드 이후에는 같은 저장소의 후속 APK 업데이트가 기존 설치본 위에 설치될 가능성을 높였습니다.
- **주의:** 기존에 만든 APK는 이전 빌드 서명키와 다를 수 있어 첫 업데이트는 기존 앱을 제거한 뒤 설치해야 할 수 있습니다. 제거하면 게임 저장 데이터가 삭제될 수 있습니다. 기존 앱을 지우기 전에 진행 데이터를 잃어도 되는지 확인하세요.
