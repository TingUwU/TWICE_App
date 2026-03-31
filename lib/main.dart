import 'package:flutter/material.dart';

void main() {
  runApp(const TwiceApp());
}

// ==========================================
// 1. App 進入點
// ==========================================
class TwiceApp extends StatelessWidget {
  const TwiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TWICE App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5FA2)),
        useMaterial3: true,
      ),
      home: const SplashScreen(), 
    );
  }
}

// ==========================================
// 2. 進場動畫頁 (Splash Screen)
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF5FA2), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text('TWICE App Loading...', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. 首頁 (HomePage)
// ==========================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_bg.jpg'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'TWICE',
                      style: TextStyle(
                        fontSize: 56, 
                        fontWeight: FontWeight.bold, 
                        letterSpacing: 4.0,
                        color: Colors.white, 
                        shadows: [Shadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(width: 150, height: 2, color: Colors.white), 
                    const SizedBox(height: 30), // 縮短標題與選單間距
                    
                    const MenuTextButton(title: 'Artist', targetPage: ArtistsPage()),
                    const MenuTextButton(title: 'Recommenedation', targetPage: RecommendationPage()),
                    const MenuTextButton(title: 'News', targetPage: NewsPage()),
                    // const MenuTextButton(title: 'Release', targetPage: ReleasePage()),
                    // const MenuTextButton(title: 'Entertainment', targetPage: EntertainmentPage()),
                    
                    const SizedBox(height: 80), // 將整體視覺重心上移
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.play_circle_outline, size: 30, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 首頁專用：文字選單按鈕 (緊湊版) ---
class MenuTextButton extends StatelessWidget {
  final String title;
  final Widget targetPage;

  const MenuTextButton({super.key, required this.title, required this.targetPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // 縮小按鈕間距
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => targetPage));
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.w500,
              color: Colors.white, 
              shadows: [Shadow(color: Colors.black54, offset: Offset(1, 1), blurRadius: 2)],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. 共用側邊選單 (Shared Drawer)
// ==========================================
class SharedDrawer extends StatelessWidget {
  const SharedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFFF5FA2)),
            child: Text('TWICE Menu', style: TextStyle(color: Colors.white, fontSize: 32)),
          ),
          ListTile(
            leading: const Icon(Icons.home), title: const Text('HomePage'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())),
          ),
          ListTile(
            leading: const Icon(Icons.person), title: const Text('Artist'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ArtistsPage())),
          ),
          
          ListTile(
            leading: const Icon(Icons.article), title: const Text('Recommendations'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RecommendationPage())),
          ),
          ListTile(
            leading: const Icon(Icons.article), title: const Text('News'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NewsPage())),
          ),
          /*
          ListTile(
            leading: const Icon(Icons.album), title: const Text('Release'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReleasePage())),
          ),
          ListTile(
            leading: const Icon(Icons.tv), title: const Text('Entertainment'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EntertainmentPage())),
          ),
          */
        ],
      ),
    );
  }
}

