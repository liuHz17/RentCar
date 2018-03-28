SET NAMES UTF8;
DROP DATABASE IF EXISTS zuche;
CREATE DATABASE zuche CHARSET=UTF8;
USE zuche;

/**车型家族**/
CREATE TABLE zc_cars_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,
  fname VARCHAR(32)
);

/**可选车型**/
CREATE TABLE zc_cars(
  cid INT PRIMARY KEY AUTO_INCREMENT,  #车型编号
  fid INT,              #所属型号家族编号
  title VARCHAR(128),         #主标题
  price DECIMAL(6,2),        #日租价格
  spec VARCHAR(64),           #规格/颜色 如：2.4自动/黑色
  boxes VARCHAR(8),                   #厢数/mpv、
  capacity INT,                #准乘人数
  is_hire BOOLEAN,             #是否租满
  is_onsale BOOLEAN,          #是否促销中
  sold_count INT,             #已售出的数量
  promise VARCHAR(64)        #服务承诺

);

/**车型图片**/
CREATE TABLE zc_cars_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT, #图片编号
  cid INT,              #车型编号
  sm VARCHAR(128),            #小图片路径
  md VARCHAR(128),            #中图片路径
  lg VARCHAR(128)             #大图片路径
);

/**用户信息**/
CREATE TABLE zc_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),

  user_name VARCHAR(32),      #用户名，如王小明
  gender INT                  #性别  0-女  1-男
);

/**收货地址信息**/
CREATE TABLE zc_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  uid INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签名

  is_default BOOLEAN          #是否为当前用户的默认收货地址
);

/**购物车条目**/
CREATE TABLE zc_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  uid INT,      #用户编号
  cid INT,   #车型编号
  count INT,        #购买数量
  is_checked BOOLEAN #是否已勾选，确定购买
);

/**用户订单**/
CREATE TABLE zc_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  uid INT,
  aid INT,
  status INT,             #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT    #签收时间
);

/**用户订单**/
CREATE TABLE zc_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  oid INT,           #订单编号
  cid INT,         #车型编号
  count INT               #购买数量
);

/****首页轮播广告商品****/
CREATE TABLE zc_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,  #车型编号
  img VARCHAR(128),
  title VARCHAR(64),
  href VARCHAR(128)
);

/****首页商品****/
CREATE TABLE zc_index_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),
  details VARCHAR(128),
  pic VARCHAR(128),
  price DECIMAL(10,2),
  href VARCHAR(128),
  seq_recommended TINYINT,
  seq_new_arrival TINYINT,
  seq_top_sale TINYINT
);
/******数据导入******/

/**家族**/
INSERT INTO zc_cars_family VALUES
(1,'奥迪'),
(2,'宝马'),
(3,'本田'),
(4,'标致'),
(5,'别克'),
(6,'长安轿车'),
(7,'比亚迪'),
(8,'大众'),
(9,'丰田'),
(10,'现代'),
(11,'起亚'),
(12,'马自达'),
(13,'雪佛兰'),
(14,'雪铁龙'),
(15,'福特'),
(16,'红旗'),
(17,'斯柯达'),
(18,'凯迪拉克'),
(19,'广汽'),
(20,'上汽大通'),
(21,'斯玛特'),
(22,'帝豪'),
(23,'福田'),
(24,'时代');

