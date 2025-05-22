/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : xm_music

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2025-05-03 11:34:54
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO admin VALUES ('1', 'admin1', '123456', 'admin1', 'http://localhost:8080/files/download/1745223486993-admin1avatar.jpg', 'ADMIN', '18899990011', 'admin1@xm.com');
INSERT INTO admin VALUES ('2', 'admin2', '123456', 'admin2', 'http://localhost:8080/files/download/1745223503472-admin2avatar.jpg', 'ADMIN', '18888060558', 'admin2@xm.com');
INSERT INTO admin VALUES ('3', 'admin3', '123456', 'admin3', 'http://localhost:8080/files/download/1745223511690-admin3avatar.jpg', 'ADMIN', '18888091883', 'admin3@xm.com');
INSERT INTO admin VALUES ('4', 'admin4', '123456', 'admin4', 'http://localhost:8080/files/download/1745223518469-admin4avatar.jpg', 'ADMIN', '18888034789', 'admin4@xm.com');

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '帖子标题',
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '帖子主图',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '帖子内容',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布时间',
  `student_id` int(10) DEFAULT NULL COMMENT '学生ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='帖子信息表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO article VALUES ('2', '音高基础', 'http://localhost:8080/files/download/1745461094520-1728563597926-2.png', '<p style=\"text-align: start;\"><span style=\"color: rgb(9, 109, 217);\">1. 音名与唱名 </span></p><p style=\"text-align: start;\">固定音高：C D E F G A B（音名）</p><p style=\"text-align: start;\">首调唱法：do re mi fa sol la si（唱名）</p><p style=\"text-align: start;\">记忆口诀：\"CDEFGAB，钢琴白键排排坐\"</p><p style=\"text-align: start;\"><span style=\"color: rgb(9, 109, 217);\">2. 半音与全音 </span></p><p style=\"text-align: start;\">钢琴相邻键=半音（如E-F、B-C）</p><p style=\"text-align: start;\">隔一个键=全音（如C-D、F-G）</p><p style=\"text-align: start;\">特殊记忆：\"Mi-Fa和Si-Do是亲密半音\"<br></p>', '2024-10-10 20:35:34', '1');
INSERT INTO article VALUES ('3', '个人实践心得', 'http://localhost:8080/files/download/1745464198741-1728564626540-10.png', '<ul><li style=\"text-align: left;\">音阶：《哈农No.1》</li><li style=\"text-align: left;\">和弦：《卡农》前四小节</li><li style=\"text-align: left;\">节奏：《克罗地亚狂想曲》前奏</li></ul>', '2024-10-10 20:49:20', '2');
INSERT INTO article VALUES ('6', '节奏核心概念记忆小技巧', 'http://localhost:8080/files/download/1745461292741-1728564558044-9.png', '<p style=\"text-align: start;\"><strong>四分音符</strong> = 1拍（常见基础时值）</p><p style=\"text-align: start;\"><strong>八分音符</strong> = ½拍（带尾巴）</p><p style=\"text-align: start;\"><strong>十六分音符</strong> = ¼拍（双尾巴）</p><p style=\"text-align: start;\"><br></p>', '2024-10-10 21:55:52', '1');

