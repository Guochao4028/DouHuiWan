//
//  DefinedURLs.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 郭超. All rights reserved.
//

#ifndef DefinedURLs_h
#define DefinedURLs_h

//是否是内网版本
//注释 切换内外网
#define IsInsideNewWork YES

#ifdef IsInsideNewWork
//测试环境 主域名
//#define Host @"http://112.126.118.9:8585/redlotus-web/"


#define Host @"http://api.5138fun.com:8888/alyg-web"


//#define Host @"http://192.168.0.110:8080/alyg-web"

#else
//正式环境 主域名
#define Host  @"http://api.5138fun.com:8888/alyg-web"

#endif

#define ADD(x) [NSString stringWithFormat:@"%@%@",Host,(x)]
//手机号登录接口 & 手机号注册接口
#define URL_POST_CUSTOMER_CUSTOMERREGISTER @"/customer/customerRegister"

//微信接口
#define URL_POST_WEIXIN_GETWEIXINOPENID @"/weixin/getWeixinOpenid"

//验证码接口
#define URL_POST_CUSTOMER_SENDSMS @"/customer/sendSms"

//商品收藏接口
#define URL_POST_CUSTOMER_FAVORITE @"/customer/favorite"

///获取分类数据
#define URL_POST_THIRD_CATEGORYINFO @"/thirdParty/categoryInfoByIos"

//首页查询
#define URL_POST_IMSCATEGOORY_HOMEPAGE @"/imsCategory/homePage"

//首页列表
#define URL_POST_THIRDPARTY_TBKITENCOUPONGET @"/thirdParty/tbkitemCouponget"

//商品详情
#define URL_POST_DINGDANXIE_DDXIAIDPRIVILEGE @"/dingdanxia/ddxiaIdPrivilege"

//分类商品列表
#define URL_POST_THIRDPARTY_TBKITEMCOUPONGET @"/thirdParty/tbkitemCouponget"

//查询接口
#define  URL_POST_THIRDPARTY_TBKMATERIALGET @"/thirdParty/tbkmaterialGet"

//淘宝授权接口(h5)
#define URL_POST_WEIXIN_TBWAPOAUTH   @"/weixin/tbkWapOauth"
//淘宝授权接口(ios)
#define URL_POST_WEIXIN_TBOAUTH   @"/weixin/tbkOauth"

//微信登录
#define URL_POST_WEIXIN_GETWEIXINOPENID  @"/weixin/getWeixinOpenid"

//微信授权登录
#define URL_POST_WEIXIN_GETWEIXINCUSTOMERINFO  @"/weixin/getWeixinCustomerInfo"

//收藏列表
#define URL_POST_CUSTOMER_FAVORITELIST @"/customer/favoriteList"

//收藏
#define URL_POST_CUSTOMER_FAVORITE @"/customer/favorite"

//判断商品是否收藏
#define URL_POST_CUSTOMER_FAVORITECHECK  @"/customer/favoriteCheck"

//我的订单
#define URL_POST_CUSTOMER_ORDERS  @"/customer/orders"

//查询粉丝
#define URL_POST_CUSTOMER_MYFANS  @"/customer/myfans"

//修改手机号
#define URL_POST_CUSTOMER_MODIFYCUSTOMERPHONE  @"/customer/modifyCustomerPhone"


//查询个人信息
#define URL_POST_CUSTOMER_CUSTOMERINFO  @"/customer/customerInfo"

//通过code调接口获取oepnId
#define URL_POST_WEIXIN_JSCONTROLLER @"/weixin/jsController"


//申请提现
#define URL_POST_ACCOUNT_APPLYTOALIACCOUNT  @"/account/applyToAliAccount"


//申请提现
#define URL_POST_CUSTOMER_EXTRACT_LIST  @"/customer/extract/list"

//收益报表
#define URL_POST_CUSTOMER_FEE_DETAIL  @"/customer/fee/detail"

//淘口令查询
#define URL_POST_THIRDPARTY_TKL_QUERY @"/thirdParty/tklQuery"
//店铺信息
#define URL_POST_DINGDANXIA_SHOPWDETAIL @"/dingdanxia/shopWdetail"

//淘宝客精选
#define URL_POST_DINGDANXIA_FEATUREDCPY @"/dingdanxia/featuredCpy"

//淘宝客防屏蔽发单二维码生成
#define URL_POST_DINGDANXIA_TBKTKQRCODE @"/dingdanxia/tbkTkQrcode"

