# encoding: UTF-8

Role.create({name: 'admin'})
Role.create({name: 'moderator'})
Role.create({name: 'superadmin'})

UserRole.create({name: 'member'})

User.create :username => "Adam", :email => "adam@summers.com.tw", :password => "23219217"

Admin.create :name => 'SuperAdmin', :email => "adam@summers.com.tw", :password => "23219217"
superadmin = Admin.find(1)
superadmin.add_role :superadmin

Admin.create :name => 'Admin', :email => "t0@summers.com.tw", :password => "23219217"
admin = Admin.find(2)
admin.add_role :admin

Admin.create :name => 'Moderator', :email => "t1@summers.com.tw", :password => "23219217"
moderator = Admin.find(3)
moderator.add_role :moderator

# 最高管理員
# adam@summers.com.tw 23219217
# 次高管理員
# t0@summers.com.tw  23219217
# 一般管理員
# t1@summers.com.tw  23219217

Job.create({name: '104', websiteurl: 'http://www.104.com.tw/'})
Job.create({name: '1111', websiteurl: 'http://www.1111.com.tw/'})
Job.create({name: '518', websiteurl: 'http://www.518.com.tw/'})
Job.create({name: 'yes123', websiteurl: 'https://www.yes123.com.tw/admin/index.asp'})

ProductCate.create({parent_id: 0, name: '分類列表', depth: 0})

#運送方式
Delivery.create({name: '本島貨到付款', tracking_url: 'http://postserv.post.gov.tw/webpost/CSController?cmd=POS4001_1&_SYS_ID=D&_MENU_ID=189&_ACTIVE_ID=190', normal_fee: 190, shipping_condition: 'taiwan', iscod: 'yes', discount_criteria: 1500 ,discount_fee: 30})
Delivery.create({name: '離島貨到付款', tracking_url: 'http://postserv.post.gov.tw/webpost/CSController?cmd=POS4001_1&_SYS_ID=D&_MENU_ID=189&_ACTIVE_ID=190', normal_fee: 190, shipping_condition: 'island', iscod: 'yes', discount_criteria: 1500 ,discount_fee: 30})
Delivery.create({name: '本島宅配', tracking_url: 'http://www.t-cat.com.tw/inquire/trace.aspx', normal_fee: 80, shipping_condition: 'taiwan', iscod: 'no', discount_criteria: 1500 ,discount_fee: 0})
Delivery.create({name: '離島郵局', tracking_url: 'http://postserv.post.gov.tw/webpost/CSController?cmd=POS4001_1&_SYS_ID=D&_MENU_ID=189&_ACTIVE_ID=190', normal_fee: 100, shipping_condition: 'island', iscod: 'no', discount_criteria: 1500 ,discount_fee: 0})

Country.create :name => "台灣"
taiwan_id = Country.find_by(name: "台灣").id
City.create([{name: '台北市', country_id: taiwan_id }, {name: '新北市', country_id: taiwan_id}, {name: '基隆市', country_id: taiwan_id}, {name: '桃園縣', country_id: taiwan_id}, {name: '新竹縣', country_id: taiwan_id}, {name: '新竹市', country_id: taiwan_id}, {name: '苗栗縣', country_id: taiwan_id}, {name: '台中市', country_id: taiwan_id}, {name: '彰化縣', country_id: taiwan_id}, {name: '南投縣', country_id: taiwan_id}, {name: '雲林縣', country_id: taiwan_id}, {name: '嘉義縣', country_id: taiwan_id}, {name: '嘉義市', country_id: taiwan_id}, {name: '台南市', country_id: taiwan_id}, {name: '高雄市', country_id: taiwan_id}, {name: '屏東縣', country_id: taiwan_id}, {name: '宜蘭縣', country_id: taiwan_id}, {name: '花蓮縣', country_id: taiwan_id}, {name: '台東縣', country_id: taiwan_id}, {name: '澎湖縣', country_id: taiwan_id}, {name: '金門縣', country_id: taiwan_id}, {name: '連江縣', country_id: taiwan_id}])

