//
//  Country.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/03.
//

import SwiftUI

struct Country: Hashable {
    let countryName: String
    let continent: String
    let isHaveLocality: Bool
    let countryLocality: [String]
}

struct CountryList {
    var GMT: [Int: [Country]]
    static var list: CountryList =
    CountryList(
        GMT: [
            -12: [
                Country(countryName: "미국령 군소 제도",
                        continent: "태평양",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -11: [
                Country(countryName: "니우에",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국령 사모아",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국령 군소 제도",
                        continent: "태평양",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -10: [
                Country(countryName: "하와이",
                        continent: "태평양",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "프랑스령 폴리네시아",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국령 군소 제도",
                        continent: "태평양",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "쿡 제도",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "앤드리아노프 제도",
                        continent: "북아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -9: [
                Country(countryName: "알래스카",
                        continent: "북아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "강비에 제도",
                        continent: "태평양",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -8: [
                Country(countryName: "멕시코",
                        continent: "중앙아메리카",
                        isHaveLocality: true,
                        countryLocality: ["바하 칼리포니아"]
                       ),
                Country(countryName: "미국",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["캘리포니아",
                                          "로스앤젤레스",
                                          "워싱턴",
                                          "시애틀",
                                          "네바다",
                                          "라스베가스",
                                          "오리건",
                                          "포틀랜드"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["브리티시 컬럼비아",
                                          "밴쿠버",
                                          "빅토리아",
                                          "유콘 준주",
                                          "화이트호스"
                                         ]
                       ),
                Country(countryName: "클리퍼튼아일랜드",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -7: [
                Country(countryName: "멕시코",
                        continent: "중앙아메리카",
                        isHaveLocality: true,
                        countryLocality: ["바하 칼리포니아 수르주",
                                          "치와와",
                                          "나야리트",
                                          "시날로아",
                                          "소노라주"
                                         ]
                       ),
                Country(countryName: "미국",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["아이다호",
                                          "콜로라도",
                                          "뉴멕시코",
                                          "몬태나",
                                          "유타",
                                          "와이오밍",
                                          "애리조나"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["앨버타",
                                          "누나부트",
                                          "노스웨스트 준주"
                                         ]
                       )
            ],
            -6: [
                Country(countryName: "니카라과",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["앨라배마",
                                          "버밍햄, MI",
                                          "아칸소",
                                          "일리노이",
                                          "시카고",
                                          "아이오와",
                                          "루이지애나",
                                          "뉴올리언스",
                                          "미네소타",
                                          "미니애폴리스",
                                          "미시시피",
                                          "미주리",
                                          "캔자스시티",
                                          "오클라호마",
                                          "위스콘신",
                                          "밀워키",
                                          "캔자스",
                                          "네브래스카",
                                          "오하마",
                                          "노스다코타",
                                          "사우스다코다",
                                          "테네시",
                                          "텍사스",
                                          "휴스턴"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["서스캐처원",
                                          "누나부트",
                                          "매니토바",
                                         ]
                       ),
                Country(countryName: "과테말라",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "온두라스",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "코스타리카",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "멕시코",
                        continent: "중앙아메리카",
                        isHaveLocality: true,
                        countryLocality: ["코아우일라",
                                          "누에보레온",
                                          "타마울리파스",
                                          "사카테카스",
                                          "두랑고",
                                          "산루이스포토시",
                                          "할리스코",
                                          "콜리마",
                                          "케레타로",
                                          "틀락스칼라",
                                          "멕시코시티",
                                          "미초아칸",
                                          "게레로",
                                          "푸에블라",
                                          "오악사카",
                                          "타바스코",
                                          "캄페체",
                                          "치아파스",
                                          "유카탄"
                                         ]
                       ),
                Country(countryName: "엘살바도르",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -5: [
                Country(countryName: "에콰도르",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["코네티컷",
                                          "델라웨어",
                                          "워싱턴, DC",
                                          "조지아주",
                                          "볼티모어",
                                          "매사추세츠",
                                          "보스턴",
                                          "뉴햄프셔스",
                                          "콩고드, NH",
                                          "뉴저지",
                                          "뉴욕",
                                          "노스캐롤라이나",
                                          "오하이오",
                                          "펜실베이니아",
                                          "필라델피아",
                                          "사우스캐롤라이나",
                                          "버몬트",
                                          "버지니아",
                                          "리치먼드",
                                          "웨스트버지니아",
                                          "플로리다",
                                          "인디애나",
                                          "인디애나폴리스",
                                          "미시간",
                                          "디트로이트",
                                          "켄터키"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["아이퀘루이트, NU",
                                          "온타리오",
                                          "토론토",
                                          "퀘백",
                                          "몬트리올"
                                         ]
                       ),
                Country(countryName: "자메이카",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아이티",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "페루",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "쿠바",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "바하마",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "콜롬비아",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "파나마",
                        continent: "중앙아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "이스터 섬",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -4: [
                Country(countryName: "베네수엘라",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "캐나다",
                        continent: "북아메리카",
                        isHaveLocality: true,
                        countryLocality: ["뉴브런즈윅",
                                          "뉴펀들랜드 래브라도"
                                         ]
                       ),
                Country(countryName: "브라질",
                        continent: "남아메리카",
                        isHaveLocality: true,
                        countryLocality: ["Mato Grosso",
                                          "Moto Grosso do Sul"
                                         ]
                       ),
                Country(countryName: "칠레",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "카리브 해",
                        continent: "중앙아메리카",
                        isHaveLocality: true,
                        countryLocality: ["앵귈라",
                                          "앤티가 바부다",
                                          "바베이도스",
                                          "도미니카",
                                          "그레나다",
                                          "몬트세라트",
                                          "세인트키츠 네비스",
                                          "세인트루시아",
                                          "세인트빈센트 그레나딘",
                                          "트리니다드 토바코",
                                          "푸에르토리코",
                                          "아루바",
                                          "도미니카 공화국",
                                          "과들루프",
                                          "마르티니크",
                                          "신트마르턴"
                                         ]
                       ),
                Country(countryName: "가이아나",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "파라과이",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "볼리비아",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -3: [
                Country(countryName: "그린란드",
                        continent: "북아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "브라질",
                        continent: "남아메리카",
                        isHaveLocality: true,
                        countryLocality: ["Brasilia",
                                          "Rio de Janeiro",
                                          "San Paulo"
                                         ]
                       ),
                Country(countryName: "수리남",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "우루과이",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "프랑스령 기아나",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아르헨티나",
                        continent: "남아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "생피에르 미클롱",
                        continent: "북아메리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -2: [
                Country(countryName: "사우스 샌드위치 제도",
                        continent: "대서양",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -1: [
                Country(countryName: "아조레스",
                        continent: "대서양",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "카보베르데",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            0: [
                Country(countryName: "아이슬란드",
                        continent: "북유럽",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "영국",
                        continent: "서유럽",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아일랜드",
                        continent: "서유럽",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "포르투갈",
                        continent: "서유럽",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "모리타니",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "가나",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "기니",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "말리",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "감비아",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "세네갈",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "페로 제도",
                        continent: "북유럽",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "부르키나파소",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "코트디부아르",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "시에라리온",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "라이베리아",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "토고",
                        continent: "서아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            1: [
                Country(countryName: "중앙유럽",
                        continent: "중앙유럽",
                        isHaveLocality: true,
                        countryLocality: ["알바니아 (티라나)",
                                          "안도라 (안도라라벨랴)",
                                          "오스트리아 (빈)",
                                          "벨기에 (브뤼셀)",
                                          "보스니아 헤르체고비나 (사라예보)",
                                          "크로아티아 (자그레브)",
                                          "체코 (프라하)",
                                          "덴마크 (코펜하겐)",
                                          "프랑스 (파리)",
                                          "독일 (베를린)",
                                          "지브롤터 (웨스트사이드)",
                                          "헝가리 (부다페스트)",
                                          "이탈리아 (로마)",
                                          "리히텐슈타인 (파두츠)",
                                          "룩셈부르크 (룩셈부르크)",
                                          "북마케도니아 (스코페)",
                                          "몰타 (발레타)",
                                          "모나코 공국 (모나코)",
                                          "몬테네그로 (포드고리차)",
                                          "네덜란드 (암스테르담)",
                                          "노르웨이 (오슬로)",
                                          "폴란드 (바르샤바)",
                                          "산마리노 (세라발레)",
                                          "세르비아 (베오그라드)",
                                          "슬로바키아 (브라티슬라바)",
                                          "슬로베니아 (류블랴나)",
                                          "스페인 (마그리드)",
                                          "스웨덴 (스톡홀름)",
                                          "스위스 (베른)",
                                          "바티칸 시국 (바티칸)"
                                         ]
                       ),
                Country(countryName: "모로코",
                        continent: "북아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "알제리",
                        continent: "북아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "나이지리아",
                        continent: "중앙아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "튀니지",
                        continent: "북아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "니제르",
                        continent: "북아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "콩고 공화국",
                        continent: "중앙아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "중앙아프리카 공화국",
                        continent: "중앙아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            2: [
                Country(countryName: "팔레스타인",
                        continent: "중동",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["칼리닌그라드"]
                       ),
                Country(countryName: "중앙아프리카",
                        continent: "중앙아프리카",
                        isHaveLocality: true,
                        countryLocality: ["보츠와나",
                                          "부룬디",
                                          "이집트",
                                          "레소토",
                                          "리비아",
                                          "르완다",
                                          "말라위",
                                          "모잠비크",
                                          "에스와티니",
                                          "잠비아",
                                          "짐바브웨",
                                          "나미비아",
                                          "남아프리카 공화국",
                                          "수단"
                                         ]
                       ),
                Country(countryName: "동유럽",
                        continent: "동유럽",
                        isHaveLocality: true,
                        countryLocality: ["불가리아 (소피아)",
                                          "키프로스 (니코시아)",
                                          "에스토니아 (탈린)",
                                          "올란드 제도 (마리에함)",
                                          "그리스 (아테네)",
                                          "라트비아 (리가)",
                                          "리투아니아 (빌뉴스)",
                                          "몰도바 (키시너우)",
                                          "루마니아 (부쿠레슈티)",
                                          "우크라이나 (키이우)"
                                         ]
                       ),
                Country(countryName: "레바논",
                        continent: "중동",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "이스라엘",
                        continent: "중동",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            3: [
                Country(countryName: "중동",
                        continent: "중동",
                        isHaveLocality: true,
                        countryLocality: ["바레인",
                                          "이라크",
                                          "요르단",
                                          "쿠웨이트",
                                          "사우디아라비아",
                                          "예멘",
                                          "카타르",
                                          "시리아",
                                          "터키"
                                         ]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["모스크바",
                                          "상트페테르부르크",
                                          "로스토프온돈",
                                          "노바야지믈랴 섬",
                                          "지믈랴프란차요시파 섬",
                                          "크림 반도"
                                         ]
                       ),
                Country(countryName: "남수단",
                        continent: "중앙아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "우간다",
                        continent: "중앙아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "탄자니아",
                        continent: "중앙아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "마다가스카르",
                        continent: "동아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "소말리아",
                        continent: "동아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "에티오피아",
                        continent: "동아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "케냐",
                        continent: "동아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "이란(GMT+3:30)",
                        continent: "중동",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            4: [
                Country(countryName: "조지아",
                        continent: "서아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["사마라주 (사마라)",
                                          "우드무르트 공화국 (이젭스크)",
                                          "아스트라한주 (아스트라한)"
                                         ]
                       ),
                Country(countryName: "아랍에미리트",
                        continent: "중동",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "오만",
                        continent: "중동",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "모리셔스",
                        continent: "동아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "세이셸",
                        continent: "동아프리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아르메니아",
                        continent: "서아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아제르바이잔",
                        continent: "서아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            5: [
                Country(countryName: "타지키스탄",
                        continent: "중앙아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["바쉬코르스탄 공화국",
                                          "첼랴빈스크",
                                          "쿠르간",
                                          "오렌부르크",
                                          "페름",
                                          "스베르들로프스크",
                                          "튜멘"
                                         ]
                       ),
                Country(countryName: "투르크메니스탄",
                        continent: "중앙아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "우즈베키스탄",
                        continent: "중앙아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "카자흐스탄 악퇴베",
                        continent: "중앙아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "파키스탄",
                        continent: "중앙아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "인도(GMT+5:30)",
                        continent: "남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "스리랑카(GMT+5:30)",
                        continent: "남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            6: [
                Country(countryName: "동카자흐스탄",
                        continent: "중앙아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["옴스크"]
                       ),
                Country(countryName: "방글라데시",
                        continent: "남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "부탄",
                        continent: "남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "키르기스스탄",
                        continent: "중앙아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미얀마(GMT+6:30)",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "코코스 제도(GMT+6:30)",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            7: [
                Country(countryName: "베트남",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["알타이 공화국",
                                          "케메로보",
                                          "하카시아 공화국",
                                          "크라스노야르스크",
                                          "노보시비르스크",
                                          "톰스크",
                                          "투바 공화국"
                                         ]
                       ),
                Country(countryName: "인도네시아",
                        continent: "동남아시아",
                        isHaveLocality: true,
                        countryLocality: ["팔랑카라야",
                                          "서칼리만탄",
                                          "수마트라섬",
                                          "자카르타"
                                         ]
                       ),
                Country(countryName: "태국",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "캄보디아",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "라오스",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            8: [
                Country(countryName: "중국",
                        continent: "동아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "인도네시아",
                        continent: "동남아시아",
                        isHaveLocality: true,
                        countryLocality: ["동칼리만탄",
                                          "남칼리만탄",
                                          "마카사르"
                                         ]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["부랴트 공화국",
                                          "이르쿠츠크"
                                         ]
                       ),
                Country(countryName: "대만",
                        continent: "동아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "싱가포르",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "말레이시아",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "몽골",
                        continent: "동아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "호주",
                        continent: "오세아니아",
                        isHaveLocality: true,
                        countryLocality: ["웨스턴 오스트레일리아"]
                       ),
                Country(countryName: "필리핀",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            9: [
                Country(countryName: "대한민국",
                        continent: "동아시아",
                        isHaveLocality: true,
                        countryLocality: ["독도",
                                          "서울특별시",
                                          "인천광역시",
                                          "부산광역시",
                                          "대구광역시",
                                          "광주광역시",
                                          "대전광역시",
                                          "부산광역시",
                                          "울산광역시",
                                          "세종특별자치시",
                                          "강릉시",
                                          "포항시",
                                          "제주도",
                                          "울릉도"
                                         ]
                       ),
                Country(countryName: "북한",
                        continent: "동아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["아무르",
                                          "야쿠츠크"
                                         ]
                       ),
                Country(countryName: "인도네시아",
                        continent: "동남아시아",
                        isHaveLocality: true,
                        countryLocality: ["말루쿠 제도",
                                          "서파푸아"
                                         ]
                       ),
                Country(countryName: "일본",
                        continent: "동아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "동티모르",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "팔라우",
                        continent: "동남아시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "호주(GMT+9:30)",
                        continent: "오세아니아",
                        isHaveLocality: true,
                        countryLocality: ["노던 준주",
                                          "사우스오스트레일리아"
                                         ]
                       )
            ],
            10: [
                Country(countryName: "미국",
                        continent: "태평양",
                        isHaveLocality: true,
                        countryLocality: ["괌",
                                          "북마리아나 제도"
                                         ]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["블라디보스토크",
                                          "하바롭스크"
                                         ]
                       ),
                Country(countryName: "호주",
                        continent: "오세아니아",
                        isHaveLocality: true,
                        countryLocality: ["퀸즐랜드",
                                          "시드니",
                                          "호바트",
                                          "멜버른"
                                         ]
                       ),
                Country(countryName: "파푸아뉴기니",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            11: [
                Country(countryName: "뉴칼레도니아",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["마가단",
                                          "사할린",
                                          "쿠릴 제도",
                                          "사하 공화국"
                                         ]
                       ),
                Country(countryName: "바누아투",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "솔로몬 제도",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미크로네시아",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            12: [
                Country(countryName: "뉴질랜드",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        continent: "아시아",
                        isHaveLocality: true,
                        countryLocality: ["추코트카",
                                          "페트로파블롭스크 캄차트스키"
                                         ]
                       ),
                Country(countryName: "피지",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "마셜 제도",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "길버트 제도",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "왈리스 퓌튀나",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "나우루",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "투발루",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            13: [
                Country(countryName: "피닉스 제도",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "토켈라우 제도",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "사모아",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "통가",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            14: [
                Country(countryName: "라인 제도",
                        continent: "오세아니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ]
        ]
    )
}