/**可选车型信息**/
INSERT INTO zc_cars VALUES
(1,1,'奥迪A6','699','2.4自动/黑色','3厢',5,false,false,10,'免费送取车*快速办理*24小时服务'),
(2,4,'标致308S','99','1.2自动/银光蓝','2厢',5,false,false,10,'免费送取车*快速办理*24小时服务'),
(3,4,'标致3008','269','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(4,5,'别克凯越','89','1.5自动/白色','3厢',5,false,false,90,'免费送取车*快速办理*24小时服务'),
(5,5,'别克英朗2016进取型','110','1.5自动/酷灰','3厢',5,false,false,10,'免费送取车*快速办理*24小时服务'),
(6,5,'别克GL82010舒适型','399','2.4自动/银光蓝','MPV',7,false,false,1,'免费送取车*快速办理*24小时服务'),
(7,5,'别克昂科拉2016领先型','188','1.4自动/白色','SUV',5,true,false,15,'免费送取车*快速办理*24小时服务'),
(8,7,'比亚迪','164','1.6自动/蓝','3厢',5,false,false,18,'免费送取车*快速办理*24小时服务'),
(9,8,'大众朗逸','129','1.6自动/白','3厢',5,false,false,30,'免费送取车*快速办理*24小时服务'),
(10,8,'大众新捷达','69','1.4手动/蓝','3厢',5,false,false,3,'免费送取车*快速办理*24小时服务'),
(11,8,'大众帕萨特2014舒适型','269','1.8自动/黑色','2',5,false,false,2,'免费送取车*快速办理*24小时服务'),
(12,8,'大众高尔夫','169','1.6自动/白色','2厢',5,false,false,7,'免费送取车*快速办理*24小时服务'),
(13,8,'大众捷达手动挡','59','1.4手动/白色','3厢',5,false,false,16,'免费送取车*快速办理*24小时服务'),
(14,8,'大众途观2012都会版','366','1.8自动/黑色','SUV',5,true,false,23,'免费送取车*快速办理*24小时服务'),
(15,9,'丰田威驰','109','1.5自动/红色','3厢',5,false,false,20,'免费送取车*快速办理*24小时服务'),
(16,9,'丰田凯美瑞','266','2.0自动/黑色','SUV',5,true,false,10,'免费送取车*快速办理*24小时服务'),
(17,9,'丰田志炫','220','1.3自动/白色','2厢',5,true,false,33,'免费送取车*快速办理*24小时服务'),
(18,9,'丰田花冠','131','1.6自动/白色','3厢',5,true,false,45,'免费送取车*快速办理*24小时服务'),
(19,10,'现代IX35','229','2.0自动/白色','SUV',5,true,false,6,'免费送取车*快速办理*24小时服务'),
(20,11,'起亚K2','119','1.4自动/红色','3厢',5,false,false,60,'免费送取车*快速办理*24小时服务'),
(21,12,'马自达','99','1.2自动/银光蓝','2',5,false,false,88,'免费送取车*快速办理*24小时服务'),
(22,13,'雪佛兰科鲁兹','140','1.5自动/红色','3厢',5,false,false,99,'免费送取车*快速办理*24小时服务'),
(23,13,'雪佛兰新科鲁兹2017先锋天窗型','160','1.5自动/红色','3厢',5,false,false,103,'免费送取车*快速办理*24小时服务'),
(24,14,'雪铁龙新爱丽舍','166','1.6自动/银','3厢',5,false,false,100,'免费送取车*快速办理*24小时服务'),
(25,15,'福特','99','1.2自动/银光蓝','2',5,false,false,15,'免费送取车*快速办理*24小时服务'),
(26,16,'红旗','99','1.2自动/银光蓝','2',5,false,false,12,'免费送取车*快速办理*24小时服务'),
(27,17,'斯柯达','99','1.2自动/银光蓝','2',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(28,18,'凯迪拉克','99','1.2自动/银光蓝','2',5,false,false,5,'免费送取车*快速办理*24小时服务'),
(29,19,'广汽','99','1.2自动/银光蓝','2',5,false,false,8,'免费送取车*快速办理*24小时服务'),
(30,20,'上汽大通G10-5座','219','2.0自动/银白色','MPV',5,false,false,7,'免费送取车*快速办理*24小时服务'),
(31,2,'宝马x5','321','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(32,2,'宝马x7','300','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(33,3,'本田','269','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(34,3,'本田','249','2.0自动/黑色','SUV',5,false,false,12,'免费送取车*快速办理*24小时服务'),
(35,3,'本田','269','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(36,6,'长安轿车','150','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(37,6,'长安轿车','150','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(38,6,'长安轿车','150','2.0自动/白色','SUV',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(39,20,'上汽大通G10','199','2.0自动/银白色','MPV',7,false,false,5,'免费送取车*快速办理*24小时服务'),
(40,21,'福特','99','1.2自动/银光蓝','2',5,false,false,15,'免费送取车*快速办理*24小时服务'),
(41,22,'红旗','99','1.2自动/银光蓝','2',5,false,false,12,'免费送取车*快速办理*24小时服务'),
(42,23,'斯柯达','99','1.2自动/银光蓝','2',5,false,false,11,'免费送取车*快速办理*24小时服务'),
(43,24,'广汽','99','1.2自动/银光蓝','2',5,false,false,8,'免费送取车*快速办理*24小时服务');
INSERT INTO zc_user VALUES
(1,"zhangdi","zd123456","zhangdi@163.com","13542361122","张帝","0"),
(2,"lihua","li123456","lihua@163.com","13512561122","李华","0"),
(3,"wangwang","ww123456","wangwang@163.com","13127861122","王旺","0"),
(4,"dangdang","dd123456","dang@163.com","13541215122","林丹","1"),
(5,"huahuai","hh123456","hua@163.com","13542361125","黄华","1"),
(6,"dahuang","ddd123456","huang@163.com","13542364589","黄磊","0"),
(8,"dingding","123456","dingding@163.com","13542364449","丁丁","0"),
(7,"leizi","zd123456","leizi@163.com","13542364523","雷东","0");

/****首页轮播广告商品信息****/
INSERT INTO `zc_index_carousel` VALUES ('9', 'img/index/banner1.png', '轮播广告商品1', 'product_details.html?lid=28');
INSERT INTO `zc_index_carousel` VALUES ('10', 'img/index/banner2.png', '轮播广告商品2', 'product_details.html?lid=19');

/**车型图片信息**/
INSERT INTO zc_cars_pic VALUES
(NULL, 13, 'img/products/sm/2017KLZ.jpg','img/products/md/2017KLZ.jpg','img/products/lg/2017KLZ.jpg'),
(NULL, 1, 'img/products/sm/aodi_A6.jpg','img/products/md/aodi_A6.jpg','img/products/lg/aodi_A6.jpg'),
(NULL, 2, 'img/products/sm/bm.jpg','img/products/md/bm.jpg','img/products/lg/bm.jpg'),
(NULL, 2, 'img/products/sm/bm1.jpg','img/products/md/bm1.jpg','img/products/lg/bm1.jpg'),
(NULL, 2, 'img/products/sm/bm2.jpg','img/products/md/bm2.jpg','img/products/lg/bm2.jpg'),
(NULL, 7, 'img/products/sm/kmrui.jpg','img/products/md/kmrui.jpg','img/products/lg/kmrui.jpg'),
(NULL, 7, 'img/products/sm/kmrui1.jpg','img/products/md/kmrui1.jpg','img/products/lg/kmrui1.jpg'),
(NULL, 3, 'img/products/sm/bentian.jpg','img/products/md/bentian.jpg','img/products/lg/bentian.jpg'),
(NULL, 3, 'img/products/sm/bentian1.jpg','img/products/md/bentian1.jpg','img/products/lg/bentian1.jpg'),
(NULL, 3, 'img/products/sm/kmrui2.jpg','img/products/md/kmrui2.jpg','img/products/lg/kmrui2.jpg'),
(NULL, 4, 'img/products/sm/bieke-gl1.jpg','img/products/md/bieke-gl1.jpg','img/products/lg/bieke-gl1.jpg'),
(NULL, 4, 'img/products/sm/bieke-gl2.jpg','img/products/md/bieke-gl2.jpg','img/products/lg/bieke-gl2.jpg'),
(NULL, 5, 'img/products/sm/bieke_angkela1.jpg','img/products/md/bieke_angkela1.jpg','img/products/lg/bieke_angkela1.jpg'),
(NULL, 5, 'img/products/sm/bieke_angkela2.jpg','img/products/md/bieke_angkela2.jpg','img/products/lg/bieke_angkela2.jpg'),
(NULL, 5, 'img/products/sm/bieke_angkela3.jpg','img/products/md/bieke_angkela3.jpg','img/products/lg/bieke_angkela3.jpg'),
(NULL, 5, 'img/products/sm/bieke-gl1.jpg','img/products/md/bieke-gl1.jpg','img/products/lg/bieke-gl1.jpg'),
(NULL, 5, 'img/products/sm/bieke-gl2.jpg','img/products/md/bieke-gl2.jpg','img/products/lg/bieke-gl2.jpg'),
(NULL, 5, 'img/products/sm/bieke-gl3.jpg','img/products/md/bieke-gl3.jpg','img/products/lg/bieke-gl3.jpg'),
(NULL, 6, 'img/products/sm/cn.jpg','img/products/md/cn.jpg','img/products/lg/cn.jpg'),
(NULL, 6, 'img/products/sm/cn1.jpg','img/products/md/cn1.jpg','img/products/lg/cn1.jpg'),
(NULL, 6, 'img/products/sm/cn2.jpg','img/products/md/cn2.jpg','img/products/lg/cn2.jpg'),
(NULL, 8, 'img/products/sm/dazhong_langyi1.jpg','img/products/md/dazhong_langyi1.jpg','img/products/lg/dazhong_langyi1.jpg'),
(NULL, 8, 'img/products/sm/dazhong_langyi2.jpg','img/products/md/dazhong_langyi2.jpg','img/products/lg/dazhong_langyi2.jpg'),
(NULL, 9, 'img/products/sm/kmrui.jpg','img/products/md/kmrui.jpg','img/products/lg/kmrui.jpg'),
(NULL, 9, 'img/products/sm/kmrui1.jpg','img/products/md/kmrui1.jpg','img/products/lg/kmrui1.jpg'),
(NULL, 9, 'img/products/sm/kmrui2.jpg','img/products/md/kmrui2.jpg','img/products/lg/kmrui2.jpg'),
(NULL, 11, 'img/products/sm/qya1.jpg','img/products/md/qya1.jpg','img/products/lg/bieke-gl3.jpg'),
(NULL, 11, 'img/products/sm/qya2.jpg','img/products/md/qya2.jpg','img/products/lg/dazhong_langyi1.jpg'),
(NULL, 11, 'img/products/sm/qya3.jpg','img/products/md/qya3.jpg','img/products/lg/dazhong_langyi2.jpg'),
(NULL, 13, 'img/products/sm/2017KLZ1.jpg','img/products/md/2017KLZ1.jpg','img/products/lg/2017KLZ1.jpg'),
(NULL, 14, 'img/products/sm/aodi_A6.jpg','img/products/md/aodi_A6.jpg','img/products/lg/aodi_A6.jpg'),
(NULL, 15, 'img/products/sm/bm.jpg','img/products/md/bm.jpg','img/products/lg/bm.jpg'),
(NULL, 16, 'img/products/sm/bentian.jpg','img/products/md/bentian.jpg','img/products/lg/bentian.jpg'),
(NULL, 17, 'img/products/sm/bieke-gl2.jpg','img/products/md/bieke-gl2.jpg','img/products/lg/bieke-gl2.jpg'),
(NULL, 18, 'img/products/sm/bieke_angkela1.jpg','img/products/md/bieke_angkela1.jpg','img/products/lg/bieke_angkela1.jpg'),
(NULL, 19, 'img/products/sm/cn.jpg','img/products/md/cn.jpg','img/products/lg/cn.jpg'),
(NULL, 20, 'img/products/sm/kmrui.jpg','img/products/md/kmrui.jpg','img/products/lg/kmrui.jpg'),
(NULL, 21, 'img/products/sm/bieke_angkela3.jpg','img/products/md/bieke_angkela3.jpg','img/products/lg/bieke_angkela3.jpg'),
(NULL, 22, 'img/products/sm/bieke-gl1.jpg','img/products/md/bieke-gl1.jpg','img/products/lg/bieke-gl1.jpg'),
(NULL, 23, 'img/products/sm/bieke-gl2.jpg','img/products/md/bieke-gl2.jpg','img/products/lg/bieke-gl2.jpg'),
(NULL, 24, 'img/products/sm/bieke-gl3.jpg','img/products/md/bieke-gl3.jpg','img/products/lg/bieke-gl3.jpg'),
(NULL, 25, 'img/products/sm/cn.jpg','img/products/md/cn.jpg','img/products/lg/cn.jpg'),
(NULL, 26, 'img/products/sm/cn1.jpg','img/products/md/cn1.jpg','img/products/lg/cn1.jpg'),
(NULL, 27, 'img/products/sm/cn2.jpg','img/products/md/cn2.jpg','img/products/lg/cn2.jpg'),
(NULL, 28, 'img/products/sm/dazhong_langyi1.jpg','img/products/md/dazhong_langyi1.jpg','img/products/lg/dazhong_langyi1.jpg'),
(NULL, 29, 'img/products/sm/dazhong_langyi2.jpg','img/products/md/dazhong_langyi2.jpg','img/products/lg/dazhong_langyi2.jpg'),
(NULL, 30, 'img/products/sm/kmrui.jpg','img/products/md/kmrui.jpg','img/products/lg/kmrui.jpg'),
(NULL, 31, 'img/products/sm/kmrui1.jpg','img/products/md/kmrui1.jpg','img/products/lg/kmrui1.jpg'),
(NULL, 32, 'img/products/sm/kmrui2.jpg','img/products/md/kmrui2.jpg','img/products/lg/kmrui2.jpg'),
(NULL, 33, 'img/products/sm/kmrui2.jpg','img/products/md/kmrui2.jpg','img/products/lg/kmrui2.jpg'),
(NULL, 34, 'img/products/sm/qya1.jpg','img/products/md/qya1.jpg','img/products/lg/bieke-gl3.jpg'),
(NULL, 35, 'img/products/sm/qya2.jpg','img/products/md/qya2.jpg','img/products/lg/dazhong_langyi1.jpg'),
(NULL, 36, 'img/products/sm/qya3.jpg','img/products/md/qya3.jpg','img/products/lg/dazhong_langyi2.jpg'),
(NULL, 37, 'img/products/sm/2017KLZ1.jpg','img/products/md/2017KLZ1.jpg','img/products/lg/2017KLZ1.jpg'),
(NULL, 38, 'img/products/sm/aodi_A6.jpg','img/products/md/aodi_A6.jpg','img/products/lg/aodi_A6.jpg'),
(NULL, 39, 'img/products/sm/bm.jpg','img/products/md/bm.jpg','img/products/lg/bm.jpg'),
(NULL, 40, 'img/products/sm/bentian.jpg','img/products/md/bentian.jpg','img/products/lg/bentian.jpg'),
(NULL, 41, 'img/products/sm/bieke-gl2.jpg','img/products/md/bieke-gl2.jpg','img/products/lg/bieke-gl2.jpg'),
(NULL, 42, 'img/products/sm/bieke_angkela1.jpg','img/products/md/bieke_angkela1.jpg','img/products/lg/bieke_angkela1.jpg'),
(NULL, 43, 'img/products/sm/cn.jpg','img/products/md/cn.jpg','img/products/lg/cn.jpg'),
(NULL, 44, 'img/products/sm/kmrui2.jpg','img/products/md/kmrui2.jpg','img/products/lg/kmrui2.jpg'),
(NULL, 45, 'img/products/sm/kmrui2.jpg','img/products/md/kmrui2.jpg','img/products/lg/kmrui2.jpg'),
(NULL, 46, 'img/products/sm/qya1.jpg','img/products/md/qya1.jpg','img/products/lg/bieke-gl3.jpg'),
(NULL, 47, 'img/products/sm/qya2.jpg','img/products/md/qya2.jpg','img/products/lg/dazhong_langyi1.jpg'),
(NULL, 48, 'img/products/sm/qya3.jpg','img/products/md/qya3.jpg','img/products/lg/dazhong_langyi2.jpg'),
(NULL, 49, 'img/products/sm/2017KLZ1.jpg','img/products/md/2017KLZ1.jpg','img/products/lg/2017KLZ1.jpg'),
(NULL, 50, 'img/products/sm/aodi_A6.jpg','img/products/md/aodi_A6.jpg','img/products/lg/aodi_A6.jpg'),
(NULL, 23, 'img/products/sm/2017KLZ3.jpg','img/products/md/2017KLZ3.jpg','img/products/lg/2017KLZ3.jpg');