taipei_id = City.find_by(name: "台北市").id
District.create([
  {name: '中正區', city_id: taipei_id }, {name: '大同區', city_id: taipei_id}, {name: '中山區', city_id: taipei_id}, {name: '萬華區', city_id: taipei_id}, {name: '信義區', city_id: taipei_id}, {name: '松山區', city_id: taipei_id}, {name: '大安區', city_id: taipei_id}, {name: '南港區', city_id: taipei_id}, {name: '北投區', city_id: taipei_id}, {name: '內湖區', city_id: taipei_id}, {name: '士林區', city_id: taipei_id}, {name: '文山區', city_id: taipei_id}])

newtaipei_id = City.find_by(name: "新北市").id
District.create([{name: '板橋區', city_id: newtaipei_id }  , {name: '新莊區', city_id: newtaipei_id}, {name: '泰山區', city_id: newtaipei_id}, {name: '林口區', city_id: newtaipei_id}, {name: '淡水區', city_id: newtaipei_id}, {name: '金山區', city_id: newtaipei_id}, {name: '八里區', city_id: newtaipei_id}, {name: '萬里區', city_id: newtaipei_id}, {name: '石門區', city_id: newtaipei_id}, {name: '三芝區', city_id: newtaipei_id}, {name: '瑞芳區', city_id: newtaipei_id}, {name: '汐止區', city_id: newtaipei_id}, {name: '平溪區', city_id: newtaipei_id}, {name: '貢寮區', city_id: newtaipei_id}, {name: '雙溪區', city_id: newtaipei_id}, {name: '深坑區', city_id: newtaipei_id}, {name: '石碇區', city_id: newtaipei_id}, {name: '新店區', city_id: newtaipei_id}, {name: '坪林區', city_id: newtaipei_id}, {name: '烏來區', city_id: newtaipei_id}, {name: '中和區', city_id: newtaipei_id}, {name: '永和區', city_id: newtaipei_id}, {name: '土城區', city_id: newtaipei_id}, {name: '三峽區', city_id: newtaipei_id}, {name: '樹林區', city_id: newtaipei_id}, {name: '鶯歌區', city_id: newtaipei_id}, {name: '三重區', city_id: newtaipei_id}, {name: '蘆洲區', city_id: newtaipei_id}, {name: '五股區', city_id: newtaipei_id}])

tc_id = City.find_by(name: "台中市").id
District.create([{name: '中區', city_id: tc_id }, {name: '東區', city_id: tc_id}, {name: '南區', city_id: tc_id}, {name: '西區', city_id: tc_id}, {name: '北區', city_id: tc_id}, {name: '北屯區', city_id: tc_id}, {name: '西屯區', city_id: tc_id}, {name: '南屯區', city_id: tc_id}, {name: '太平區', city_id: tc_id}, {name: '大里區', city_id: tc_id}, {name: '霧峰區', city_id: tc_id}, {name: '烏日區', city_id: tc_id}, {name: '豐原區', city_id: tc_id}, {name: '后里區', city_id: tc_id}, {name: '東勢區', city_id: tc_id}, {name: '石岡區', city_id: tc_id}, {name: '新社區', city_id: tc_id}, {name: '和平區', city_id: tc_id}, {name: '神岡區', city_id: tc_id}, {name: '潭子區', city_id: tc_id}, {name: '大雅區', city_id: tc_id}, {name: '大肚區', city_id: tc_id}, {name: '龍井區', city_id: tc_id}, {name: '沙鹿區', city_id: tc_id}, {name: '梧棲區', city_id: tc_id}, {name: '清水區', city_id: tc_id}, {name: '大甲區', city_id: tc_id}, {name: '外埔區', city_id: tc_id}, {name: '大安區', city_id: tc_id}])