//解绑淘宝
#define URL_POST_CUSTOMER_UNBIND  @"/customer/unbind"

//top 100
#define URL_POST_DINGDANXIA_TABKTOP100  @"/dingdanxia/tbkTop100"

//9.9包邮
#define URL_POST_DINGDANXIA_TABKSPKJIUKUAIJIU  @"/dingdanxia/tbkspkJiukuaijiu"

//限时抢购
#define URL_POST_DINGDANXIA_DDXIASPKQQIANG  @"/dingdanxia/ddxiaSpkQqiang"

//猜你喜欢
#define URL_POST_DINGDANXIA_TBKOPTIMUS  @"/dingdanxia/tbkOptimus"

//添加足迹
#define URL_POST_CUSTOMER_FOOTPRINT  @"/customer/footprint"

//足迹列表
#define URL_POST_CUSTOMER_FOOTPRINTLIST  @"/customer/footprintList"

//上传头像
#define URL_POST_IMSCATEGORY_UPAVATAR  @"/imsCategory/upavatar"

//常见问题
#define URL_POST_COMMON_PROBLEM_LIST @"/common/problem/list"

//获取用户渠道id
#define URL_POST_CUSTOMER_CUSTOMERRELATION @"/customer/customerRelation"

//开机屏广告
#define  URL_POST_SETTING_ADCONFIG    @"/setting/adconfig"

//推荐好物
#define  URL_POST_TCOMMODITYRECOMMEND_LIST   @"/tcommodityrecommend/list"

//品牌清仓
#define  URL_POST_DINGDANXIA_TBKOPTIMUS  @"/dingdanxia/tbkOptimus"

//绑定设备
#define  URL_POST_SETTING_BINDDEVICE    @"/setting/bindDevice"

//活动公告
#define  URL_POST_SETTING_NOTIFICATIONACTIVITY    @"/setting/notificationActivity"

//好物推荐
#define  URL_POST_SETTING_NOTIFICATIONCOMMODITY    @"/setting/notificationCommodity"

//系统通告
#define  URL_POST_SETTING_NOTIFICATIONSYSTEM    @"/setting/notificationSystem"

//消息信息 是否有新消息
#define  URL_POST_SETTING_NOTIFICATIONINFO    @"/setting/notificationInfo"

//读取消息
#define  URL_POST_SETTING_NOTIFICATIONSAVE    @"/setting/notificationSave"

//查询商品目录列表
#define URL_POST_DDK_GOODS_CATS   @"/ddk/goods/cats"

//查询标签列表
#define URL_POST_DDK_GOODS_OPT   @"/ddk/goods/opt"

//绑定推广位
#define URL_POST_DDK_PID_GENERATE @"/ddk/pid/generate"

//查询商品列表
#define URL_POST_DDK_GOODS_SEARCH  @"/ddk/goods/search"

//拼多多 商品详情
#define URL_POST_DDK_GOODS_DETAIL   @"/ddk/goods/detail"

//商品推广链接
#define URL_POST_DDK_GOODS_PROM   @"/ddk/goods/prom"

//京东 商品类目
#define URL_POST_JDLM_GOODS_CATEGORY   @"/jdlm/goods/category"

//京东 关键词商品查询接口
#define URL_POST_JDLM_GOODS_QUERY   @"/jdlm/goods/query"

//京东 获取推广链接
#define URL_POST_JDLM_GOODS_BYUNIONID   @"/jdlm/goods/byunionid"

//京东 用户绑定京东推广位
#define URL_POST_JDLM_GOODS_PIDBIND   @"/jdlm/pid/pidBind"

//淘礼金
#define URL_POST_THIRDPARTY_TLJ      @"/thirdParty/tlj"

//商品分类-京东
#define URL_POST_THIRDPARTY_CATEGORY_INFO    @"/thirdParty/category/info"

//强制更新配置
#define URL_POST_SETTING_SETUPDATECONFIG   @"/setting/setUpdateConfig"

//ios显示配置设置
#define  URL_POST_THIRDPARTY_SHOWCONFIG    @"/thirdParty/showconfig"

//功能显示配置
#define  URL_POST_SETTING_BANNERCONFIG     @"/setting/bannerconfig"

//数据字典查询
#define URL_POST_DIRC_SEARCH     @"/dirc/search"

//订单找回
#define URL_POST_THIRDPARTY_FINDORDER    @"/thirdParty/findOrder"

#define URL_POST_BUSINESS_ADD    @"/business/add"


#endif /* DefinedURLs_h */
