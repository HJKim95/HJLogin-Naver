# HJLogin-Naver

## Example

LoginTest - ViewController를 통해 설정 예시를 확인해볼 수 있습니다.

## Requirements
파일을 내려받기 전, Alamofire를 podfile을 통해 설치해주시고 네이버 로그인 기본 설정을 모두 마쳐주세요.

## Installation

Naver.swift, NaverModel.swift 두 파일을 복사하셔서 해당 프로젝트에 붙여넣으시면 됩니다.  
(이때 copy items if needed에 꼭 체크해주세요.)

getUserInfo( ) 를 통해 KakaoModel를 parameter로 받아와 사용할 수 있습니다.
```ruby
let user = Naver()
user.getUserInfo { [weak self] (kakao) in
//            print(naver.birthday)
//            print(naver.email)
//            print(naver.gender)
//            print(naver.id)
//            print(naver.profile_image_url)
//            print(naver.nickname)
}
```

## Author

HJKim95, 25ephipany@naver.com

## License

HJLogin-Naver is available under the MIT license. See the LICENSE file for more info.