tn_id = City.find_by(name: "台南市").id
District.create([{name: '中西區', city_id: tn_id }, {name: '東區', city_id: tn_id}, {name: '南區', city_id: tn_id}, {name: '北區', city_id: tn_id}, {name: '安平區', city_id: tn_id}, {name: '安南區', city_id: tn_id}, {name: '永康區', city_id: tn_id}, {name: '歸仁區', city_id: tn_id}, {name: '新化區', city_id: tn_id}, {name: '左鎮區', city_id: tn_id}, {name: '玉井區', city_id: tn_id}, {name: '楠西區', city_id: tn_id}, {name: '南化區', city_id: tn_id}, {name: '仁德區', city_id: tn_id}, {name: '關廟區', city_id: tn_id}, {name: '龍崎區', city_id: tn_id}, {name: '官田區', city_id: tn_id}, {name: '麻豆區', city_id: tn_id}, {name: '佳里區', city_id: tn_id}, {name: '西港區', city_id: tn_id}, {name: '七股區', city_id: tn_id}, {name: '將軍區', city_id: tn_id}, {name: '學甲區', city_id: tn_id}, {name: '北門區', city_id: tn_id}, {name: '新營區', city_id: tn_id}, {name: '後壁區', city_id: tn_id}, {name: '白河區', city_id: tn_id}, {name: '東山區', city_id: tn_id}, {name: '六甲區', city_id: tn_id}, {name: '下營區', city_id: tn_id}, {name: '柳營區', city_id: tn_id}, {name: '鹽水區', city_id: tn_id}, {name: '善化區', city_id: tn_id}, {name: '大內區', city_id: tn_id}, {name: '山上區', city_id: tn_id}, {name: '新市區', city_id: tn_id}, {name: '安定區', city_id: tn_id}])

kao_id = City.find_by(name: "高雄市").id
District.create([{name: '楠梓區', city_id: kao_id }, {name: '左營區', city_id: kao_id}, {name: '鼓山區', city_id: kao_id}, {name: '三民區', city_id: kao_id}, {name: '鹽埕區', city_id: kao_id}, {name: '前金區', city_id: kao_id}, {name: '新興區', city_id: kao_id}, {name: '苓雅區', city_id: kao_id}, {name: '前鎮區', city_id: kao_id}, {name: '小港區', city_id: kao_id}, {name: '旗津區', city_id: kao_id}, {name: '鳳山區', city_id: kao_id}, {name: '大寮區', city_id: kao_id}, {name: '鳥松區', city_id: kao_id}, {name: '林園區', city_id: kao_id}, {name: '仁武區', city_id: kao_id}, {name: '大樹區', city_id: kao_id}, {name: '大社區', city_id: kao_id}, {name: '岡山區', city_id: kao_id}, {name: '路竹區', city_id: kao_id}, {name: '橋頭區', city_id: kao_id}, {name: '梓官區', city_id: kao_id}, {name: '彌陀區', city_id: kao_id}, {name: '永安區', city_id: kao_id}, {name: '燕巢區', city_id: kao_id}, {name: '田寮區', city_id: kao_id}, {name: '阿蓮區', city_id: kao_id}, {name: '茄萣區', city_id: kao_id}, {name: '湖內區', city_id: kao_id}, {name: '旗山區', city_id: kao_id}, {name: '美濃區', city_id: kao_id}, {name: '內門區', city_id: kao_id}, {name: '杉林區', city_id: kao_id}, {name: '甲仙區', city_id: kao_id}, {name: '六龜區', city_id: kao_id}, {name: '茂林區', city_id: kao_id}, {name: '桃源區', city_id: kao_id}, {name: '那瑪夏區', city_id: kao_id}])

tao_id = City.find_by(name: "桃園縣").id
District.create([{name: '桃園市', city_id: tao_id }, {name: '中壢市', city_id: tao_id}, {name: '平鎮市', city_id: tao_id}, {name: '八德市', city_id: tao_id}, {name: '楊梅市', city_id: tao_id}, {name: '蘆竹市', city_id: tao_id}, {name: '大溪鎮', city_id: tao_id}, {name: '苓雅區', city_id: tao_id}, {name: '前鎮區', city_id: tao_id}, {name: '小港區', city_id: tao_id}, {name: '龍潭鄉', city_id: tao_id}, {name: '龜山鄉', city_id: tao_id}, {name: '大園鄉', city_id: tao_id}, {name: '觀音鄉', city_id: tao_id}, {name: '新屋鄉', city_id: tao_id}, {name: '復興鄉', city_id: tao_id}])