// ==========================================
// 5. 成員列表頁 (Artists)
// ==========================================
class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> members = [
      {
        'name': '娜璉', 'fullName': '林娜璉 (Im Na-yeon)', 'birthday': '1995年9月22日', 'position': '領唱、領舞、中心 (Center)',
        'nickname': '兔牙、林三歲、偽忙內', 'mbti': 'ISTP',
        'color': const Color(0xFF55B3FA), 'image': 'Na.jpg',
        'contents': [
          {'type': 'text', 'data': 'TWICE 的大姊與永遠的 Center。擁有被稱為「果汁相」的清爽笑容與標誌性的兔寶寶牙，在舞台上總是充滿活力。'},
          {'type': 'image', 'data': 'assets/Na_1.jpg'}, 
          {'type': 'text', 'data': '不僅擁有穩定的唱功，舞蹈實力也非常出色，是團隊中負責帶動氣氛與定調歌曲風格的核心人物。Solo 出道曲〈POP!〉也大獲成功。'},
        ]
      },
      {
        'name': '定延', 'fullName': '俞定延 (Yoo Jeong-yeon)', 'birthday': '1996年11月1日', 'position': '領唱',
        'nickname': '鴕鳥、俞大叔、TWICE的媽媽', 'mbti': 'ISFJ',
        'color': const Color(0xFFC5D97A), 'image': 'Jeong.jpg',
        'contents': [
          {'type': 'text', 'data': '擁有獨特的 Girl Crush 魅力與高挑的模特兒身材。雖然外表看起來酷帥，但私底下非常溫暖、細心，常在背後默默照顧成員。'},
          {'type': 'image', 'data': 'assets/Jeong_1.jpg'},
          {'type': 'text', 'data': '她是 TWICE 的「媽媽」，負責打理宿舍大小事。擁有非常有辨識度且具穿透力的實力派清亮嗓音，是歌曲中極具穩定感的基石。'},
        ]
      },
      {
        'name': '桃', 'fullName': '平井桃 (Hirai Momo)', 'birthday': '1996年11月9日', 'position': '主舞、副唱、副Rapper',
        'nickname': '桃子、Moguri、傻桃', 'mbti': 'INFP',
        'color': const Color(0xFFFF8DA1), 'image': 'Mo.jpg',
        'contents': [
          {'type': 'text', 'data': 'K-pop 界公認的頂級舞者之一，擁有「Dancing Machine」的稱號。只要一站上舞台就會展現極具爆發力的舞蹈線條與克里斯馬。'},
          {'type': 'image', 'data': 'assets/Mo_1.jpg'},
          {'type': 'text', 'data': '但下了舞台卻是個說話帶著可愛鼻音、有點呆萌的超級吃貨。性格單純善良，是隊內的氣氛調和劑與團寵。'},
        ]
      },
      {
        'name': '紗夏', 'fullName': '湊崎紗夏 (Minatozaki Sana)', 'birthday': '1996年12月29日', 'position': '副唱',
        'nickname': '柴犬、傻娜、釣系女王', 'mbti': 'ENFP',
        'color': const Color(0xFF9B7CDB), 'image': 'Sa.jpg',
        'contents': [
          {'type': 'text', 'data': '「No Sana No Life！」以〈Cheer Up〉中的「Shy Shy Shy」一句歌詞融化全韓國。天生自帶超強撒嬌功力與極致的可愛魅力。'},
          {'type': 'image', 'data': 'assets/Sa_1.jpg'},
          {'type': 'text', 'data': '但在舞台上又能瞬間切換成致命的性感風格，是團隊中隨時隨地都在散發魅力的超級發電機。韓語實力極佳，甚至被認證為「金紗夏」。'},
        ]
      },
      {
        'name': '志效', 'fullName': '朴志效 (Park Ji-hyo)', 'birthday': '1997年2月1日', 'position': '隊長、主唱',
        'nickname': '小火車、God志效、麥克風', 'mbti': 'ISFP',
        'color': const Color(0xFFFFC56E), 'image': 'Ji.jpg',
        'contents': [
          {'type': 'text', 'data': '經歷長達 10 年練習生生涯的可靠隊長。擁有如同擴音器般宏亮且充滿爆發力的主唱嗓音，是 TWICE 歌曲的高音擔當。'},
          {'type': 'image', 'data': 'assets/Ji_1.jpg'},
          {'type': 'text', 'data': '在舞台上的表現力極佳，永遠充滿電量與熱情，每一次表演都像在開麥克風測試，敬業精神與領導力讓粉絲愛稱為「God 志效」。'},
        ]
      },
      {
        'name': '南', 'fullName': '名井南 (Myoui Mina)', 'birthday': '1997年3月24日', 'position': '主舞、副唱',
        'nickname': '企鵝、黑天鵝、井南', 'mbti': 'ISTP',
        'color': const Color(0xFF67D5B5), 'image': 'Mi.jpg',
        'contents': [
          {'type': 'text', 'data': '學習芭蕾長達 11 年，舉手投足間都散發著優雅的貴族千金氣質，被稱為 TWICE 的「黑天鵝」。'},
          {'type': 'image', 'data': 'assets/Mi_1.jpg'},
          {'type': 'text', 'data': '音色非常獨特，柔和且充滿空氣感的嗓音是 TWICE 歌曲中不可或缺的橋段殺手。私底下是個熱愛宅在宿舍打遊戲與組裝樂高的玩家。'},
        ]
      },
      {
        'name': '多賢', 'fullName': '金多賢 (Kim Da-hyun)', 'birthday': '1998年5月28日', 'position': '領Rapper、副唱',
        'nickname': '豆腐、找鏡頭達人、老鷹', 'mbti': 'ISFJ',
        'color': const Color(0xFFE2E2E2), 'image': 'Da.jpg',
        'contents': [
          {'type': 'text', 'data': '因為皮膚極度白皙軟嫩而被暱稱為「豆腐」。擁有超強的綜藝感與極佳的親和力，更是尋找攝影機的雷達天才，無論鏡頭在哪都能精準對視。'},
          {'type': 'image', 'data': 'assets/Da_1.jpg'},
          {'type': 'text', 'data': '在隊內不僅負責 Rapper，也擁有極佳的作詞與彈鋼琴能力，是帶給粉絲無限歡樂的維他命與綜藝擔當。'},
        ]
      },
      {
        'name': '彩瑛', 'fullName': '孫彩瑛 (Son Chae-young)', 'birthday': '1999年4月23日', 'position': '主Rapper、副唱',
        'nickname': '小猛獸、草莓公主、無趣弟', 'mbti': 'INFP',
        'color': const Color(0xFFFF4353), 'image': 'Chae.jpg',
        'contents': [
          {'type': 'text', 'data': 'TWICE 中的「小猛獸」與充滿自由靈魂的藝術家。擁有出色的 Rap 實力，並且熱愛畫畫、設計與作詞。'},
          {'type': 'image', 'data': 'assets/Chae_1.jpg'},
          {'type': 'text', 'data': '不盲從流行，擁有自己獨特且強烈的時尚品味與世界觀，是個充滿個性、帶點叛逆卻又無比可愛的酷女孩。'},
        ]
      },
      {
        'name': '子瑜', 'fullName': '周子瑜 (Chou Tzu-yu)', 'birthday': '1999年6月14日', 'position': '領舞、副唱、門面、忙內',
        'nickname': '尤達、巧克力、Sally', 'mbti': 'ISFP',
        'color': const Color(0xFF0278CD), 'image': 'Tzu.jpg',
        'contents': [
          {'type': 'text', 'data': '來自台灣的驕傲，擁有震驚韓國網友的「母胎美人」頂級神顏。雖然是隊內年紀最小的忙內，但身高卻是全團最高。'},
          {'type': 'image', 'data': 'assets/Tzu_1.jpg'},
          {'type': 'text', 'data': '經常無意間展現出「團霸」的直率吐槽。性格安靜、善良，這幾年無論是唱功還是舞蹈都有了大幅進步，Solo 出道也展現了全新的成熟魅力。'},
        ]
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Artists', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const SharedDrawer(), 
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/artists_bg.jpg'), // 確保此圖片存在
            fit: BoxFit.cover, 
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, 
                      crossAxisSpacing: 15, 
                      mainAxisSpacing: 15, 
                      childAspectRatio: 0.85, 
                    ),
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemberDetailPage(memberData: member),
                              fullscreenDialog: true, // 由下往上的跳轉動畫
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'assets/${member['image']}',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    cacheWidth: 300, // 列表縮圖優化
                                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300, child: const Icon(Icons.image_not_supported)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(member['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 6. 成員詳細介紹頁 (Member Detail)
// ==========================================
class MemberDetailPage extends StatelessWidget {
  final Map<String, dynamic> memberData;

  const MemberDetailPage({super.key, required this.memberData});

  @override
  Widget build(BuildContext context) {
    final String shortName = memberData['name'];
    final String fullName = memberData['fullName'];
    final String birthday = memberData['birthday'];
    final String position = memberData['position'];
    final String nickname = memberData['nickname']; 
    final String mbti = memberData['mbti'];
    final List<dynamic> contents = memberData['contents']; 
    final String imagePath = 'assets/${memberData['image']}'; 
    final Color memberColor = memberData['color'];

    return Scaffold(
      backgroundColor: memberColor, 
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, size: 40, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Text(shortName, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2.0)),
                      const SizedBox(height: 20),
                      
                      // 大頭照區塊 (加入防呆與記憶體優化)
                      Hero(
                        tag: shortName, 
                        child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              imagePath, 
                              fit: BoxFit.cover, 
                              cacheWidth: 800, 
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade400,
                                  child: Center(child: Text('找不到圖片\n$imagePath', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white))),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95), 
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            Text(fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const Divider(height: 20, thickness: 1.5), 
                            
                            _buildInfoRow(Icons.cake, '生日', birthday),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.star, '擔當', position),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.face_retouching_natural, '暱稱', nickname),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.psychology, 'MBTI', mbti),
                            
                            const SizedBox(height: 24),
                            
                            const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.pinkAccent)),
                            const SizedBox(height: 12),
                            
                            // 介紹內容：支援圖文穿插與錯誤捕捉
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: contents.map<Widget>((block) {
                                if (block['type'] == 'text') {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: Text(block['data'], style: TextStyle(fontSize: 15, height: 1.8, color: Colors.grey.shade800)),
                                  );
                                } else if (block['type'] == 'image' || block['type'] == 'gif') {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        block['data'],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        cacheWidth: 800, 
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          height: 150, color: Colors.grey.shade300, 
                                          child: Center(child: Text('圖片載入失敗\n${block['data']}', textAlign: TextAlign.center)),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox(); 
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text('$title：', style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),
        Expanded(child: Text(content, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.3))),
      ],
    );
  }
}

