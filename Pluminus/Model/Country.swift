//
//  Country.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/03.
//

import Foundation
import SwiftUI

struct Country: Hashable {
    let countryName: String
    let isHaveLocality: Bool
    let countryLocality: [String]
}

struct CountryList {
    var UTC: [Int: [Country]]
    static var list: CountryList =
    CountryList(
        UTC: [
            -11: [
                Country(countryName: "니우에",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아메리칸사모아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -10: [
                Country(countryName: "하와이",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "프랑스령 폴리네시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -9: [
                Country(countryName: "알래스카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -8: [
                Country(countryName: "멕시코",
                        isHaveLocality: true,
                        countryLocality: ["바하칼리포르니아노르테주 (멕시칼리)"
                                         ]
                       ),
                Country(countryName: "미국",
                        isHaveLocality: true,
                        countryLocality: ["캘리포니아주 (새크라멘토, LA)",
                                          "워싱턴주 (올림피아, 시애틀)",
                                          "네바다주 (카슨시티, 라스베이가스)",
                                          "오리건주 (세일럼, 포틀랜드)"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        isHaveLocality: true,
                        countryLocality: ["브리티시컬럼비아주 (벤쿠버, 빅토리아)",
                                          "유콘준주 (화이트호스)"
                                         ]
                       )
            ],
            -7: [
                Country(countryName: "멕시코",
                        isHaveLocality: true,
                        countryLocality: ["바하칼리포르니아수르주 (라파스)",
                                          "치와와주 (치와와)",
                                          "나야리트주 (테픽)",
                                          "시날로아주 (쿨리아칸)",
                                          "소노라주 (에르모시요)"
                                         ]
                       ),
                Country(countryName: "미국",
                        isHaveLocality: true,
                        countryLocality: ["아이다호주 (보이시)",
                                          "콜로라도주 (덴버)",
                                          "뉴멕시코주 (산타페, 엘버커키)",
                                          "몬태나주 (헬레나, 빌링스)",
                                          "유타주 (솔트레이크시티)",
                                          "와이오밍주 (샤이엔)",
                                          "애리조나주 (피닉스)"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        isHaveLocality: true,
                        countryLocality: ["앨버타주 (에드먼턴, 캘거리)",
                                          "누나부트준주 서부 (쿠글루크툭)",
                                          "노스웨스트준주 (옐로나이프)"
                                         ]
                       )
            ],
            -6: [
                Country(countryName: "니카라과",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국",
                        isHaveLocality: true,
                        countryLocality: ["앨라바마주 (몽고메리, 버밍햄)",
                                          "아칸소주 (리틀록)",
                                          "일리노이주 (스프링필드, 시카고)",
                                          "아이오와주 (디모인)",
                                          "루이지애나주 (배턴루지, 뉴올리언스)",
                                          "미네소타주 (세인트폴, 미니애폴리스)",
                                          "미시시피주 (잭슨)",
                                          "미주리주 (제퍼슨시티, 캔자스시티)",
                                          "오클라호마주 (오클라호마시티)",
                                          "위스콘신주 (매디슨, 밀워키)",
                                          "캔자스주 (토피카, 위치토)",
                                          "네브래스카주 (링컨, 오하마)",
                                          "노스다코타주 (비즈마크, 파고)",
                                          "사우스다코다주 (피어, 수폴스)",
                                          "테네시주 (내슈빌)",
                                          "텍사스주 (오스틴, 휴스턴)"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        isHaveLocality: true,
                        countryLocality: ["서스캐처원주 (리자이나, 새스커툰)",
                                          "누나부트준주 중부 (랭킷인라잇)",
                                          "매니토바주 (위니펙)"
                                         ]
                       ),
                Country(countryName: "멕시코",
                        isHaveLocality: true,
                        countryLocality: ["코아우일라주 (살티요)",
                                          "누에보레온주 (몬테레이)",
                                          "타마울리파스주 (시우다드빅토리아)",
                                          "시카테카스주 (시카테카스)",
                                          "두랑고주 (두랑고)",
                                          "산루이스포토시주 (산루이스포토시)",
                                          "과나후아토주 (과나후아토)",
                                          "할리스코주 (과달라하마)",
                                          "콜리마주 (콜리마)",
                                          "아가스콸리엔테스주 (아과스칼리엔테스)",
                                          "베라크루즈주 할라파)",
                                          "케레타로주 (케레타로)",
                                          "이달고주 (파추카)",
                                          "틀락스칼라주 틀락스칼라)",
                                          "연방구 (멕시코시티)",
                                          "에스타도데멕시코주 (톨루카)",
                                          "미초아칸주 (모렐리아)",
                                          "게레로주 (칠판싱고)",
                                          "푸에블라주 (푸에블라)",
                                          "오아하카주 (오아하카)",
                                          "모렐로스주 (쿠에르나바카)",
                                          "타바스코주 (비야에르모사)",
                                          "캄페체주 (캄페체)",
                                          "치아파스주 (툭스틀라구티에레스)",
                                          "유카탄주 (메리다)"
                                         ]
                       ),
                Country(countryName: "과테말라",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "온두라스",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "코스타리카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "엘살바도르",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -5: [
                Country(countryName: "에콰도르",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국",
                        isHaveLocality: true,
                        countryLocality: ["코네티컷주 (하트퍼드, 브리지포트)",
                                          "델라웨어주 (도버, 월밍턴)",
                                          "컬럼비아구 (워싱턴 D.C)",
                                          "조지아주 (애틀란타)",
                                          "메인주 (오거스타, 포틀랜드)",
                                          "메릴랜드주 (아나폴리스, 볼티모어)",
                                          "매사추세츠주 (보스턴)",
                                          "뉴햄프셔스주 (콩고드, 맨체스터)",
                                          "뉴저지주 (트렌턴, 뉴어크)",
                                          "뉴욕주 (올버니, 뉴옥)",
                                          "노스캐롤라이나주 (롤리, 샬럿)",
                                          "오하이오주 (콜럼버스)",
                                          "펜실베이니아주 (해리스버그, 필라델피아)",
                                          "로드아일랜드주 (프로비던스)",
                                          "사우스캐롤라이나주 (컬럼비아)",
                                          "버몬트주 (몬트필리어, 벌링턴)",
                                          "버지니아주 (리치먼드, 버지니아비치)",
                                          "웨스트버지니아주 (찰스턴)",
                                          "플로리다주 (탤러해시, 잭슨빌)",
                                          "인디애나주 (인디애나폴리스)",
                                          "미시간주 (랜싱, 디트로이트)",
                                          "켄터키주 (프랭크퍼트, 루이빌)"
                                         ]
                       ),
                Country(countryName: "캐나다",
                        isHaveLocality: true,
                        countryLocality: ["누나부투준주 동부 (이칼루이트)",
                                          "온타리오주 (토론토)",
                                          "퀘백주 (퀘벡, 몬트리올)"
                                         ]
                       ),
                Country(countryName: "자메이카",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아이티",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "페루",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "쿠바",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "바하마",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "콜롬비아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "파나마",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -4: [
                Country(countryName: "베네수엘라",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "캐나다",
                        isHaveLocality: true,
                        countryLocality: ["뉴브런즈윅주 (프레더릭턴, 멍크턴)",
                                          "뉴펀들랜드 래브라도주 (세인트존스)"
                                         ]
                       ),
                Country(countryName: "브라질",
                        isHaveLocality: true,
                        countryLocality: ["아마조나스주 (마나우스)",
                                          "혼도니아주 (포르투벨류)",
                                          "호라이마주 (보아비스타)",
                                          "마투그로수주 (쿠이아바)",
                                          "마투그로수두술주 (캄푸그란지)"
                                         ]
                       ),
                Country(countryName: "칠레",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "카브리해",
                        isHaveLocality: true,
                        countryLocality: ["앵귈라 (더밸리)",
                                          "앤티가 바부다 (세인트존스)",
                                          "바베이도스 (브리지타운)",
                                          "도미니카 연방 (로조)",
                                          "그레나다 (세인트조지스)",
                                          "몬트세랫 (브레이즈)",
                                          "세인트키츠 네비스 (바스테르)",
                                          "세인트루시아 (캐스트리스)",
                                          "세인트빈센트 그레나딘 (킹스타운)",
                                          "트리니다드 토바코 (포트오브스페인)",
                                          "푸에르토리코 (산후안)",
                                          "아루바 (오라녜스타트)",
                                          "퀴라소 (빌렘스타트)",
                                          "도미니카 공화국 (산토도밍고)",
                                          "과들루프 (바스테르)",
                                          "마르티니크 (포르드프랑스)",
                                          "신트마르턴 (필립스뷔르흐)"
                                         ]
                       ),
                Country(countryName: "가이아나",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "파라과이",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "볼리비아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -3: [
                Country(countryName: "그린란드",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "브라질",
                        isHaveLocality: true,
                        countryLocality: ["알라고아스주 (마세이오)",
                                          "아마파주 (마카파)",
                                          "바이아주 (사우바도르)",
                                          "세아라주 (포르탈레자)",
                                          "마라냥주 (상루이스)",
                                          "파라주 (벨렝)",
                                          "파라이바주 (주앙페소아)",
                                          "페르남부쿠주 (헤시피)",
                                          "피아우이주 (테레지나)",
                                          "히우그란지두노르치주 (나타우)",
                                          "히우그란지두술주 (포르투알레그리)",
                                          "세르지피주 (아라카주)",
                                          "토칸칭스주 (파우마스)",
                                          "연방구 (브라질리아)",
                                          "이스피리투산투주 (비토리아)",
                                          "고이아스주 (고이아니아)",
                                          "미나스제라이스주 (벨루오리존치)",
                                          "리우데자네이루주 (리우데자네이루)",
                                          "파라나주 (쿠리치바)",
                                          "산타카타리나주 (플로리아노폴리스)",
                                          "상파울루주 (상파울루)"]
                       ),
                Country(countryName: "수리남",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "우루과이",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "프랑스령 기아나",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아르헨티나",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -2: [
                Country(countryName: "생피에르 미클롱",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "사우스조지아 샌드위치 제도",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            -1: [
                Country(countryName: "아소르스 제도",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "카보베르테",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            0: [
                Country(countryName: "아이슬란드",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "영국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아일랜드",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "포르투갈",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "모리타니",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "가나",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "기니",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "말리",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "감비아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "세네갈",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            1: [
                Country(countryName: "나이지리아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "중앙유럽",
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
                                          "몰타 (발레타, 비르키르카라)",
                                          "모나코 공국 (모나코)",
                                          "몬테네그로 (포드고리차)",
                                          "네덜란드 (암스테르담)",
                                          "노르웨이 (오슬로)",
                                          "폴란드 (바르샤바)",
                                          "산마리노 (산마리노, 세라발레)",
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
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "알제리",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "튀니지",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "니제르",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "콩고 공화국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "중앙아프리카 공화국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            2: [
                Country(countryName: "팔레스타인",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["킬리닌그라두즈 (킬리닌그라드)"
                                         ]
                       ),
                Country(countryName: "중앙아프리카",
                        isHaveLocality: true,
                        countryLocality: ["보츠와나 (가보로네)",
                                          "부룬디 (기테가)",
                                          "콩고민주공화국 동부 (킨샤사)",
                                          "이집트 (카이로)",
                                          "레소토 (마세루)",
                                          "리비아 (트리폴리)",
                                          "르완다 (키갈리)",
                                          "말라위 (릴롱궤)",
                                          "모잠비크 (마푸투)",
                                          "에스와티니 (로밤바)",
                                          "잠비아 (루사카)",
                                          "짐바브웨 (하라레)",
                                          "나미비아 (빈트후크)",
                                          "남아프리카 공화국 (케이프타운)",
                                          "수단 (하르툼, 옴두르만)"
                                         ]
                       ),
                Country(countryName: "동유럽",
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
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "이스라엘",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            3: [
                Country(countryName: "중동",
                        isHaveLocality: true,
                        countryLocality: ["바레인 (마나마)",
                                          "이라크 (바그다드)",
                                          "요르단 (암만)",
                                          "쿠웨이트 (쿠웨이트)",
                                          "사우디아라비아 (리야드)",
                                          "예멘 (사나)",
                                          "카타르 (도하)",
                                          "시리아 (다마스쿠스)",
                                          "튀르키예 (앙카라)"
                                         ]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["모스크바",
                                          "상트페테르부르크",
                                          "로스토프나도누",
                                          "노바야제믈랴 제도",
                                          "제믈랴프란차이오시파 제도",
                                          "크림 공화국 (크림 반도)"
                                         ]
                       ),
                Country(countryName: "남수단",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "우간다",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "탄자니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "마다가스카르",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "소말리아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "에티오피아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "케냐",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            4: [
                Country(countryName: "조지아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["사마라주 (사마라)",
                                          "우드무르트 공화국 (이젭스크)",
                                          "아스트라한주 (아스트라한)"
                                         ]
                       ),
                Country(countryName: "아랍에미리트",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "오만",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "모리셔스",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "세이셸",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아르메니아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "아르차흐 공화국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            5: [
                Country(countryName: "타지키스탄",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["바시키르 공화국 (우파)",
                                          "첼랴빈스크주 (첼랴빈스크)",
                                          "쿠르간주 (쿠르간)",
                                          "오렌부르크주 (오렌부르크)",
                                          "페름 변경주 (페름)",
                                          "스베르들롭스크주 (예카테린부르크)",
                                          "튜멘주 (튜멘)"
                                         ]
                       ),
                Country(countryName: "투르크메니스탄",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "우즈베키스탄",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "카자흐스탄 서부",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "파키스탄",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            6: [
                Country(countryName: "카자흐스탄 동부",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["옴스크주 (옴스크)"]
                       ),
                Country(countryName: "방글라데시",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "부탄",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "키르기스스탄",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            7: [
                Country(countryName: "베트남",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["알타이 공화국 (고르노알타이스크)",
                                          "케메로보주 (케메로보)",
                                          "하카스 공화국 (아바칸)",
                                          "크라스노야르스크주 (크라스노야르스크)",
                                          "노보시비르스크주 (노보시비르스크)",
                                          "톰스크주 (톰스크)",
                                          "투바 공화국 (키질)"
                                         ]
                       ),
                Country(countryName: "인도네시아",
                        isHaveLocality: true,
                        countryLocality: ["중앙칼리만탄주 (팔랑카라야)",
                                          "서칼리만탄주 (폰티아낙)",
                                          "수마트라섬 (메단)",
                                          "자와섬 (자카르타)"
                                         ]
                       ),
                Country(countryName: "태국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "캄보디아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "라오스",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            8: [
                Country(countryName: "중국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "인도네시아",
                        isHaveLocality: true,
                        countryLocality: ["동칼리만탄주 (사마린다, 발릭파판)",
                                          "남칼리만탄주 (반자르바루, 반자르마신)",
                                          "술라웨시섬 (마카사르, 마나도)"
                                         ]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["부랴트 공화국 (울란우데)",
                                          "이르쿠츠크주 (이르쿠츠크)"
                                         ]
                       ),
                Country(countryName: "대만",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "싱가포르",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "말레이시아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "몽골",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "호주",
                        isHaveLocality: true,
                        countryLocality: ["웨스턴오스트레일리아주 (퍼스)"]
                       ),
                Country(countryName: "필리핀",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            9: [
                Country(countryName: "조선민주주의인민공화국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["아무르주 (블라고베센스크)",
                                          "자바이칼 변경주 (치타)",
                                          "사하 공화국 (야쿠츠크)"
                                         ]
                       ),
                Country(countryName: "인도네시아",
                        isHaveLocality: true,
                        countryLocality: ["말루쿠 제도",
                                          "파푸아주 (자야푸라)",
                                          "서파푸아주 (마노콰리)"
                                         ]
                       ),
                Country(countryName: "일본",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "동티모르",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "필라우",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "대한민국",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            10: [
                Country(countryName: "파푸아뉴기니",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미국",
                        isHaveLocality: true,
                        countryLocality: ["괌 (하갓냐)",
                                          "북마리나 제도 (사이판)"
                                         ]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["프리모르스키 변경주 (블라디보스토크)",
                                          "하바롭스크 변경주 (하바롭스크)"
                                         ]
                       ),
                Country(countryName: "호주",
                        isHaveLocality: true,
                        countryLocality: ["퀸즐랜드주 (브리즈번)",
                                          "수도 특구 (캔버라)",
                                          "뉴사우스웨일스주 (시드니)",
                                          "태즈메이니아주 (호바트)",
                                          "빅토리아주 (멜버른)"
                                         ]
                       )
            ],
            11: [
                Country(countryName: "누벨칼레도니",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["마가단주 (마가단)",
                                          "사할린주 (유즈노사할린스크)"
                                         ]
                       ),
                Country(countryName: "바누아투",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "솔로몬 제도",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "미크로네시아 연방",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            12: [
                Country(countryName: "뉴질랜드",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "러시아",
                        isHaveLocality: true,
                        countryLocality: ["축지 자치구 (아나디리)",
                                          "캄차카 변경주 (페트로파블롭스크캄차츠키)"
                                         ]
                       ),
                Country(countryName: "피지",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "마셜 제도",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "키리바시 길버트 제도",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "왈리스 푸투나",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "나우루",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "투발루",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            13: [
                Country(countryName: "키리바시 피닉스 제도",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "토켈라우",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "사모아",
                        isHaveLocality: false,
                        countryLocality: [""]
                       ),
                Country(countryName: "통가",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ],
            14: [
                Country(countryName: "키리바시 라인 제도",
                        isHaveLocality: false,
                        countryLocality: [""]
                       )
            ]
        ]
    )
}