hc_id = City.find_by(name: "新竹縣").id
District.create([{name: '竹北市', city_id: hc_id }, {name: '竹東鎮', city_id: hc_id}, {name: '新埔鎮', city_id: hc_id}, {name: '關西鎮', city_id: hc_id}, {name: '峨眉鄉', city_id: hc_id}, {name: '寶山鄉', city_id: hc_id}, {name: '北埔鄉', city_id: hc_id}, {name: '橫山鄉', city_id: hc_id}, {name: '芎林鄉', city_id: hc_id}, {name: '湖口鄉', city_id: hc_id}, {name: '新豐鄉', city_id: hc_id}, {name: '尖石鄉', city_id: hc_id}, {name: '五峰鄉', city_id: hc_id}])

ml_id = City.find_by(name: "苗栗縣").id
District.create([{name: '苗栗市', city_id: ml_id }, {name: '通霄鎮', city_id: ml_id}, {name: '苑裡鎮', city_id: ml_id}, {name: '竹南鎮', city_id: ml_id}, {name: '頭份鎮', city_id: ml_id}, {name: '後龍鎮', city_id: ml_id}, {name: '卓蘭鎮', city_id: ml_id}, {name: '西湖鄉', city_id: ml_id}, {name: '頭屋鄉', city_id: ml_id}, {name: '公館鄉', city_id: ml_id}, {name: '銅鑼鄉', city_id: ml_id}, {name: '三義鄉', city_id: ml_id}, {name: '造橋鄉', city_id: ml_id}, {name: '三灣鄉', city_id: ml_id}, {name: '南庄鄉', city_id: ml_id}, {name: '大湖鄉', city_id: ml_id}, {name: '獅潭鄉', city_id: ml_id}, {name: '泰安鄉', city_id: ml_id}])

cha_id = City.find_by(name: "彰化縣").id
District.create([{name: '彰化縣', city_id: cha_id }, {name: '員林鎮', city_id: cha_id}, {name: '和美鎮', city_id: cha_id}, {name: '鹿港鎮', city_id: cha_id}, {name: '溪湖鎮', city_id: cha_id}, {name: '二林鎮', city_id: cha_id}, {name: '田中鎮', city_id: cha_id}, {name: '北斗鎮', city_id: cha_id}, {name: '花壇鄉', city_id: cha_id}, {name: '芬園鄉', city_id: cha_id}, {name: '大村鄉', city_id: cha_id}, {name: '永靖鄉', city_id: cha_id}, {name: '伸港鄉', city_id: cha_id}, {name: '線西鄉', city_id: cha_id}, {name: '福興鄉', city_id: cha_id}, {name: '秀水鄉', city_id: cha_id}, {name: '埔心鄉', city_id: cha_id}, {name: '埔鹽鄉', city_id: cha_id}, {name: '大城鄉', city_id: cha_id}, {name: '芳苑鄉', city_id: cha_id}, {name: '竹塘鄉', city_id: cha_id}, {name: '社頭鄉', city_id: cha_id}, {name: '二水鄉', city_id: cha_id}, {name: '田尾鄉', city_id: cha_id}, {name: '埤頭鄉', city_id: cha_id}, {name: '溪州鄉', city_id: cha_id}])

nat_id = City.find_by(name: "南投縣").id
District.create([{name: '南投市', city_id: nat_id }, {name: '埔里鎮', city_id: nat_id}, {name: '草屯鎮', city_id: nat_id}, {name: '竹山鎮', city_id: nat_id}, {name: '集集鎮', city_id: nat_id}, {name: '名間鄉', city_id: nat_id}, {name: '鹿谷鄉', city_id: nat_id}, {name: '中寮鄉', city_id: nat_id}, {name: '魚池鄉', city_id: nat_id}, {name: '國姓鄉', city_id: nat_id}, {name: '水里鄉', city_id: nat_id}, {name: '信義鄉', city_id: nat_id}, {name: '仁愛鄉', city_id: nat_id}])

