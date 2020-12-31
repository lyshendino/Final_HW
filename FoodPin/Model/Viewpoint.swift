//
//  Viewpoint.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2020/11/19.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit
import CoreData

class Viewpoint {
    var name: String
    var location: String
    var phone: String
    var summary: String
    var image: String
    var isVisited: Bool
    var rating: String
    
    init(name: String, location: String, phone: String, summary: String, image: String, isVisited: Bool) {
        self.name = name
        self.location = location
        self.phone = phone
        self.summary = summary
        self.image = image
        self.isVisited = isVisited
        self.rating = ""
    }
    
    static func writeViewpointFromBegin() {
        
        let sourceArray: [Viewpoint] = [
            Viewpoint(name: "知卡宣森林公園", location: "花蓮縣吉安鄉中正路二段299號", phone: " 03-8233575 ", summary:"「知卡宣森林公園」原名南埔綠森林公園，占地約為11公頃。日治時代曾是空軍基地，後經重新規畫整修，以童話為主要設計風格，結合中央廣場、風向儀廣場、原生植物園區、水生植物園區、龍骨溫室、趣味蜻蜓塑像、兒童遊樂區和花園迷宮。打造出一座休閒與生態教育的多功能休憩公園，為假日親子同遊的最佳休憩場所。", image: "photo_1.pg ", isVisited: false),

            Viewpoint(name: "貨櫃屋星巴克", location: "花蓮縣吉安鄉南濱路一段505 號, ", phone: " 03-8420014", summary: "貨櫃屋星巴克位在花蓮縣吉安鄉，是全球第一間美國西雅圖貨櫃屋星巴克還要大一倍的門市，更是邀請日本知名建築設計師-隈研吾設計，並於2018年九月開幕，洄瀾門市的設計以貨櫃與綠建築標準打造，還有環保節能咖啡得來速設計，除此之外白色貨櫃屋交錯連結，遠遠看還更有積木風格。", image: "photo_2.jpg ", isVisited: false),

            Viewpoint(name: "楓林步道", location: "吉安鄉福興村大山", phone: "232-123456", summary: "「楓林步道」位於吉安鄉福興村大山，山上楓樹成林，沿線三點四公更是均可眺望阡陌縱橫的吉安鄉全景，更可俯瞰整個花蓮平原及海岸山脈北側，為新興的爬山賞楓景點。", image: "photo_3.jpg", isVisited: false),

            Viewpoint(name: "慶修院", location: "吉安鄉吉安村中興路349號", phone: " 03-8521762 ", summary: "建築形制遵循日本傳統高野山脈寺院形式，特殊的日本寺院建築，木造主架構，上覆鐵皮，四週設有花木扶疏的迴廊，不但可供做講堂課室，也可供信眾靈療養病之用。", image: "photo_4.pg", isVisited: false),

            Viewpoint(name: "東華大學", location: "花蓮縣壽豐鄉志學村大學路二段1號", phone: "03-8635000", summary: "「東華大學」共佔地251公頃，偌大的校園中擁有東湖、華湖和小華湖三個湖泊，其中又以東湖最為有名。校內多數建築物座落於湖畔，景色優美，宛若歐式莊園。湖上有著橫跨湖面的觀景橋，為觀看東華美景的好地方。", image: "photo_5.jpg", isVisited: false),

            Viewpoint(name: "雲山水自然生態農場", location: "花蓮縣壽豐鄉豐坪路二段2巷201弄18號", phone: "038656298", summary: "雲山水全名為花蓮壽豐園山水生態農莊(夢幻湖)，本為秘境的景點後因景色太過優美吸引大批旅人前來，進而成為來到花蓮必訪景點之一，園區內永有一大片夢幻湖泊，湖畔邊綠草如茵，並種植著椰子樹與各式植栽，天氣好時搭配著白雲與遠方的山巒層疊便形成了名符其實的「雲山水」，美得讓人不敢相信此為實景而非畫作。", image: "photo_6.jpg", isVisited: false),

            Viewpoint(name: "花蓮海洋公園",location: "花蓮縣壽豐鄉189號", phone: "03-8123123", summary: "花蓮海洋公園位於花蓮縣壽豐鄉鹽寮村，為全國首創海洋生態互動式主題樂園，園區佔地約50公頃相當廣大，設有海洋村、海洋館、海洋劇場、嘉年華歡樂街、海盜灣、布萊登海岸、海底王國、水晶城堡八大主題區，主題區裡提供多元有趣戲水遊樂設施、雲霄飛車、海獅劇場、海豚表演等活動，此外，園區內有空中纜車及電扶梯戴送遊客，時時刻刻散發著知性歡樂的氣息，倘若您想來此渡假，海洋公園也結合了鄰近的遠來飯店、理想大地渡假村，提供豐富的系列行程。", image: "photo_7.jpg", isVisited: false),

            Viewpoint(name: "鯉魚潭", location: "壽豐鄉池南村", phone: "03-8641691",summary: "鯉魚潭位於花蓮縣壽豐鄉，湖的面積約104公頃，面積廣大呈南北狹長的橢圓形狀，是東台灣最大的內陸湖泊，潭的四周為環潭公路，全程約5公里，遊客可以來此騎乘自行車，享受健康有氧的愉悅假期。", image: "photo_8.jpg", isVisited: false),

            Viewpoint(name: "立川漁場", location: "壽豐鄉共和村魚池路45號", phone: "03-8651333", summary: "立川漁場擁有天然清澈湧泉，並以此養殖黃金蜆.金鐏.香魚和水鰻等新鮮水產。品質優良，遠近馳名。", image: "photo_9.jpg", isVisited: false),

            Viewpoint(name: "林田山林業文化園區", location: "花蓮縣鳳林鎮林森路99巷99號", phone: "03-86545463", summary: "林田山林場面積遼闊，林木產量豐富。1939年日本政府為了取得戰爭所需資源，在台成立新月株式會社。並在林田山成立砍伐事業所，砍伐造船所需之針葉木材均運往日本，開啟了林田山的伐木事業。1972年三月二十日，由於伐木工人升火燒烤野鼠不慎，引起森林火災，延燒面積廣達二千多公頃，時間長達一個月，自此宣告林田山沒落。次年中興紙業公司就將林田山交還林務局，而後政策改變，林田山不再伐木，並逐漸沒落、蕭條。林務局為了發展森林遊樂事業，1981年曾委託專家完成林田山森林遊樂區規劃工作。", image: "photo_10.jpg", isVisited: false),

            Viewpoint(name: "鳳林校長夢工廠", location: "鳳林鎮民生街10號", phone: "03-8762771-195", summary: "鳳林鎮歷年來以培育出82位校長為傲，「校長夢工廠」將透過開放性的閱讀場所提供學子良好的閱讀空間，且開發多元化教材，提供學子一處生活教室。「校長夢工廠」的地點，是日據時期興建的「鳳林支廳長官官舍」，具有歷史傳承的意義。", image: "photo_11.jpg", isVisited: false),

            Viewpoint(name: "馬太鞍古屋", location: "光復鄉大馬村武昌街188號", phone: "03-8700203", summary: "馬太鞍古屋為1924年由謝寶玉的父親謝伯芳籌建而成，並於1929年完工。建築形式為斜頂鐵皮屋，純原住民手工打造的樑柱，接頭處鑿洞加卡榫，並於大廳門楣、橫樑刻有雕花，屋頂則以箭竹排列，外覆鐵皮，床板早期使用黃藤編製，現改為木質地板床。八角柱型大樑，廿四支大柱無基礎，直接安放石塊上，防震又不怕颱風。木製窗櫺底層有酒瓶倒立，採光通風良好，電源則沿用早期雙瓷器平行接線方式，採用閘刀保險絲開關，別有一番獨特風味。", image: "photo_12.jpg", isVisited: false),

            Viewpoint(name: "大農大富平地森林園區", location: "花蓮縣光復鄉台9線256K處", phone: "03 870 0870", summary: "大農大富平地森林園區為花蓮光復鄉的新興景點，於2011年5月正式揭幕，由光復糖廠配合林務局以保育為主進行倡導之林業政策，以低碳、低開發、低商業性等三低原則進行規劃，結合在地農業、文化以及環境教育，打造出多元的旅遊園區。面積約40個大安森林公園的平地森林，不但設有兼具生態、人文、美景與環保特質的綠能設施，更獲選台灣熱氣球節三大舉辦場地之一。", image: "photo_13.jpg", isVisited: false),

            Viewpoint(name: "親不知子斷崖", location: "花蓮縣豐濱鄉花東海岸公路", phone: "232-923423", summary: "穿越斷崖絕壁之新磯隧道旁即是昔日所謂的親不知子斷崖。地處危巖峭壁，以險峻著稱，花東公路未開鑿之前，磯崎至新社間的斷崖是附近村落與外界的聯絡孔道，路窄壁狹，行走不易，相傳有一雅美族婦人背著小孩走過斷崖，行走時因過度緊張，攀援過崖後，才驚然發覺小孩已不見蹤影，而取其名，意指地勢險峻，連父母子女之親也難以扶持共濟。", image: "photo_14.jpg", isVisited: false),

            Viewpoint(name: "靜浦北迴歸線界標", location: " 977花蓮縣豐濱鄉台11線", phone: "232-255541", summary: "北迴歸線是北半球溫帶和熱帶的分界線，環繞北半球十六個國家，其中在臺灣就有三座北迴歸線標碑，分別位於嘉義的水上、花蓮的舞鶴及花蓮的靜浦，每年夏至時（6月21日或22日），正午的太陽直射此地。呈現燈塔狀的北回歸線標碑形，中間有狹長細縫，一柱擎天的景象十分壯觀，遊客們可以到此感覺一腳站在熱帶，另一腳站在亞熱帶的奇妙的感受。", image: "photo_15.jpg", isVisited: false),

            Viewpoint(name: "石梯坪遊客服務中心", location: "豐濱鄉港口村石梯坪52號", phone: "03-8781452", summary: "石梯坪位於石梯灣南側的尾端，為一處綿亙達一公里、佈滿灰白色奇岩怪石的海濱，這裡的奇石排列如梯，後方又有大片平坦海階，遂名為石梯坪。", image: "photo_16.jpg", isVisited: false),

            Viewpoint(name: "瑞穗牧場", location: "瑞穗鄉舞鶴村158號", phone: "03-8873916", summary: "瑞穗牧場位於瑞穗鄉舞鶴村，牧場為瑞穗鄉酪農區，此地的水源相當潔淨、空氣新鮮，因此所飼養的乳牛頭頭壯碩豐滿，牛奶也非常好喝。現今的瑞穗牧場，已朝多元的方向來經營，園內不但設有遊客中心、露天咖啡座、自行車道等設施，牧場也提供新鮮的牛奶製品，供遊客食用，歡迎您攜家帶眷一同來到瑞穗牧場，享受有趣的黃金假期。", image: "photo_17.jpg", isVisited: false),

            Viewpoint(name: "吉蒸牧場", location: "花蓮縣瑞穗鄉中山路三段230號", phone: "03-8875588", summary: "「吉蒸牧場」位於東管處瑞穗泛舟遊客中心附近。取名自吉祥如意，蒸蒸日上。創辦人范紀明夫婦以製造最優品質鮮乳為使命而創立，經過一連串的考驗後，而後榮獲唯一『花蓮縣無毒農業』標章的酪農業，更得到酪農業中的金像獎『五顆梅花』標章。", image: "photo_18.jpg", isVisited: false),

            Viewpoint(name: "秀姑巒溪泛舟遊客中心", location: "瑞穗鄉中山路三段215號", phone: "03-8875400", summary: "秀姑巒溪跨越歐亞板塊與菲律賓板塊兩大板塊，特殊的地質讓遊客在22公里短短的泛舟活動中可以看到五種不同的地質，地質學家總是稱讚秀姑巒溪是台灣「最有個性的河川」。源起中央山脈崙天山的秀姑巒溪由南向北，一路匯集了清水溪、塔比拉溪、紅葉溪、富源溪等大小河川，在瑞穗匯合流向太平洋。", image: " photo_19.jpg ", isVisited: false),

            Viewpoint(name: "赤柯山金針花", location: "花蓮縣玉里鎮觀音里高寮", phone: "232-95123", summary: "赤柯山原盛產赤柯樹，堅硬的木材為日治時期製造槍托的重要材料，爾後隨著西部移入的漢人逐漸開墾、種植農作物，綠意盎然的赤柯山被滿山遍野的金針花給染成艷黃，陽剛氣質的肅殺氣氛不再，取而代之的是溫馨小巧的金山花朵隨風搖曳綻放。", image: " photo_20.jpg ", isVisited: false),

        ]
        
        var viewpoint: RestaurantMO!
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            for i in 0..<sourceArray.count {
                viewpoint = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                viewpoint.name = sourceArray[i].name
                viewpoint.location = sourceArray[i].location
                viewpoint.phone = sourceArray[i].phone
                viewpoint.summary = sourceArray[i].summary
                viewpoint.isVisited = false
                viewpoint.rating = nil
                viewpoint.image = UIImage(named: sourceArray[i].image)!.pngData()
            }
            appDelegate.saveContext() //write once for all new restauranrs
        }
    }
    
}