// ==========================================
// 7. 新聞與公告頁 (News) - 台北演唱會更新版
// ==========================================
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🌟 準備 8 則真實與預想的重大新聞，台北演唱會置頂
    final List<Map<String, String>> newsList = [
      {
        'date': '2026.03.31',
        'title': '【快訊】ONCE 久等了！TWICE 宣布 2026 全球巡演加場，5月正式登陸台北小巨蛋',
        'content': '震撼全台 ONCE！JYP 娛樂今日無預警宣布，TWICE 最新世界巡演「READY TO BE - Special Addition」將於今年 5 月加開台北站。這將是 TWICE 睽違多年後再次來到台北小巨蛋開唱，預計將連開兩場。門票預計於下週六正式開搶，詳細售票資訊請鎖定官方公告！'
      },
      {
        'date': '2024.09.06',
        'title': '周子瑜 Solo 出道！首張迷你專輯《abouTZU》正式發行',
        'content': 'TWICE 成員周子瑜正式以個人身份出道！首張迷你專輯《abouTZU》主打歌〈Run Away〉展現了與以往不同的成熟性感魅力。子瑜是繼娜璉、志效之後，第三位進行 Solo 活動的 TWICE 成員，MV 首播即創下驚人觀看數！'
      },
      {
        'date': '2024.06.14',
        'title': '娜璉夏日女王回歸！迷你二輯《NA》大受好評',
        'content': 'TWICE 大姊娜璉帶著第二張個人迷你專輯《NA》強勢回歸！主打歌〈ABCD〉融合了 2000 年代初期的流行風格，不僅展現了娜璉出色的唱跳實力，更在各大音樂節目中拿下多個一位。'
      },
      {
        'date': '2024.05.15',
        'title': '多賢正式進軍影視圈！確認出演韓版《那些年》女主角',
        'content': '超大驚喜！多賢確認出演韓國翻拍版電影《那些年，我們一起追的女孩》的女主角。這不僅是多賢首度挑戰大銀幕，也是 TWICE 中首位以演員身分正式出道的成員。'
      },
      {
        'date': '2024.03.04',
        'title': 'TWICE 創下新歷史！《With YOU-th》空降 Billboard 200 冠軍',
        'content': '無可撼動的頂級女團！TWICE 第十三張迷你專輯《With YOU-th》成功登頂美國告示牌「Billboard 200」專輯榜冠軍！這是 K-POP 女團史上的傲人紀錄。'
      },
      {
        'date': '2024.02.23',
        'title': '回歸先行曲〈I GOT YOU〉發布，展現九人神仙友誼',
        'content': 'TWICE 發布了全英文先行曲〈I GOT YOU〉。這首歌曲深刻描繪了九位成員之間歷經風雨依然緊密相連的深厚情誼，畫面與旋律都讓粉絲感動不已。'
      },
      {
        'date': '2023.12.12',
        'title': '第五次世界巡演「READY TO BE」席捲全球體育場',
        'content': 'TWICE 第五次世界巡迴演唱會規模再創巔峰！在北美洲與日本的多個大型體育場締造全數售罄的紀錄，展現了無與倫比的全球票房號召力。'
      },
      {
        'date': '2023.07.26',
        'title': '日本小分隊 MISAMO 華麗出道！《Masterpiece》橫掃榜單',
        'content': '由 Mina、Sana、Momo 組成的小分隊「MISAMO」正式出道！首張迷你專輯展現了優雅與高貴的概念，主打歌〈Do not touch〉一發行便橫掃日本各大音樂排行榜。'
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: const Text('TWICE News', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: Colors.transparent, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const SharedDrawer(), 
      
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            colors: [Color(0xFFFF5FA2), Color(0xFFFCC89B)]
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.white.withOpacity(0.95), 
                
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    // 讓台北演唱會這條新聞預設展開，增加驚喜感
                    initiallyExpanded: index == 0,
                    iconColor: const Color(0xFFFF5FA2), 
                    collapsedIconColor: Colors.grey, 
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    
                    title: Text(
                      news['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16, 
                        height: 1.4,
                        // 如果是第一條新聞，標題顏色加深或加點粉色
                        color: index == 0 ? const Color(0xFFFF4353) : Colors.black87,
                      ),
                    ),
                    
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        news['date']!,
                        style: TextStyle(color: Colors.pink.shade300, fontWeight: FontWeight.w600),
                      ),
                    ),
                    
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Text(
                          news['content']!,
                          style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
/*
// ==========================================
// 8. 發行作品頁 (Release) - 加入 Tab 切換功能
// ==========================================
class ReleasePage extends StatelessWidget {
  const ReleasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Release', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent, 
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            indicatorColor: Colors.white, 
            labelColor: Colors.white, 
            unselectedLabelColor: Colors.white70, 
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            tabs: [Tab(text: 'Album'), Tab(text: 'Digital')],
          ),
        ),
        drawer: const SharedDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFFF5FA2), Color(0xFFFCC89B)]),
          ),
          child: SafeArea(
            child: TabBarView(
              children: [
                _buildGridView('專輯名稱', Icons.album),
                _buildGridView('數位單曲', Icons.music_note),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(String title, IconData icon) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.8,
      ),
      itemCount: 6, 
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 100, height: 100, color: Colors.grey.shade300, child: Icon(icon, size: 40)),
              const SizedBox(height: 10),
              Text('$title ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}

// ==========================================
// 9. 影音娛樂頁 (Entertainment)
// ==========================================
class EntertainmentPage extends StatelessWidget {
  const EntertainmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entertainment', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent, elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      drawer: const SharedDrawer(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFFF5FA2), Color(0xFFFCC89B)]),
        ),
        child: const Center(child: Text('影音娛樂內容...', style: TextStyle(fontSize: 24, color: Colors.white))),
      ),
    );
  }
}
*/
// ==========================================
// 7. 入坑影片推薦頁 (Recommendation Page)
// ==========================================
class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🌟 影片資料清單：包含標題、副標題與預覽圖路徑
    final List<Map<String, String>> videos = [
      {
        'title': 'TWICE’s Killing Voice，現場演出！ | dingo taiwan', 
        'subtitle': 'C🔥 TWICE 最精彩的現場演唱串燒 – ONCE 們千萬別錯過！🔥',
        'image': 'assets/Video_killing_voice.png' // 👈 記得在 assets 資料夾放入對應的大寫開頭圖片
      },
      {
        'title': 'TWICE 多賢綜藝感爆棚！ | Knowing Bros', 
        'subtitle': '綜藝神降臨！展現偶像包袱掉滿地的搞笑實力',
        'image': 'assets/Video_knowingbros.png' 
      },
      {
        'title': '子瑜射箭精華', 
        'subtitle': '偶像運動會的精靈神顏，連頭髮都在跳舞',
        'image': 'assets/Video_tzu.png' 
      },
      {
        'title': 'TWICE | MOMO那些PABO的瞬間 名場面合集', 
        'subtitle': '只會吃跟跳舞的桃子',
        'image': 'assets/Video_momo.png' 
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('入坑必看影片', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFF5FA2),
        foregroundColor: Colors.white,
      ),
      drawer: const SharedDrawer(), // 確保你有引入共用的側邊選單
      backgroundColor: Colors.pink.shade50, // 淡淡的粉色背景，增加質感
      
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4, // 卡片浮凸陰影
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                // 點擊卡片時跳出下方提示訊息
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('準備播放：${videos[index]['title']}')),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ====================
                  // 上半部：影片預覽圖區塊 (防彈裝甲版)
                  // ====================
                  Container(
                    height: 200, 
                    width: double.infinity,
                    // 使用 ClipRRect 確保圖片只有上方有圓角，完美貼合卡片形狀
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // 1. 底層：真實圖片 (加上防呆與縮圖機制)
                          Image.asset(
                            videos[index]['image']!,
                            fit: BoxFit.cover,
                            cacheWidth: 800, // 🌟 保護記憶體，避免 OOM 閃退
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade800,
                              child: Center(
                                child: Text(
                                  '找不到圖片\n${videos[index]['image']}', 
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          
                          // 2. 中間層：半透明黑底，讓白色的播放鍵在任何圖片上都很清楚
                          Container(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          
                          // 3. 最上層：大大的播放按鈕圖示
                          const Icon(Icons.play_circle_outline, color: Colors.white, size: 70),
                        ],
                      ),
                    ),
                  ),
                  
                  // ====================
                  // 下半部：影片文字資訊區塊
                  // ====================
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videos[index]['title']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          videos[index]['subtitle']!,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}