yun_id = City.find_by(name: "雲林縣").id
District.create([{name: '斗六市', city_id: yun_id }, {name: '斗南鎮', city_id: yun_id}, {name: '虎尾鎮', city_id: yun_id}, {name: '西螺鎮', city_id: yun_id}, {name: '土庫鎮', city_id: yun_id}, {name: '北港鎮', city_id: yun_id}, {name: '莿桐鄉', city_id: yun_id}, {name: '林內鄉', city_id: yun_id}, {name: '古坑鄉', city_id: yun_id}, {name: '大埤鄉', city_id: yun_id}, {name: '崙背鄉', city_id: yun_id}, {name: '二崙鄉', city_id: yun_id}, {name: '麥寮鄉', city_id: yun_id}, {name: '臺西鄉', city_id: yun_id}, {name: '東勢鄉', city_id: yun_id}, {name: '褒忠鄉', city_id: yun_id}, {name: '四湖鄉', city_id: yun_id}, {name: '口湖鄉', city_id: yun_id}, {name: '水林鄉', city_id: yun_id}, {name: '元長鄉', city_id: yun_id}])

chi_id = City.find_by(name: "嘉義縣").id
District.create([{name: '太保市', city_id: chi_id }, {name: '朴子市', city_id: chi_id}, {name: '布袋鎮', city_id: chi_id}, {name: '大林鎮', city_id: chi_id}, {name: '民雄鄉', city_id: chi_id}, {name: '溪口鄉', city_id: chi_id}, {name: '新港鄉', city_id: chi_id}, {name: '六腳鄉', city_id: chi_id}, {name: '東石鄉', city_id: chi_id}, {name: '義竹鄉', city_id: chi_id}, {name: '鹿草鄉', city_id: chi_id}, {name: '水上鄉', city_id: chi_id}, {name: '中埔鄉', city_id: chi_id}, {name: '竹崎鄉', city_id: chi_id}, {name: '梅山鄉', city_id: chi_id}, {name: '番路鄉', city_id: chi_id}, {name: '大埔鄉', city_id: chi_id}, {name: '阿里山鄉', city_id: chi_id}])

pin_id = City.find_by(name: "屏東縣").id
District.create([{name: '屏東市', city_id: pin_id }, {name: '潮州鎮', city_id: pin_id}, {name: '東港鎮', city_id: pin_id}, {name: '恆春鎮', city_id: pin_id}, {name: '萬丹鄉', city_id: pin_id}, {name: '長治鄉', city_id: pin_id}, {name: '麟洛鄉', city_id: pin_id}, {name: '九如鄉', city_id: pin_id}, {name: '里港鄉', city_id: pin_id}, {name: '鹽埔鄉', city_id: pin_id}, {name: '高樹鄉', city_id: pin_id}, {name: '萬巒鄉', city_id: pin_id}, {name: '內埔鄉', city_id: pin_id}, {name: '竹田鄉', city_id: pin_id}, {name: '新埤鄉', city_id: pin_id}, {name: '枋寮鄉', city_id: pin_id}, {name: '新園鄉', city_id: pin_id}, {name: '崁頂鄉', city_id: pin_id}, {name: '林邊鄉', city_id: pin_id}, {name: '南州鄉', city_id: pin_id}, {name: '佳冬鄉', city_id: pin_id}, {name: '琉球鄉', city_id: pin_id}, {name: '車城鄉', city_id: pin_id}, {name: '滿州鄉', city_id: pin_id}, {name: '枋山鄉', city_id: pin_id}, {name: '霧台鄉', city_id: pin_id}, {name: '瑪家鄉', city_id: pin_id}, {name: '泰武鄉', city_id: pin_id}, {name: '來義鄉', city_id: pin_id}, {name: '春日鄉', city_id: pin_id}, {name: '獅子鄉', city_id: pin_id}, {name: '牡丹鄉', city_id: pin_id}, {name: '三地門鄉', city_id: pin_id}])