-- ----------------------------
-- Table structure for `comment_like`
-- ----------------------------
DROP TABLE IF EXISTS `comment_like`;
CREATE TABLE `comment_like` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `comment_id` (`comment_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment_like
-- ----------------------------
INSERT INTO comment_like VALUES ('4', '2', '1', '2025-04-14 19:51:49');
INSERT INTO comment_like VALUES ('5', '5', '1', '2025-04-14 20:16:37');
INSERT INTO comment_like VALUES ('6', '3', '1', '2025-04-14 20:54:40');
INSERT INTO comment_like VALUES ('7', '8', '1', '2025-04-16 20:29:12');
INSERT INTO comment_like VALUES ('8', '10', '1', '2025-04-16 20:51:10');
INSERT INTO comment_like VALUES ('9', '24', '1', '2025-04-16 22:37:01');
INSERT INTO comment_like VALUES ('10', '18', '1', '2025-04-16 22:38:34');
INSERT INTO comment_like VALUES ('11', '37', '1', '2025-04-18 20:23:10');
INSERT INTO comment_like VALUES ('12', '39', '1', '2025-04-24 20:54:01');
INSERT INTO comment_like VALUES ('13', '39', '3', '2025-04-24 20:59:00');

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程名称',
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程封面',
  `score` int(10) DEFAULT NULL COMMENT '课程学分',
  `teacher_id` int(10) DEFAULT NULL COMMENT '教师ID',
  `level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '难度水平',
  `desp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程简介',
  `video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频url',
  `study_count` int(255) DEFAULT '0' COMMENT '学习人数',
  `create_time` datetime DEFAULT NULL COMMENT '课程创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='课程信息表';

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO course VALUES ('20', '乐理通俗讲解', 'http://localhost:8080/files/download/1745323842489-乐理通俗理解.png', '3', '1', '基础', '本课程旨在用最精炼的方式，帮助学习者快速掌握音乐理论的核心概念。无论你是音乐爱好者、初学者，还是希望巩固基础的演奏者，都能在20分钟内理解乐理的基本框架，并运用于实际的音乐欣赏、演唱或演奏中。', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-560191273962094785620分钟乐理通俗讲解.mp4', '1', null);
INSERT INTO course VALUES ('21', '为什么要学乐理？', 'http://localhost:8080/files/download/1745377395259-为什么要学乐理1.png', '3', '1', '基础', ' 课程三大核心价值：\n1️⃣ 解构音乐密码 - 从根源理解和弦进行、调式转换的底层逻辑\n2️⃣ 提升创作维度 - 告别\"碰运气\"作曲，掌握科学创作方法论\n3️⃣ 突破学习瓶颈 - 打通乐器演奏、编曲、混音的知识壁垒\n\n? 适合人群：\n• 想系统提升音乐素养的爱好者\n• 准备艺考的音乐专业考生\n• 渴望突破创作瓶颈的音乐人\n• 希望提升教学水平的音乐教师', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-12182506359593381201.mp4', '2', null);
INSERT INTO course VALUES ('22', '音名与钢琴键盘', 'http://localhost:8080/files/download/1745377527965-AI去水印_360智图.png', '3', '1', '基础', '\"5分钟带你破解钢琴键盘的密码！从零认识音名与键盘的对应关系，小白也能秒懂的音乐基础课～\"\n\n 亮点语录：\n\"黑键白键都是宝，音名位置要记牢！\"\n\"CDEFGAB，键盘上的字母歌\"\n\"一组八度十二键，半音全音马上辨\"\n\n学习收获：\n✓ 一眼认出钢琴上所有音名位置\n✓ 彻底搞懂半音/全音关系\n✓ 为和弦学习打下坚实基础\n\n? 适合人群：\n• 钢琴初学者 • 音乐兴趣爱好者 • 需要巩固基础的音乐生', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-17847567486431837292.mp4', '0', null);
INSERT INTO course VALUES ('23', '升降号、还原号', 'http://localhost:8080/files/download/1745377755272-AI去水印_360智图 (1).png', '3', '1', '基础', '本课程系统讲解音乐中升降号（♯/♭）和还原号（♮）的核心概念与应用。课程内容涵盖：1.\n变音记号的基本原理与记谱规范\n2.\n调性中的升降号使用规则\n3.\n临时变音记号的演奏处理方法\n\n常见应用误区与注意事项\n4.\n通过理论讲解结合经典谱例分析，帮助学习者准确理解并运用这些重要符号，切实提升读谱能力与演奏准确性。课程适合需要系统掌握基础乐理知识的音乐学习者和演奏者。', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-178858425915353248393.mp4', '1', null);
INSERT INTO course VALUES ('24', '如何区分同一音名的不同键？', 'http://localhost:8080/files/download/1745377846363-AI去水印_360智图 (2).png', '3', '1', '基础', '本课程讲解如何区分钢琴上相同音名的不同键位（如C与#C），内容包括：\n1.\n升降号的基本原理\n2.\n黑键白键的命名规则\n3.\n等音关系的实际应用\n\n常见演奏误区解析\n\n通过简明讲解和实例演示，帮助学习者快速掌握区分方法，提升读谱和演奏准确性。适合钢琴初学者和需要巩固基础的音乐爱好者。', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-102197604151700912584.mp4', '0', null);
INSERT INTO course VALUES ('25', '各类音符时值的关系', 'http://localhost:8080/files/download/1745378220970-各类音符时值的关系5.jpg', '3', '2', '基础', '通过简单示范和练习，快速掌握音符时长关系，提高演奏准确性。\n适合：音乐初学者', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-28761461401340346855.mp4', '0', null);
INSERT INTO course VALUES ('26', '音乐拍号', 'http://localhost:8080/files/download/1745394630094-音乐拍号6.jpg', '3', '2', '基础', '课程内容：\n\n1.常见拍号解析（2/4、3/4、4/4等）\n\n2.拍号与音符时值的关系\n\n3.不同拍号的节奏特点\n\n通过实例演示和跟拍练习，快速理解拍号含义，掌握基础节奏型。\n\n适合：音乐初学者', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-55890689395259850956.mp4', '1', null);
INSERT INTO course VALUES ('27', '自然大调（白键）', 'http://localhost:8080/files/download/1745394673972-自然大调白键7.jpg', '3', '2', '中等', '课程内容：\n\n1.C大调音阶构成（全全半全全全半）\n\n2.白键调式的音程关系\n\n3.基础大调音阶练习\n\n通过键盘示范和简单旋律，掌握自然大调的基本结构。', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-10533499206554261950自然大调白键.mp4', '0', null);
INSERT INTO course VALUES ('28', '自然大调（黑键）', 'http://localhost:8080/files/download/1745394743060-自然大调黑键8.jpg', '3', '2', '中等', '课程内容：\n\n1.黑键调式音阶构成规律\n\n2.常用黑键大调（G大调、D大调等）\n\n3.黑键调式的指法特点\n\n通过典型曲例分析，掌握黑键调式的演奏技巧。\n\n适合：有白键基础的钢琴学习者', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-10594980966665609366自然大调黑键.mp4', '0', null);
INSERT INTO course VALUES ('29', '自然小调', 'http://localhost:8080/files/download/1745394782067-自然小调9.jpg', '3', '2', '困难', '课程内容：\n\n1.小调音阶构成规律（全半全全半全全）\n\n2.关系大小调对应法则\n\n3.典型小调旋律练习\n\n通过对比大调音阶，理解小调独特的音乐色彩。\n\n适合：已掌握大调基础的学习者', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-16276592364891131857自然小调.mp4', '0', null);
INSERT INTO course VALUES ('30', '大小调有什么区别？', 'http://localhost:8080/files/download/1745394867563-大小调有什么区别？10.jpg', '3', '3', '中等', '课程内容：\n1.音阶结构对比\n大调：全全半全全全半（明亮）\n小调：全半全全半全全（忧郁）\n2.色彩差异\n大调：欢快、明朗（如《欢乐颂》）\n小调：忧伤、深沉（如《致爱丽丝》）\n3.关系大小调\n同一调号下的对应关系（如C大调↔A小调）\n实际应用\n1.如何通过旋律判断调性\n2.经典曲目片段听辨练习\n适合： 已掌握音阶基础的学习者', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-4490740240029061372大小调有什么区别.mp4', '0', null);
INSERT INTO course VALUES ('31', '音程的基础概念', 'http://localhost:8080/files/download/1745398820572-音程的基础概念11.jpg', '3', '3', '中等', '课程内容：\n\n什么是音程（两个音的高低关系）\n\n常见音程类型：\n\n纯音程：听起来最和谐\n\n大小音程：决定音乐色彩\n\n快速识别方法：\n\n数键盘上的键\n\n记典型歌曲开头\n\n适合：需要巩固乐理基础的学习者', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-1081476952131304972音程的基础概念.mp4', '0', null);
INSERT INTO course VALUES ('32', '音程的属性(1)', 'http://localhost:8080/files/download/1745398865117-音程的属性1-12.jpg', '3', '3', '中等', '音程是音乐中两个音之间的高低距离关系，主要包括纯音程、大音程、小音程这几类基本形态。纯音程听起来最和谐稳定，比如do到sol就是纯五度；大小音程则赋予音乐不同的色彩变化，大音程明亮开阔，小音程柔和忧郁。通过简单的数音级方法就能快速判断常见音程性质，比如三度音程中，包含4个半音是大三度，3个半音是小三度。掌握这些基本概念可以帮助我们更好地理解和创作音乐。', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-16300745891858023172音程的属性.mp4', '0', null);
INSERT INTO course VALUES ('33', '音程的属性(2)', 'http://localhost:8080/files/download/1745398910860-音程的属性2-13.jpg', '3', '3', '中等', '音程就是两个音之间的距离，它决定了音乐的情绪色彩。最和谐的纯音程像do到sol这样稳定扎实；大音程带来阳光般明亮的听感，小音程则像蒙上一层忧郁的薄纱。判断起来很简单：数数两个音之间包含几个半音就行，比如大三度有4个半音，小三度少1个就变成3个半音。这些看似简单的音程关系，正是构建所有美妙音乐的基石。\n', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-15752161716466293267音程的属性2.mp4', '0', null);
INSERT INTO course VALUES ('34', '三和弦', 'http://localhost:8080/files/download/1745399009030-三和弦14.jpg', '3', '3', '困难', '三和弦由三个音按三度叠加构成，是最基本的和弦形式。主要分为以下四种类型：\n1.大三和弦：根音+大三度+纯五度（如C-E-G），音响明亮\n2.小三和弦：根音+小三度+纯五度（如A-C-E），音响柔和\n3.增三和弦：根音+大三度+增五度（如C-E-G#），音响扩张\n4.减三和弦：根音+小三度+减五度（如B-D-F），音响紧张', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-4516378269104805524三和弦.mp4', '0', null);
INSERT INTO course VALUES ('35', '七和弦', 'http://localhost:8080/files/download/1745399041877-七和弦15.jpg', '3', '3', '困难', '七和弦是在三和弦基础上叠加七度音构成的和弦形式,通过此课程你将学习到七和弦的基础知识。', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-14462747826673506716七和弦.mp4', '1', null);
INSERT INTO course VALUES ('36', '九和弦', 'http://localhost:8080/files/download/1745399078104-九和弦16.jpg', '3', '3', '困难', '九和弦是在七和弦基础上叠加九度音构成的和弦形式，分为属九和弦、大九和弦、小九和弦等，通过此课程你将学习到九和弦的基础知识。', 'https://roomyyt.oss-cn-shanghai.aliyuncs.com/video/upload-3517917302894902660九和弦.mp4', '0', null);

-- ----------------------------
-- Table structure for `course_comment`
-- ----------------------------
DROP TABLE IF EXISTS `course_comment`;
CREATE TABLE `course_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `like_count` int(11) DEFAULT '0',
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of course_comment
-- ----------------------------
INSERT INTO course_comment VALUES ('1', '12', '1', null, '11111', null, '1', 'STUDENT', '2025-04-14 19:23:39', '1');
INSERT INTO course_comment VALUES ('2', '12', '1', null, '111111', null, '1', 'STUDENT', '2025-04-14 19:27:42', '1');
INSERT INTO course_comment VALUES ('3', '12', '1', null, '1111', null, '1', 'STUDENT', '2025-04-14 19:52:57', '1');
INSERT INTO course_comment VALUES ('4', '12', '2', null, '2222222', '3', '0', 'STUDENT', '2025-04-14 19:54:30', '0');
INSERT INTO course_comment VALUES ('5', '12', '2', '张三', '1111', null, '1', 'STUDENT', '2025-04-14 20:14:09', '1');
INSERT INTO course_comment VALUES ('6', '12', '2', null, '333333', '3', '0', 'STUDENT', '2025-04-14 20:16:22', '0');
INSERT INTO course_comment VALUES ('7', '12', '1', null, '1213', '5', '0', 'STUDENT', '2025-04-15 20:10:55', '1');
INSERT INTO course_comment VALUES ('8', '11', '1', '张三', '1111', null, '1', 'STUDENT', '2025-04-16 20:29:03', '0');
INSERT INTO course_comment VALUES ('9', '12', '1', null, '131', '5', '0', 'STUDENT', '2025-04-16 20:42:04', '1');
INSERT INTO course_comment VALUES ('10', '17', '1', '张三', '21424`24', null, '1', 'STUDENT', '2025-04-16 20:50:52', '1');
INSERT INTO course_comment VALUES ('11', '17', '1', null, 'Gzsweghwsr', '10', '0', 'STUDENT', '2025-04-16 20:51:07', '1');
INSERT INTO course_comment VALUES ('12', '12', '1', null, '`2`24', '2', '0', 'STUDENT', '2025-04-16 22:09:46', '0');
INSERT INTO course_comment VALUES ('13', '12', '1', '张三', '24124', null, '0', 'STUDENT', '2025-04-16 22:09:56', '1');
INSERT INTO course_comment VALUES ('14', '12', '1', null, '412412', '13', '0', 'STUDENT', '2025-04-16 22:10:00', '0');
INSERT INTO course_comment VALUES ('15', '12', '1', '张三', '421412', null, '0', 'STUDENT', '2025-04-16 22:10:12', '1');
INSERT INTO course_comment VALUES ('16', '12', '1', null, '12412', '15', '0', 'STUDENT', '2025-04-16 22:10:15', '0');
INSERT INTO course_comment VALUES ('17', '12', '1', '张三', '24121252', '13', '0', 'STUDENT', '2025-04-16 22:14:35', '0');
INSERT INTO course_comment VALUES ('18', '12', '1', '张三', '5135151', null, '1', 'STUDENT', '2025-04-16 22:15:17', '0');
INSERT INTO course_comment VALUES ('19', '12', '1', '张三', '463246', '18', '0', 'STUDENT', '2025-04-16 22:15:27', '1');
INSERT INTO course_comment VALUES ('20', '12', '1', '张三', '222', '19', '0', 'STUDENT', '2025-04-16 22:27:54', '0');
INSERT INTO course_comment VALUES ('21', '12', '1', '张三', '1451531', '18', '0', 'STUDENT', '2025-04-16 22:34:30', '1');
INSERT INTO course_comment VALUES ('22', '12', '1', '张三', '3512352', null, '0', 'STUDENT', '2025-04-16 22:36:47', '1');
INSERT INTO course_comment VALUES ('23', '12', '1', '张三', '5235123', '22', '0', 'STUDENT', '2025-04-16 22:36:51', '1');
INSERT INTO course_comment VALUES ('24', '12', '1', '张三', '52135123', null, '1', 'STUDENT', '2025-04-16 22:37:00', '0');
INSERT INTO course_comment VALUES ('25', '12', '1', '张三', '512351235', '24', '0', 'STUDENT', '2025-04-16 22:37:04', '1');
INSERT INTO course_comment VALUES ('26', '12', '1', '张三', '46246234', null, '0', 'STUDENT', '2025-04-16 22:38:10', '1');
INSERT INTO course_comment VALUES ('27', '12', '1', '张三', '23642', '26', '0', 'STUDENT', '2025-04-16 22:38:20', '1');
INSERT INTO course_comment VALUES ('28', '17', '2', '李四', '32515', null, '0', 'STUDENT', '2025-04-16 22:42:04', '0');
INSERT INTO course_comment VALUES ('29', '17', '2', '李四', '51235123', '28', '0', 'STUDENT', '2025-04-16 22:42:07', '0');
INSERT INTO course_comment VALUES ('30', '17', '1', '张三', '162613', '28', '0', 'STUDENT', '2025-04-16 22:42:31', '0');
INSERT INTO course_comment VALUES ('31', '17', '1', '张三', '463163', null, '0', 'STUDENT', '2025-04-16 22:42:34', '0');
INSERT INTO course_comment VALUES ('32', '17', '1', '张三', '3462463', '31', '0', 'STUDENT', '2025-04-16 22:42:37', '0');
INSERT INTO course_comment VALUES ('33', '17', '1', '张三', '2412532', null, '0', 'STUDENT', '2025-04-16 22:43:14', '0');
INSERT INTO course_comment VALUES ('34', '17', '1', '张三', '531235', '33', '0', 'STUDENT', '2025-04-16 22:43:17', '0');
INSERT INTO course_comment VALUES ('35', '17', '2', '李四', '35155123', '33', '0', 'STUDENT', '2025-04-16 22:43:42', '1');
INSERT INTO course_comment VALUES ('36', '17', '2', '李四', '7543743', '33', '0', 'STUDENT', '2025-04-16 22:43:58', '0');
INSERT INTO course_comment VALUES ('37', '19', '1', '张三', '111111', null, '1', 'STUDENT', '2025-04-18 20:23:04', '0');
INSERT INTO course_comment VALUES ('38', '19', '1', '张三', '111111', '37', '0', 'STUDENT', '2025-04-18 20:23:08', '1');
INSERT INTO course_comment VALUES ('39', '21', '1', '张三', '受益匪浅！', null, '2', 'STUDENT', '2025-04-24 20:52:48', '0');
INSERT INTO course_comment VALUES ('40', '21', '1', '张三', '强烈建议大家看看这门课，这是我见过最好的入门课程，没有之一~', '39', '0', 'STUDENT', '2025-04-24 20:53:52', '0');
INSERT INTO course_comment VALUES ('41', '21', '2', '李四', '确实！！！', '39', '0', 'STUDENT', '2025-04-24 20:54:54', '0');
INSERT INTO course_comment VALUES ('42', '21', '3', '王五', '嗯嗯', '39', '0', 'STUDENT', '2025-04-25 21:42:19', '0');

-- ----------------------------
-- Table structure for `exam_plan`
-- ----------------------------
DROP TABLE IF EXISTS `exam_plan`;
CREATE TABLE `exam_plan` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='考试安排表';

-- ----------------------------
-- Records of exam_plan
-- ----------------------------
INSERT INTO exam_plan VALUES ('7', '为什么要学乐理？测试通知', '请大家尽快完成测试，检验学习成果！考试期间：2025年4月13日~2025年5月30日，考试时间：30分钟', '2025-04-23 21:27:35');
INSERT INTO exam_plan VALUES ('8', '乐理通俗讲解测验通知', '请大家尽快完成测试，检验学习成果！考试期间：2025年4月10日~2025年5月31日，考试时间：40分钟', '2025-04-23 22:43:47');
INSERT INTO exam_plan VALUES ('9', '升降号、还原号测验通知', '请大家尽快完成测试，检验学习成果！考试期间：2025年4月2日~2025年4月11日，考试时间：30分钟', '2025-04-01 22:44:35');

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公告标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '公告内容',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='系统公告表';

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO notice VALUES ('1', '零基础7天快速入门课程上新啦！', '零基础7天快速入门课程上新啦！快来看看吧！', '2025-04-16 15:51:17');
INSERT INTO notice VALUES ('2', '欢迎来到在线音乐教学网站', '在线音乐教学网站提供多种免费音乐课程供学生学习。', '2025-03-16 15:52:22');
INSERT INTO notice VALUES ('3', '评论规范通知', '请大家发表评论时注意自己的表达、不要攻击他人，共同营造一个良好的学习范围。', '2025-03-16 15:52:56');

-- ----------------------------
-- Table structure for `question`
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '题目名称',
  `course_id` int(10) DEFAULT NULL COMMENT '课程ID',
  `teacher_id` int(10) DEFAULT NULL COMMENT '教师ID',
  `type_id` int(10) DEFAULT NULL COMMENT '题型ID',
  `option_a` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '选项A',
  `option_b` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '选项B',
  `option_c` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '选项C',
  `option_d` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '选项D',
  `answer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '题目答案',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='题目信息表';

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO question VALUES ('8', '音乐中“音高”由什么决定？', '20', '1', '1', '声音的振幅', '声音的频率', '声音的时长', '声音的音色', 'B');
INSERT INTO question VALUES ('9', '标准音A4的频率是多少？', '20', '1', '1', '440Hz', '261.6Hz', '523.2Hz', '880Hz', 'A');
INSERT INTO question VALUES ('10', '下列哪个音程是“纯四度”？', '20', '1', '1', 'C到F', 'C到G', 'C到E', 'C到D', 'A');
INSERT INTO question VALUES ('11', '大调音阶的全半音结构是？', '20', '1', '1', '全全半全全全半', '全半全全半全全', '全全全半全全半', '全全半全全半全', 'A');
INSERT INTO question VALUES ('12', '和弦C-E-G构成的是？', '20', '1', '1', '大三和弦', '小三和弦', ' 减三和弦', ' 增三和弦', 'A');
INSERT INTO question VALUES ('13', '音名“C”对应的唱名是“Do”。', '20', '1', '3', null, null, null, null, '正确');
INSERT INTO question VALUES ('14', '小调音阶的主音（第一个音）与大调音阶的主音相同。', '20', '1', '3', null, null, null, null, '错误');
INSERT INTO question VALUES ('15', '十二平均律将一个八度均分为12个半音。', '20', '1', '3', null, null, null, null, '正确');
INSERT INTO question VALUES ('16', '钢琴上相邻的两个白键之间如果有黑键，它们的音程是', '20', '1', '4', null, null, null, null, '全音');
INSERT INTO question VALUES ('17', '大三和弦的构成是根音+______+纯五度。', '20', '1', '4', null, null, null, null, '大三度');
INSERT INTO question VALUES ('18', '简述“十二平均律”的定义及其实际意义。', '20', '1', '5', null, null, null, null, '将八度均分为12个半音，使转调和乐器制造标准化，便于音乐创作与演奏。');
INSERT INTO question VALUES ('19', '为什么C大调音阶没有升降号？', '20', '1', '5', null, null, null, null, 'C大调音阶由自然音（白键）构成，符合“全全半全全全半”的结构，无需升降音。');
INSERT INTO question VALUES ('20', '举例说明“小三和弦”与“大三和弦”的区别。', '20', '1', '5', null, null, null, null, '大三和弦（如C-E-G）根音到三音为大三度，小三和弦（如C-E♭-G）根音到三音为小三度。');
INSERT INTO question VALUES ('21', '学习乐理的主要目的是？', '21', '1', '1', '为了快速记住所有音符', '为了完成任务', '单纯为了通过考试', '模仿他人作品', 'B');
INSERT INTO question VALUES ('22', '视频中没有提到的，不懂乐理可能导致的问题是？', '21', '1', '2', '无法使用乐器', '演奏或创作时效率低下，靠“碰运气”', '唱歌跑调', '听不懂任何音乐', 'A,C,D');
INSERT INTO question VALUES ('23', '乐理知识对以下哪项活动帮助最小？', '21', '1', '1', '即兴演奏', '作曲编曲', '音乐软件操作', '音乐版权登记', 'D');
INSERT INTO question VALUES ('24', '视频中提到的“音乐语言”指的是？', '21', '1', '1', '不同国家的音乐风格', '音符、节奏、和声等构成的规律体系', '乐器的演奏技巧', '音乐家的个人习惯', 'B');
INSERT INTO question VALUES ('25', '乐理是只有专业音乐人才需要学习的知识。', '21', '1', '3', null, null, null, null, '错误');
INSERT INTO question VALUES ('26', '掌握乐理可以避免作曲时“凭感觉试错”。', '21', '1', '3', null, null, null, null, '正确');
INSERT INTO question VALUES ('27', '视频中将乐理比作音乐的______。', '21', '1', '4', null, null, null, null, '语言');
INSERT INTO question VALUES ('28', '乐理知识可以帮助你更好地______他人的音乐作品。', '21', '1', '4', null, null, null, null, '理解');
INSERT INTO question VALUES ('29', '根据视频，列举三个学习乐理的实际好处。', '21', '1', '4', null, null, null, null, '提高创作效率、增强演奏准确性、便于音乐交流、深化作品分析能力等（答出三点即可）。');
INSERT INTO question VALUES ('30', '为什么说乐理是音乐的“共同语言”？', '21', '1', '5', null, null, null, null, '乐理提供标准化的术语和规则，使不同乐器、风格的音乐人能高效协作和理解彼此。');
INSERT INTO question VALUES ('31', '视频中提到“乐理不是枷锁”，如何理解这句话？', '21', '1', '5', null, null, null, null, '乐理是工具而非限制，掌握后可以主动选择遵循或突破规则，从而更自由地表达音乐。');
INSERT INTO question VALUES ('32', '下列符号中，表示“降号”的是？', '23', '1', '1', '♯', '♭', ' ♮', '×', 'B');
INSERT INTO question VALUES ('33', '关于音符前的还原号（♮）的作用不对的是？', '23', '1', '2', '升高半音', ' 取消之前的升降号效果', '降低全音', '延长时值', 'A,C,D');
INSERT INTO question VALUES ('34', '临时变音记号（如♯、♭）的作用范围是？', '23', '1', '1', '全曲', '当前小节', '仅当前音符', '当前拍', 'B');
INSERT INTO question VALUES ('35', '还原号（♮）可以取消调号中的升降号效果。', '23', '1', '3', null, null, null, null, '正确');
INSERT INTO question VALUES ('36', '“E♯”和“F”是同一个音高。', '23', '1', '3', null, null, null, null, '正确');
INSERT INTO question VALUES ('37', '符号“×”表示______，作用是将音符升高______。', '23', '1', '4', null, null, null, null, '重升号，全音');
INSERT INTO question VALUES ('38', '在C大调中，临时标记的F♯需要在下一个小节还原为F时，应使用______记号。', '23', '1', '4', null, null, null, null, '还原号');
INSERT INTO question VALUES ('39', '举例说明“等音异名”的概念及其实际意义。', '23', '1', '5', null, null, null, null, '等音异名指音高相同但记谱名称不同的音（如C♯=D♭），便于不同调性记谱和乐理分析。');
INSERT INTO question VALUES ('40', '临时升降号与调号中的升降号有何区别？', '23', '1', '5', null, null, null, null, '调号：全局生效，作用于所有同名音；\n\n临时升降号：仅当前小节有效，优先级高于调号。');
INSERT INTO question VALUES ('41', '为什么乐谱中需要还原号？请结合演奏场景说明。', '23', '1', '5', null, null, null, null, '还原号用于取消调号或临时升降号的效果，避免演奏者混淆。例如调号为F♯时，临时需演奏F自然音则必须标记♮。\n\n');
INSERT INTO question VALUES ('42', '拍号\"4/4\"中的分母\"4\"表示？', '26', '2', '1', '每小节有4拍', ' 以四分音符为一拍', '每分钟有4拍', '共有4种音符', 'B');
INSERT INTO question VALUES ('44', '下列哪种拍号的强弱规律是\"强-弱-次强-弱\"？', '26', '2', '1', ' 2/4', '3/4', ' 4/4', '6/8', 'C');
INSERT INTO question VALUES ('45', '华尔兹舞曲最常用的拍号是？', '26', '2', '1', '2/4', '3/4', '6/8', '5/4', 'B');
INSERT INTO question VALUES ('46', '拍号\"6/8\"通常理解为？', '26', '2', '1', '每小节6拍，以八分音符为一拍', '每小节2拍，每拍三个八分音符', '每分钟68拍', '6个小节为一乐句', 'B');
INSERT INTO question VALUES ('47', '下列拍号中不属于\"单拍子\"的是？', '26', '2', '2', '4/4', '6/8', '9/8', '12/16', 'B,C,D');
INSERT INTO question VALUES ('48', '拍号\"3/8\"表示每小节有3拍，以八分音符为一拍。', '26', '2', '3', null, null, null, null, '正确');
INSERT INTO question VALUES ('49', '所有拍号的强弱规律都相同。', '26', '2', '3', null, null, null, null, '错误');
INSERT INTO question VALUES ('50', '\"Cut Time\"（2/2拍）的速度比4/4拍快一倍。', '26', '2', '3', null, null, null, null, '错误');
INSERT INTO question VALUES ('51', '拍号上方的数字表示______。', '26', '2', '4', null, null, null, null, '每小节的拍数');
INSERT INTO question VALUES ('52', '复合拍子\"9/8\"可划分为______个\"强-弱-弱\"的三拍组。', '26', '2', '4', null, null, null, null, '3');
INSERT INTO question VALUES ('53', '如何区分\"单拍子\"和\"复合拍子\"？各举一例说明。', '26', '2', '5', null, null, null, null, '单拍子：每小节基本拍数不可分（如2/4、3/4）；\n\n复合拍子：由多个三拍子组成（如6/8=2×3拍，9/8=3×3拍）。');
INSERT INTO question VALUES ('54', '为什么流行音乐最常用4/4拍？', '26', '2', '5', null, null, null, null, '强弱规律稳定（强-弱-次强-弱）；\n\n适合舞蹈节奏；\n\n符合人类自然律动习惯。');
INSERT INTO question VALUES ('55', '分析拍号\"5/4\"的两种常见强弱划分方式及代表作品。', '26', '2', '5', null, null, null, null, '3+2组合：\"强-弱-次强-弱\"（如《Mission Impossible》主题）；\n\n2+3组合：\"强-弱-强-弱-弱\"（如爵士乐《Take Five》）。');

-- ----------------------------
-- Table structure for `question_type`
-- ----------------------------
DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '题型名称',
  `score` int(10) DEFAULT NULL COMMENT '题型分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='题型信息表';

-- ----------------------------
-- Records of question_type
-- ----------------------------
INSERT INTO question_type VALUES ('1', '单选题', '4');
INSERT INTO question_type VALUES ('2', '多选题', '5');
INSERT INTO question_type VALUES ('3', '判断题', '2');
INSERT INTO question_type VALUES ('4', '填空题', '4');
INSERT INTO question_type VALUES ('5', '简答题', '20');

-- ----------------------------
-- Table structure for `score`
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '试卷名称',
  `course_id` int(10) DEFAULT NULL COMMENT '课程ID',
  `teacher_id` int(10) DEFAULT NULL COMMENT '教师ID',
  `student_id` int(10) DEFAULT NULL COMMENT '学生ID',
  `paper_id` int(10) DEFAULT NULL COMMENT '试卷ID',
  `score` int(10) DEFAULT NULL COMMENT '成绩得分',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  `answer` longtext COLLATE utf8mb4_unicode_ci COMMENT '提交结果',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='成绩信息表';

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO score VALUES ('6', '乐理通俗讲解测验1', '20', '1', '1', '6', '42', '已阅卷', '[{\"typeName\":\"单选题\",\"questionId\":12,\"score\":4,\"answer\":\"A\",\"newAnswer\":\"A\"},{\"typeName\":\"单选题\",\"questionId\":9,\"score\":4,\"answer\":\"A\",\"newAnswer\":\"A\"},{\"typeName\":\"单选题\",\"questionId\":10,\"score\":4,\"answer\":\"A\",\"newAnswer\":\"A\"},{\"typeName\":\"判断题\",\"questionId\":13,\"score\":2,\"answer\":\"正确\",\"newAnswer\":\"正确\"},{\"typeName\":\"判断题\",\"questionId\":15,\"score\":2,\"answer\":\"正确\",\"newAnswer\":\"错误\"},{\"typeName\":\"填空题\",\"questionId\":16,\"score\":4,\"answer\":\"全音\",\"newAnswer\":\"全音\"},{\"typeName\":\"填空题\",\"questionId\":17,\"score\":4,\"answer\":\"大三度\",\"newAnswer\":\"大三度\"},{\"typeName\":\"简答题\",\"questionId\":20,\"score\":20,\"answer\":\"大三和弦（如C-E-G）根音到三音为大三度，小三和弦（如C-E♭-G）根音到三音为小三度。\",\"newAnswer\":\"大三和弦（如C-E-G）根音到三音为大三度，小三和弦（如C-E♭-G）根音到三音为小三度。\"},{\"typeName\":\"简答题\",\"questionId\":18,\"score\":20,\"answer\":\"将八度均分为12个半音，使转调和乐器制造标准化，便于音乐创作与演奏。\",\"newAnswer\":\"将八度均分为12个半音。\"}]');
INSERT INTO score VALUES ('7', '音乐拍号测验1', '26', '2', '1', '9', null, '待阅卷', '[{\"typeName\":\"单选题\",\"questionId\":45,\"score\":4,\"answer\":\"B\",\"newAnswer\":\"B\"},{\"typeName\":\"单选题\",\"questionId\":46,\"score\":4,\"answer\":\"B\",\"newAnswer\":\"B\"},{\"typeName\":\"多选题\",\"questionId\":47,\"score\":5,\"answer\":\"B,C,D\",\"newAnswer\":\"B,C,D\"},{\"typeName\":\"判断题\",\"questionId\":48,\"score\":2,\"answer\":\"正确\",\"newAnswer\":\"正确\"},{\"typeName\":\"判断题\",\"questionId\":50,\"score\":2,\"answer\":\"错误\",\"newAnswer\":\"错误\"},{\"typeName\":\"填空题\",\"questionId\":52,\"score\":4,\"answer\":\"3\",\"newAnswer\":\"3\"},{\"typeName\":\"简答题\",\"questionId\":53,\"score\":20,\"answer\":\"单拍子：每小节基本拍数不可分（如2/4、3/4）；\\n\\n复合拍子：由多个三拍子组成（如6/8=2×3拍，9/8=3×3拍）。\",\"newAnswer\":\"单拍子：每小节基本拍数不可分（如2/4、3/4）；\\n\\n复合拍子：由多个三拍子组成（如6/8=2×3拍，9/8=3×3拍）。\"},{\"typeName\":\"简答题\",\"questionId\":54,\"score\":20,\"answer\":\"强弱规律稳定（强-弱-次强-弱）；\\n\\n适合舞蹈节奏；\\n\\n符合人类自然律动习惯。\",\"newAnswer\":\"强弱规律稳定（强-弱-次强-弱）；\\n\"}]');

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  `mycourse_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='学生信息表';

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO student VALUES ('1', 'zhangsan', '123456', '张三', 'http://localhost:8080/files/download/1745223568535-avatat1.jpg', 'STUDENT', '18899990000', 'zhangsan@xm.com', '审核通过', null);
INSERT INTO student VALUES ('2', 'lisi', '123456', '李四', 'http://localhost:8080/files/download/1745223585879-avatar2.jpg', 'STUDENT', '18899995555', 'lisi@xm.com', '审核通过', null);
INSERT INTO student VALUES ('3', 'wangwu', '123456', '王五', 'http://localhost:8080/files/download/1745223595594-avatar3.jpg', 'STUDENT', '18844445555', 'wangwu@xm.com', '审核通过', null);
INSERT INTO student VALUES ('4', 'zhaoliu', '123456', '赵六', 'http://localhost:8080/files/download/1745223603344-avatar4.jpg', 'STUDENT', null, null, '待审核', null);
INSERT INTO student VALUES ('5', 'lihao', '123456', '李好', 'http://localhost:8080/files/download/1745223629198-avatar6.jpg', 'STUDENT', null, null, '审核不通过', null);

-- ----------------------------
-- Table structure for `student_course`
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) NOT NULL COMMENT '学生ID',
  `course_id` bigint(20) NOT NULL COMMENT '课程ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_student_course` (`student_id`,`course_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='学生学习课程表';

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO student_course VALUES ('12', '1', '21', '2025-04-23 17:14:19');
INSERT INTO student_course VALUES ('13', '1', '35', '2025-04-23 17:15:26');
INSERT INTO student_course VALUES ('14', '1', '20', '2025-04-23 17:20:44');
INSERT INTO student_course VALUES ('16', '1', '23', '2025-04-23 23:03:49');
INSERT INTO student_course VALUES ('17', '1', '26', '2025-04-23 23:19:19');
INSERT INTO student_course VALUES ('20', '3', '21', '2025-04-25 21:28:02');

-- ----------------------------
-- Table structure for `teacher`
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='教师信息表';

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO teacher VALUES ('1', 'zhang', '123456', '张老师', 'http://localhost:8080/files/download/1745223529432-zhangteacheravatar.jpg', 'TEACHER', '18800001111', 'zhang@xm.com');
INSERT INTO teacher VALUES ('2', 'li', '123456', '李老师', 'http://localhost:8080/files/download/1745223536989-liteacheravatar.jpg', 'TEACHER', '18877776666', 'li@xm.com');
INSERT INTO teacher VALUES ('3', 'wang', '123456', '王老师', 'http://localhost:8080/files/download/1745223543954-wangteacheravatar.jpg', 'TEACHER', null, null);

-- ----------------------------
-- Table structure for `test_paper`
-- ----------------------------
DROP TABLE IF EXISTS `test_paper`;
CREATE TABLE `test_paper` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '试卷名称',
  `course_id` int(10) DEFAULT NULL COMMENT '课程ID',
  `teacher_id` int(10) DEFAULT NULL COMMENT '教师ID',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型',
  `start` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开始时间',
  `end` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结束时间',
  `time` int(10) DEFAULT NULL COMMENT '考试时长',
  `question_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '题目IDs',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='试卷信息表';

-- ----------------------------
-- Records of test_paper
-- ----------------------------
INSERT INTO test_paper VALUES ('6', '乐理通俗讲解测验1', '20', '1', '自动组卷', '2025-04-10', '2025-05-31', '40', '[12,9,10,13,15,16,17,20,18]');
INSERT INTO test_paper VALUES ('7', '为什么要学乐理？测验1', '21', '1', '手动选题', '2025-04-13', '2025-05-30', '30', '[21,22,23,24,27,29,31]');
INSERT INTO test_paper VALUES ('8', '升降号、还原号测验1', '23', '1', '手动选题', '2025-04-02', '2025-04-11', '30', '[32,33,34,35,36,37,38,39]');
INSERT INTO test_paper VALUES ('9', '音乐拍号测验1', '26', '2', '手动选题', '2025-04-02', '2025-05-31', '20', '[45,46,47,48,50,52,53,54]');
