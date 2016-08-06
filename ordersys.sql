-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.26 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 ordersys 的数据库结构
DROP DATABASE IF EXISTS `ordersys`;
CREATE DATABASE IF NOT EXISTS `ordersys` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ordersys`;


-- 导出  表 ordersys.dishesinfo 结构
DROP TABLE IF EXISTS `dishesinfo`;
CREATE TABLE IF NOT EXISTS `dishesinfo` (
  `dishesId` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜品编号，主键，自动增长',
  `dishesName` varchar(32) NOT NULL COMMENT '菜品名称',
  `shelvesed` int(11) NOT NULL DEFAULT '1' COMMENT '菜品是否上架：0-下架，1-上架',
  `dishesDiscript` varchar(200) NOT NULL COMMENT '菜品的简单介绍',
  `dishesType` varchar(50) NOT NULL COMMENT '菜品分类',
  `dishesImg` varchar(100) NOT NULL DEFAULT 'userIcon.jpg' COMMENT '菜品图片文件名称',
  `dishesTxt` varchar(400) NOT NULL COMMENT '菜品详细介绍',
  `recommend` int(11) NOT NULL DEFAULT '0' COMMENT '是否推荐菜品：0-非推荐，1-推荐菜品',
  `dishesPrice` float NOT NULL COMMENT '菜品单价',
  PRIMARY KEY (`dishesId`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- 正在导出表  ordersys.dishesinfo 的数据：~25 rows (大约)
DELETE FROM `dishesinfo`;
/*!40000 ALTER TABLE `dishesinfo` DISABLE KEYS */;
INSERT INTO `dishesinfo` (`dishesId`, `dishesName`, `shelvesed`, `dishesDiscript`, `dishesType`, `dishesImg`, `dishesTxt`, `recommend`, `dishesPrice`) VALUES
	(1, '广州文昌鸡', 1, '肥嫩母鸡约1250克，鸡肝20件约100克，熟瘦火腿20件约40克，郊菜500克，上汤180克，精盐、味精、湿粉、绍酒、淡二汤、芡汤、麻油、熟猪油适量。', '主菜', '1.jpg', '将鸡宰净，放入微滚的二汤锅内，浸至刚熟。熟后取出晾凉，起肉去骨，斜切成“日”字形，共20片。将鸡肝洗净，用沸水浸没，加入精盐、八角，浸至刚熟，取出，切成“日”字形，共20片，盛在碗中。将火腿也切成与鸡肉一样大小的20片。将鸡肉、火腿、鸡肝相间，拼摆在长盘上，成鱼鳞形，每行鸡肉、火腿、鸡肝各7片（中间6片），分成3行，连同鸡的头、尾摆两端，翼分侧，成鸡形，放入蒸笼用小火蒸热，取出。烧镬下熟猪油、郊菜、精盐、二汤，炒至九成熟，取出，滤去水。再下熟猪油、郊菜，用芡汤、湿粉勾芡，排在鸡的两侧及行距间，成4行。烧镬下油，溅入绍酒，加上汤、味精、精盐，用湿粉勾芡，落麻油和熟猪油推匀，淋在面上便成。', 0, 88),
	(2, '麻皮乳猪', 1, '光乳猪约4000克/只，五香味料100克，烧猪糖水适量。', '主菜', '2.jpg', '将光乳猪从内腔劈开背脊骨，使乳猪成平板状，用五香味料涂匀猪内腔，约腌30分钟后上叉，用沸水往猪皮处淋硬猪身，用糖水将猪皮涂匀，放入挂炉内将猪内腔焙熟，然后在明炉上烧至猪皮起麻点，色泽大红色即可。', 1, 188),
	(3, '玉环瑶柱脯', 1, '瑶柱脯6粒（80头）、改好冬瓜6件约300克、上汤、炸蒜子、花生油、盐、葱条、姜片，绍酒、湿生粉、芝麻油、胡椒粉。', '主菜', '3.jpg', '将冬瓜去皮后切成环形，用水滚熟取出；瑶柱脯盛于碗中，加葱条、姜片、绍酒、炸蒜子和清水，使水浸过瑶柱脯，上笼蒸30分钟取出；酿入冬瓜环内，倒出原汁，蒸20分钟再取出，勺出原汁加入上汤、盐、麻油、胡椒粉、再湿粉打芡淋在面上。', 0, 88),
	(4, '油蒸羔蟹', 1, '羔蟹约800克/只，姜片、葱条、上汤、精盐、生油适量。', '主菜', '4.jpg', '先将羔蟹用刀由肚下斩至壳，取出两边后，取出蟹羔洗干净。将蟹盖边削去后斩成圆形。将蟹洗干净后斩出蟹钳用刀拍破。蟹身带爪切件后排放在梳壳里，滤干水分。用蟹盖盛着蟹羔放在面上，烧镬落油搪镬，落姜、葱条爆香，将蟹放在面上，溅上汤，落盐、花生油，加盖焗至蟹熟，收干水分至有香味，盛在碟里便成。', 1, 108),
	(5, '椰香咖喱蟹', 1, '肉蟹约800克/只，油咖喱酱150，椰浆200克，淡花奶250克，花生油、洋葱丝、青红椒丝、蒜茸、生粉、绍酒适量。', '主菜', '5.jpg', '将肉蟹宰洗干净，滤干水分，用生粉拌匀。将油咖喱酱、椰浆、淡花奶和匀。烧镬下油至六成热放下肉蟹过油至七成熟，取出去油，放下洋葱丝、青红椒丝、蒜茸爆至有香味，溅绍酒，落和匀的咖喱酱，转放在沙窝里放下肉蟹，煮至熟便成。', 0, 108),
	(6, '烧云腿鲈鱼球', 1, '云腿6件（4cmⅹ2cm）约15克、鲈鱼球6件（4cmⅹ8cm）约180克，葱花、鸡蛋', '主菜', '6.jpg', '先把云腿用糖腌制后，洗净、吸干水份，伴上鸡蛋粉炸至金黄色，切片放在碟边；把鲈鱼球切成日字形，原片加入盐拌匀猛火烧镬，加入生油、加热至120℃放入鲈鱼球泡8成熟后滤干油；在镬边放入少许汤加味料，将料头和鲈鱼球勾芡，加入麻油包尾油上碟。', 0, 98),
	(7, '麒麟蒸桂鱼', 1, '桂鱼750克，火腿40克（4cmⅹ2cm/件），冬菇75克，郊菜200克，笋花、生葱、姜件、猪油、精盐、味精、上汤、生粉、胡椒粉、绍酒适量。', '主菜', '7.jpg', '先将桂鱼宰净起肉去皮，切为断后再切为“日”字形件。再将火腿、冬菇、笋花均切为件，大小与桂鱼一样，各24件。再将桂鱼肉、冬菇肉、火腿片、笋花各1件顺序分3行排放在碟里，砌成麒麟形，把生葱、姜件分放在砌好的鱼上，加上猪油放在笼内蒸熟，取出，去原汁，去掉姜葱，将郊菜炒好分放在桂鱼旁边，烧镬落油，溅入绍酒，落上汤，用精盐、味精调味，用湿粉推芡，落胡椒粉、包尾油推匀，淋匀鱼便成。', 0, 118),
	(8, '牡丹鲜虾仁', 1, '大虾仁200克，蟹黄25克，葱榄、上汤、味精、精盐、绍酒、麻油、胡椒粉、湿蹄粉、生油适量。', '主菜', '8.jpg', '先将蟹黄用碗盛着，用沸水稍浸一下，滤干水分。用上汤、味精、精盐、麻油、胡椒粉、湿蹄粉调成碗芡，烧镬落油至5成热放下虾仁泡油至8成熟，放入蟹黄，即取出去油，落葱榄、虾仁、蟹黄溅绍酒，落碗芡炒匀，加包尾油上碟便成。', 0, 98),
	(9, '郊外鱼头', 1, '大鱼头1只约750克、郊菜200克、炸蒜肉75克、湿冬香菇25克、肉丝、姜丝、精盐、味精、白糖、蚝油、麻油、胡椒粉、老抽、绍酒、生粉、二汤、花生油。', '主菜', '9.jpg', '将鱼头去鳃后斩成两边洗净，用盐擦匀粘上干生粉。烧镬下油至七成热，放入鱼头浸炸，炸至鱼头轻浮，取出、去油，跟着下肉丝、姜丝、炸蒜肉、冬菇，溅入绍酒，加二汤、鱼头略焖，即转入炒锅里，下老抽，加盖，用慢火焖至焾，把胡椒粉撒在上面。将郊菜用二汤、精盐、油焯热，伴在鱼头边上、用湿粉勾芡，淋在面上便成。', 1, 98),
	(10, '白云上素', 1, '笋花、鲜草菇、发好冬菇各50克，发好竹笙30克，湿雪耳30克，发好榆耳20克，蘑菇20克，菜远100克', '主菜', '10.jpg', '将榆耳斜刀切片，改成日字心型，鲜草菇开边，发好雪耳用剪刀剖开小块，蘑菇、竹笙用二汤滚过，再用上汤滚透，用毛巾吸干水份，把菜远用汤鞭熟放在碟边，用以上材料起镬、加入蚝油爆炒香，勾芡放入碟中，把雪耳用上汤加味勾芡放入面。·', 0, 68),
	(11, '西施烩花肚', 1, '发好花肚150克、鲜虾仁25克、蛋白50克、碎瑶柱、火腿茸、姜汁酒、上汤750克、精盐、味精、白糖、花生油、麻油、胡椒粉、生粉、绍酒。', '主菜', '11.jpg', '花肚切成小件，用二汤、姜汁酒滚煨过。烧镬落油至五成热放下鲜虾仁过油至八成熟，取出滤去油分，溅落绍酒，落上汤、精盐、味精、白糖、花肚、麻油、胡椒粉，微滚后落虾仁，用湿粉推芡，落鸡蛋白推匀盛在窝里，撒上炸好碎瑶柱、火腿茸便成。', 0, 68),
	(12, '冬瓜陈皮鸭汤', 1, '冬瓜300克，炸好陈皮鸭半只（约350克），陈鸭汤350克，上汤400克', '汤水', '12.jpg', '先把冬瓜改成圆棋子型，用清水滚过，再用冷水漂透后，放入炖盅内；然后把煲好陈皮鸭放在面，用鸭汤、上汤加味调匀，加盖炖1.5小时取出。', 0, 88),
	(13, '红烧一品燕窝', 1, '发好燕盏约100克，顶上汤100克，火腿汁、盐、味精、绍酒、上汤、生粉、麻油、胡椒粉、老抽、花生油适量。', '汤水', '13.jpg', '干燕盏用清水浸泡4小时，捞出滤干水分，转载在炖盅里，落滚开水加盖焗30分钟取出，换清水2次，将燕头撕开，拣除燕毛和杂物，滤干水分。燕窝用小笊篱盛着，放在用精盐、味精调味的微滚上汤里淋透。滤干水分后，盛在汤碟里，烧镬下油，溅绍酒，落顶汤、火腿汁、味精、麻油、胡椒粉、老抽，微滚后用湿粉推芡淋在面上便成。', 0, 88),
	(14, '红烧金勾翅', 1, '扣好的金钩翅、顶汤、上汤、银针、火腿丝、芝麻油、胡椒粉、绍酒、花生油', '主菜', '14.jpg', '先用上汤将金钩翅靠入味，取出；烧镬、加油、赞入绍酒，加顶汤，烧至微滚时用湿生粉推芡，淋在翅面上加热至滚，放上火腿丝、银针炒熟后一同上席。', 1, 128),
	(15, '红棉嘉积鸭', 1, '煲好红鸭约1750克/只，郊菜500克，虾胶60克，蟹黄20克，鸭蛋白180克，上汤80克，原鸭汁25克，生油、精盐、味精、生粉、老抽、绍酒、胡椒粉适量。', '主菜', '15.jpg', '将虾胶挤成12个丸子，放在碟里，将蟹黄放在面上，上笼用猛火蒸两分钟至熟取出。花盏模具抹上花生油，蛋白、落精盐、味精打匀后去泡沫，将蛋白分放在花盏里，再把熟虾胶放在中心，上笼用慢火蒸两分钟至熟，取出稍凉后将花盏脱出。红鸭从背脊撕开从里面取出锁喉骨、四柱大骨、颈骨、胸骨和脊骨，将颈骨和脊骨分段后放回里面。将鸭放在容器里，加入原鸭汁上笼回熟。取出，滗出原汁将红鸭复转在碟里，摆成鸭形。郊菜用二汤、精盐炒熟后，滤干水分伴在旁边，烧镬落油搪镬，溅绍酒，落原鸭汁、老抽、味精、麻油、胡椒粉等微滚，用湿粉推芡，落包尾油，淋在鸭身上。将蛋白花盏回热后放在郊菜面上。用上汤、味精、精盐、麻油等调味，用湿粉勾芡，加包尾油推匀，淋在蛋白花盏上便成。', 0, 108),
	(16, '八宝冬瓜盅', 1, '冬瓜蒂约4500克/个，鸭肉粒150克，鲜莲100克，火腿粒25克，瘦肉粒、鲜菇粒各100克，烧鸭肉粒、肾粒、虾仁各75克，火腿茸5克，夜香花50克，上汤2000克，二汤、三鸟骨、精盐、味精适量。', '汤水', '16.jpg', '先将冬瓜改好去瓜囊，放在滚水中滚10分钟，取起用清水过冻，用炖盅盛着，将三鸟骨滚过，洗净放在瓜盅里，加入二汤（浸至瓜盅口）、精盐，放在笼内炖至瓜够身。将鸭粒、肉粒用湿粉拌匀，滚过，洗净，放在瓦钵里，加入笼里炖至焾，去掉姜葱。将瓜盅倒去原汤，拣去三鸟骨。再将肾粒、虾仁用滚水滚熟捞起，又将鲜菇、鲜 莲滚过，取出。将上汤和鸭馅连汤倒入镬中，用精盐、味精调味，微滚，加入鲜菇、鲜莲、丝瓜粒、肾丁、虾仁等，滚熟后放入瓜盅里，放入火鸭粒、蟹肉，再将火腿茸撒在瓜盅上，插上夜香花便成。', 0, 118),
	(17, '四宝炒牛奶', 1, '鲜牛奶300克，蛋青200克，中虾仁25克，炸榄仁15克，熟鸡肝粒25克，火腿茸5克，火腿粒10克，栗粉、盐、味精、生油适量', '小食', '17.jpg', '先将牛奶加热至8成熟候用。将虾仁、鸡肝粒泡油至熟。用牛奶加入栗粉、蛋清、味料调匀，然后加入虾仁、鸡肝、火腿粒及滚过的牛奶；猛火烧镬，用油搪镬后，留少量余油，倒入已拌好的牛奶，用中火，慢慢翻铲至凝结，加入少许油、榄仁略翻几下，即上碟堆成山形，撒上火腿茸。', 0, 88),
	(18, '桶子油鸡', 1, '毛鸡项约1250克/只，精卤水适量。', '主菜', '18.jpg', '将鸡宰杀去毛，在腋下开一小孔取出内脏，去肺、脚，在鸡尾部插入一小竹筒，放入沸卤水中，用慢火浸至仅熟取起，用麦芽糖涂匀鸡身便可。', 0, 128),
	(19, '一品天香', 1, '宰杀干净大水鱼净重约600克，鹅掌12只，鹿筋12件，湿花菇12件，发好鳘肚12件，猪婆参12件，姜件、葱条、盐、味精、绍酒、炸蒜子、花椒八角、老抽、红鸭汁、上汤、二汤、胡椒粉、生油适量。', '主菜', '19.jpg', '将鹅掌涂上老油，放进高温油里炸至金黄色；用二汤，加入花椒八角、绍酒、味料、扣至焾，取出去大骨；水鱼斩件，用老抽涂上，略炸捞起，去油；落炸好蒜头、姜米、陈皮末、绍酒，加入二汤、味料，将水鱼焖至八成熟取出备用；鳘肚用二汤加入姜、葱滚煨透、捞起；鹿筋用油浸炸至胀身，取出，滚洗干净后加入姜汁酒，煨透；然后把以上鹅掌、水鱼、鳘肚、鹿筋、海参、花菇等放入器皿中排列好，将鹅掌汁、水鱼汁、红鸭汁等加入上汤、绍酒调好味，入蒸笼炖约90分钟即成。', 0, 108),
	(20, '百花煎酿鸭掌', 1, '鲜鸭掌24只（每只25克），虾胶120克，火腿茸10克，花生油、精盐、味精、蚝油、老抽、白糖、生粉、上汤、麻油、胡椒粉、二汤、绍酒、姜汁酒适量', '主菜', '20.jpg', '鸭掌用精盐擦干净，再用清水洗干净，用滚水煮至六分焾，取出泡在冷水里，从鸭掌的掌背将骨退出，并去清筋和掌枕。用二汤、姜汁酒、精盐等将鸭掌滚过，取出，吸干水分。在碟里撒上干生粉，将虾胶挤成24粒，放在碟里，然后将粘有生粉的那面粘在鸭掌背上，捏回掌形，抹平，面上粘上火腿茸。烧镬下油搪镬，将有虾胶的那面在底，排放在镬里，用慢火煎至浅金黄色，边煎边下油浸过面，至虾胶熟即取出，排入在碟里，烧镬落油搪镬，溅绍酒，落上汤、老抽、白糖、味精、麻油、胡椒粉，用湿粉勾芡落包尾油推匀，淋在鸭掌上便成。', 1, 108),
	(21, '红烧乳鸽皇', 1, '光乳鸽450克/只  腌料：味粉500克，盐2500克，五香粉200克，糖50克，甘草粉、桔皮粉、沙姜粉各50克；糖水：麦芽糖1400克，白醋5000克，西柠片250克。', '主菜', '21.jpg', '先把乳鸽放入腌料均匀涂上内腔腌2小时，取出洗干；用滚水烫皮后用毛巾吸干水分，放入糖水，用勾晾干；再浸炸至大红色仅熟，斩件砌成形。', 0, 168),
	(22, '蟹肉灌汤饺', 1, '枚肉80克，鲜虾肉80克，湿冬菇20克，琼脂溶液400克，蟹肉200克，味料适量，面粉86克，鸡蛋17克，澄面17克，水、面种、枧水适量。（10只计）', '小食', '22.jpg', '将枚肉、鲜虾肉、湿冬菇分别切粒，琼脂溶液剁烂备用，然后再将枚肉、鲜虾肉、湿冬菇加入味料擦至有粘性后加入琼脂溶液和蟹肉拌匀入冷柜冷冻；再将面粉在案台开锅，中间放入鸡蛋、烫面、水、面种、枧水搓至混和，拌入面粉搓至纯滑， 用湿布盖好，静置30分钟后开皮便可包馅蒸。注：吃时醮上姜丝，浙醋少许。', 0, 38),
	(23, '沙湾原奶挞', 1, '面粉125克，猪板油125克，净鸡蛋18克，鲜奶208克，白糖62克，栗粉少许，蛋白、白醋适量。（10只计）', '小食', '23.jpg', '将面粉取出1/3同猪板油搓匀成油酥，放入冷柜中冷冻至硬，再将余下的面粉加入净鸡蛋搓成面团放入冷柜中冻至稍硬，然后分别将油酥及面皮开薄，将面皮放在油酥面开成长日字型，将两端向中间摺入，稍压平，摺成四摺开薄，再重复上面的动作2次后放入冷柜约1小时即可开薄件掐盏。将鲜奶煮滚，加入白糖、粟粉，晾冻后加入蛋白、白醋打匀过筛，便可斟入盏中烤熟。', 0, 28),
	(24, '脆皮粉果', 1, '枚肉粒25克，虾肉25克，叉烧粒13克，熟肥肉13克，熟虾肉13克，笋片37.5克，湿冬菇粒适量，二汤25克，味料、绍酒适量，澄面45克，滚水适量，生粉1克，猪油适量。（10件计）', '小食', '24.jpg', '将枚肉粒、虾肉用湿粉拌匀略泡油后，滤干油分，起镬加入枚肉粒、虾肉和叉烧粒、熟肥肉、熟虾肉溅酒再加入笋片、湿冬菇粒和二汤、味料煮滚后勾芡装在碟备用。将澄面用盆装起，加入滚水推匀，然后放在案板上加入生粉、猪油擦至纯滑后加入猪油再擦匀即可出件，用酥棍开成圆锅型后包馅做型，上笼蒸至熟。', 0, 28),
	(25, '薄皮鲜虾饺', 1, '虾肉90克，枧水少许，肥肉22克，笋丝22克，生粉25克，澄面25克，滚水、精盐、味精、白糖、胡椒粉、麻油少许，猪油适量。（10件计）', '小食', '25.jpg', '将虾肉加入枧水拌匀腌约2小时后漂水备用，肥肉用滚水烫熟后切粒，笋丝“飞水”（用水稍滚）后晾冻候用，然后将虾肉加入味料擦至起胶，落笋丝拌匀后再加入肥肉和猪油捞匀入冷柜稍冷冻。将澄面和少许盐用盆装起加入滚水推匀，放在案台上加入生粉擦至纯滑，入猪油再搓匀即可出件拍成薄片然后包馅做型，放入蒸笼蒸至熟。', 0, 28);
/*!40000 ALTER TABLE `dishesinfo` ENABLE KEYS */;


-- 导出  表 ordersys.dishnews 结构
DROP TABLE IF EXISTS `dishnews`;
CREATE TABLE IF NOT EXISTS `dishnews` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `waiterId` int(11) NOT NULL,
  `dateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '消息生成时间',
  `content` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_dishnews_userinfo` (`waiterId`),
  CONSTRAINT `FK_dishnews_userinfo` FOREIGN KEY (`waiterId`) REFERENCES `userinfo` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- 正在导出表  ordersys.dishnews 的数据：~6 rows (大约)
DELETE FROM `dishnews`;
/*!40000 ALTER TABLE `dishnews` DISABLE KEYS */;
INSERT INTO `dishnews` (`ID`, `waiterId`, `dateTime`, `content`) VALUES
	(8, 3, '2016-06-24 16:55:31', '桌号[10]的菜品[麻皮乳猪]已经烹制完成，请传菜！'),
	(9, 3, '2016-06-24 16:55:32', '桌号[10]的菜品[玉环瑶柱脯]已经烹制完成，请传菜！'),
	(10, 3, '2016-06-24 16:55:32', '桌号[15]的菜品[麒麟蒸桂鱼]已经烹制完成，请传菜！'),
	(11, 7, '2016-06-26 14:27:59', '桌号[8]的菜品[广州文昌鸡]已经烹制完成，请传菜！'),
	(12, 7, '2016-06-26 14:28:06', '桌号[8]的菜品[椰香咖喱蟹]已经烹制完成，请传菜！'),
	(13, 7, '2016-06-26 14:28:26', '桌号[8]的菜品[麻皮乳猪]已经烹制完成，请传菜！');
/*!40000 ALTER TABLE `dishnews` ENABLE KEYS */;


-- 导出  表 ordersys.orderdishes 结构
DROP TABLE IF EXISTS `orderdishes`;
CREATE TABLE IF NOT EXISTS `orderdishes` (
  `odId` int(11) NOT NULL AUTO_INCREMENT COMMENT '详单编号，主键，自动增长',
  `orderReference` int(11) NOT NULL COMMENT '对应订单编号，外键',
  `dishes` int(11) NOT NULL COMMENT '对应菜品编号，外键',
  `cookingStatus` int(11) NOT NULL DEFAULT '0' COMMENT '烹饪状态：0-未烹饪，1-正在烹饪，2-烹饪完毕',
  `num` int(11) NOT NULL COMMENT '菜品的数量',
  PRIMARY KEY (`odId`),
  KEY `FK_orderdishes_orderinfo` (`orderReference`),
  KEY `FK_orderdishes_dishesinfo` (`dishes`),
  CONSTRAINT `FK_orderdishes_dishesinfo` FOREIGN KEY (`dishes`) REFERENCES `dishesinfo` (`dishesId`) ON UPDATE CASCADE,
  CONSTRAINT `FK_orderdishes_orderinfo` FOREIGN KEY (`orderReference`) REFERENCES `orderinfo` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- 正在导出表  ordersys.orderdishes 的数据：~12 rows (大约)
DELETE FROM `orderdishes`;
/*!40000 ALTER TABLE `orderdishes` DISABLE KEYS */;
INSERT INTO `orderdishes` (`odId`, `orderReference`, `dishes`, `cookingStatus`, `num`) VALUES
	(1, 1, 12, 2, 2),
	(2, 1, 5, 2, 1),
	(3, 1, 4, 2, 1),
	(20, 63, 2, 2, 1),
	(21, 63, 3, 2, 2),
	(22, 65, 1, 2, 1),
	(25, 65, 2, 2, 1),
	(26, 65, 3, 2, 2),
	(27, 69, 1, 2, 2),
	(28, 69, 2, 2, 1),
	(29, 69, 5, 2, 1),
	(32, 69, 5, 0, 1),
	(33, 69, 5, 0, 1);
/*!40000 ALTER TABLE `orderdishes` ENABLE KEYS */;


-- 导出  表 ordersys.orderinfo 结构
DROP TABLE IF EXISTS `orderinfo`;
CREATE TABLE IF NOT EXISTS `orderinfo` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号，主键，自动增长',
  `orderBeginDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单开始时间',
  `orderEndDate` datetime DEFAULT NULL COMMENT '订单结束时间',
  `waiterId` int(11) NOT NULL COMMENT '订单的点餐员ID，外键',
  `orderState` int(11) NOT NULL DEFAULT '0' COMMENT '订单状态：0-正在用餐，1-准备结账，2-已经结账，3-免单订单',
  `sum` float DEFAULT NULL COMMENT '订单总价',
  `tableId` int(11) NOT NULL COMMENT '订单对应的桌号',
  PRIMARY KEY (`orderId`),
  KEY `FK_orderinfo_userinfo` (`waiterId`),
  CONSTRAINT `FK_orderinfo_userinfo` FOREIGN KEY (`waiterId`) REFERENCES `userinfo` (`userId`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- 正在导出表  ordersys.orderinfo 的数据：~9 rows (大约)
DELETE FROM `orderinfo`;
/*!40000 ALTER TABLE `orderinfo` DISABLE KEYS */;
INSERT INTO `orderinfo` (`orderId`, `orderBeginDate`, `orderEndDate`, `waiterId`, `orderState`, `sum`, `tableId`) VALUES
	(1, '2016-04-15 10:11:20', '2016-06-25 15:33:13', 3, 2, 392, 1),
	(2, '2016-06-12 02:55:09', '2016-06-12 02:59:34', 4, 2, 200, 10),
	(63, '2016-06-20 14:38:26', '2016-06-23 23:20:40', 3, 2, 276, 4),
	(64, '2016-06-20 14:39:07', NULL, 4, 0, NULL, 11),
	(65, '2016-06-20 15:07:48', '2016-06-24 22:11:34', 3, 2, 452, 2),
	(66, '2016-06-25 22:25:17', NULL, 3, 0, NULL, 4),
	(67, '2016-06-26 13:31:49', NULL, 5, 0, NULL, 1),
	(68, '2016-06-26 14:13:22', '2016-06-26 14:27:28', 7, 3, 0, 1),
	(69, '2016-06-26 14:16:18', NULL, 7, 0, NULL, 8);
/*!40000 ALTER TABLE `orderinfo` ENABLE KEYS */;


-- 导出  表 ordersys.permissioninfo 结构
DROP TABLE IF EXISTS `permissioninfo`;
CREATE TABLE IF NOT EXISTS `permissioninfo` (
  `permissionId` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限编号，主键，自增长',
  `permissionName` varchar(50) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`permissionId`),
  KEY `FK_permission_roleinfo` (`roleId`),
  CONSTRAINT `FK_permission_roleinfo` FOREIGN KEY (`roleId`) REFERENCES `roleinfo` (`roleId`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- 正在导出表  ordersys.permissioninfo 的数据：~8 rows (大约)
DELETE FROM `permissioninfo`;
/*!40000 ALTER TABLE `permissioninfo` DISABLE KEYS */;
INSERT INTO `permissioninfo` (`permissionId`, `permissionName`, `roleId`) VALUES
	(1, 'admin:*', 1),
	(2, 'waiter:*', 1),
	(3, 'kitchen:*', 1),
	(4, 'admin:*', 2),
	(5, 'waiter:*', 2),
	(6, 'kitchen:*', 2),
	(7, 'waiter:*', 3),
	(8, 'kitchen:*', 4);
/*!40000 ALTER TABLE `permissioninfo` ENABLE KEYS */;


-- 导出  表 ordersys.roleinfo 结构
DROP TABLE IF EXISTS `roleinfo`;
CREATE TABLE IF NOT EXISTS `roleinfo` (
  `roleId` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色编号，主键，自动增长',
  `roleName` varchar(32) NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  ordersys.roleinfo 的数据：~4 rows (大约)
DELETE FROM `roleinfo`;
/*!40000 ALTER TABLE `roleinfo` DISABLE KEYS */;
INSERT INTO `roleinfo` (`roleId`, `roleName`) VALUES
	(1, '超级管理员'),
	(2, '管理员'),
	(3, '点餐员'),
	(4, '后厨');
/*!40000 ALTER TABLE `roleinfo` ENABLE KEYS */;


-- 导出  表 ordersys.userinfo 结构
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE IF NOT EXISTS `userinfo` (
  `userId` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编号，主键，自动增长',
  `userAccount` varchar(20) NOT NULL COMMENT '用户登录时使用的帐号名称',
  `userPass` varchar(32) NOT NULL COMMENT '用户登录时使用的密码',
  `roleId` int(11) NOT NULL COMMENT '用户的角色ID，外键',
  `locked` int(11) NOT NULL DEFAULT '0' COMMENT '用户是否被锁定：0-未锁定，1-锁定',
  `faceimg` varchar(50) NOT NULL DEFAULT 'userIcon.jpg' COMMENT '用户头像图片名',
  PRIMARY KEY (`userId`),
  KEY `FK_userinfo_roleinfo` (`roleId`),
  CONSTRAINT `FK_userinfo_roleinfo` FOREIGN KEY (`roleId`) REFERENCES `roleinfo` (`roleId`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- 正在导出表  ordersys.userinfo 的数据：~7 rows (大约)
DELETE FROM `userinfo`;
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` (`userId`, `userAccount`, `userPass`, `roleId`, `locked`, `faceimg`) VALUES
	(1, '老大', 'ddyc1', 1, 0, 'userIcon.jpg'),
	(2, '大表哥', '456', 2, 0, 'userIcon.jpg'),
	(3, '小表弟', '123', 3, 0, 'userIcon.jpg'),
	(4, '阿梅', 'aaaa', 3, 0, 'userIcon.jpg'),
	(5, 'Tom', 'ddd', 2, 0, '1466859371162.jpg'),
	(7, 'a', 'b', 3, 0, 'userIcon.jpg'),
	(8, '小陈', '789', 4, 0, 'userIcon.jpg');
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