yil_id = City.find_by(name: "宜蘭縣").id
District.create([{name: '宜蘭市', city_id: yil_id }, {name: '羅東鎮', city_id: yil_id}, {name: '蘇澳鎮', city_id: yil_id}, {name: '頭城鎮', city_id: yil_id}, {name: '礁溪鄉', city_id: yil_id}, {name: '壯圍鄉', city_id: yil_id}, {name: '員山鄉', city_id: yil_id}, {name: '冬山鄉', city_id: yil_id}, {name: '五結鄉', city_id: yil_id}, {name: '三星鄉', city_id: yil_id}, {name: '大同鄉', city_id: yil_id}, {name: '南澳鄉', city_id: yil_id}])

hua_id = City.find_by(name: "花蓮縣").id
District.create([{name: '花蓮市', city_id: hua_id }, {name: '鳳林鎮', city_id: hua_id}, {name: '玉里鎮', city_id: hua_id}, {name: '新城鄉', city_id: hua_id}, {name: '吉安鄉', city_id: hua_id}, {name: '壽豐鄉', city_id: hua_id}, {name: '秀林鄉', city_id: hua_id}, {name: '光復鄉', city_id: hua_id}, {name: '豐濱鄉', city_id: hua_id}, {name: '瑞穗鄉', city_id: hua_id}, {name: '萬榮鄉', city_id: hua_id}, {name: '富里鄉', city_id: hua_id}, {name: '卓溪鄉', city_id: hua_id}])

tt_id = City.find_by(name: "台東縣").id
District.create([{name: '台東市', city_id: tt_id }, {name: '成功鎮', city_id: tt_id}, {name: '關山鎮', city_id: tt_id}, {name: '長濱鄉', city_id: tt_id}, {name: '海端鄉', city_id: tt_id}, {name: '池上鄉', city_id: tt_id}, {name: '東河鄉', city_id: tt_id}, {name: '鹿野鄉', city_id: tt_id}, {name: '延平鄉', city_id: tt_id}, {name: '卑南鄉', city_id: tt_id}, {name: '金峰鄉', city_id: tt_id}, {name: '大武鄉', city_id: tt_id}, {name: '達仁鄉', city_id: tt_id}, {name: '綠島鄉', city_id: tt_id}, {name: '蘭嶼鄉', city_id: tt_id}, {name: '太麻里鄉', city_id: tt_id}])

ph_id = City.find_by(name: "澎湖縣").id
District.create([{name: '馬公市', city_id: ph_id }, {name: '湖西鄉', city_id: ph_id}, {name: '白沙鄉', city_id: ph_id}, {name: '西嶼鄉', city_id: ph_id}, {name: '望安鄉', city_id: ph_id}, {name: '七美鄉', city_id: ph_id}])

kin_id = City.find_by(name: "金門縣").id
District.create([{name: '金城鎮', city_id: kin_id }, {name: '金湖鎮', city_id: kin_id}, {name: '金沙鎮', city_id: kin_id}, {name: '金寧鄉', city_id: kin_id}, {name: '烈嶼鄉', city_id: kin_id}, {name: '烏坵鄉', city_id: kin_id}])

lie_id = City.find_by(name: "連江縣").id
District.create([{name: '南竿鄉', city_id: lie_id }, {name: '北竿鄉', city_id: lie_id}, {name: '莒光鄉', city_id: lie_id}, {name: '東引鄉', city_id: lie_id}])

kee_id = City.find_by(name: "基隆市").id
District.create([{name: '仁愛區', city_id: kee_id }, {name: '中正區', city_id: kee_id}, {name: '信義區', city_id: kee_id}, {name: '中山區', city_id: kee_id}, {name: '安樂區', city_id: kee_id}, {name: '暖暖區', city_id: kee_id}, {name: '七堵區', city_id: kee_id}])

hsi_id = City.find_by(name: "新竹市").id
District.create([{name: '東區', city_id: hsi_id }, {name: '北區', city_id: hsi_id}, {name: '香山區', city_id: hsi_id}])

chiayi_id = City.find_by(name: "嘉義市").id
District.create([{name: '東區', city_id: chiayi_id }, {name: '西區', city_id: chiayi_id}])

# ＤＥＶ 以上都建過