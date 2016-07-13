//
//  ApiDefine.h
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#ifndef ApiDefine_h
#define ApiDefine_h

#define DEF_IPAddress       @"http://api.88art.com"
#define UPLOAD_IPAddress    @"http://upload.88art.com"
//#define DEF_IPAddress         @"http://localtest.88art.com"

#pragma mark ------------------------------------Member-----------------------------------
#define k_Member_Login            @"v1.1/Api/Member/Login"              //用户登录
#define k_Member_InfoArtist       @"v1.1/Api/Member/InfoArtist"         //艺术家个人中心
#define k_Member_InfoNormal       @"v1.1/Api/Member/InfoNormal"         //普通用户个人中心
#define k_mine_infoupload         @"v1.1/Api/Member/InfoUpload"         //资料上传
#define k_mine_infodownload       @"v1.1/Api/Member/InfoDownload"       //资料下载
#define k_mine_getauthcode        @"v1.1/Api/Member/GetAuthCode"        //获取验证码
#define k_mine_loginpwdchange     @"v1.1/Api/Member/LoginPwdChange"     //修改登录密码
#define k_mine_loginpwdsetting    @"v1.1/Api/Member/LoginPwdSetting"    //设置登录密码

#pragma mark -----------------------------------发现首页---------------------------------
#define k_find_home_content    @"v1.1/Api/Page/Home"                 //发现首页的内容




#pragma mark ------------------------------------艺术品-----------------------------------
#pragma mark ------------------------------------艺术家-----------------------------------
#pragma mark ------------------------------------资讯------------------------------------
#pragma mark ------------------------------------购物车-----------------------------------
#pragma mark ------------------------------------登录-------------------------------------
#define k_find_homepage           @"v1/find/homepage"             //手机号登陆
#define k_find_artdetail          @"v1/find/artdetail"            //艺术品详情
#define k_find_putintocart        @"v1/find/putintocart"          //加入购物车
#define k_find_orderconfir        @"v1/find/orderconfir"          //订单确认
//----------------------------------------------------------------------------
#define k_mine_shopcart           @"v1/mine/shopcart"             //购物车
#define k_mine_collection         @"v1/mine/collection"           //收藏列表
#define k_mine_focus              @"v1/mine/focus"                //关注
#define k_mine_funs               @"v1/mine/funs"                 //粉丝
#define k_mine_deletecart         @"v1/mine/deletecart"           //购物车删除
#define k_mine_deleteaddress      @"v1/mine/deleteaddress"        //删除地址
#define k_mine_creataddress       @"v1/mine/creataddress"         //创建新地址
#define k_mine_addresses          @"v1/mine/addresses"            //地址列表
#define k_mine_addressdownload    @"v1/mine/addressdownload"      //地址修改download
#define k_mine_addressupload      @"v1/mine/addressupload"        //地址修改upload
#define k_mine_phonecerti         @"v1/mine/phonecerti"           //艺术家手机认证
#define k_mine_infocerti          @"v1/mine/infocerti"            //艺术家信息认证
#define k_mine_feedback           @"v1/mine/feedback"             //反馈意见
#define k_mine_login              @"v1/mine/login"                //登录
#define k_mine_register           @"v1/mine/register"             //注册
#define k_mine_getbackpwd         @"v1/mine/getbackpwd"           //找回密码
#define k_artist_homepage         @"v1/artist/homepage"           //艺术家首页
#define k_artist_focus            @"v1/artist/focus"              //艺术家关注
#define k_artist_chamber          @"v1/artist/chamber"            //艺术家详情
#define k_artist_artworks         @"v1/artist/artworks"           //艺术家作品集
#define k_find_artistsearch       @"v1/find/artistsearch"         //艺术家搜索
#define k_find_artsearch          @"v1/find/artsearch"            //艺术品搜索
#define k_find_getorderno         @"v1/find/ordergenerator"       //获取订单号
#define k_mine_bindconfir         @"v1/mine/bindconfir"           //绑定手机号验证码
#define k_mine_bindresetpwd       @"v1/mine/bindresetpwd"         //绑定重置密码
#define k_mine_thirdlogin         @"v1/mine/thirdlogin"           //第三方登录
#define k_find_artlike            @"v1/find/artlike"              //艺术品收藏
#define k_mine_refundupload       @"v1/mine/refundupload"         //申请退款
#define k_mine_refunddetail       @"v1/mine/refunddetail"         //退款详情
#define k_mine_orderdetail        @"v1/mine/orderdetail"          //订单详情
#define k_mine_orderlist          @"v1/mine/orderlist"            //订单列表
#define k_mine_closetrade         @"v1/mine/closetrade"           //关闭交易
#define k_mine_affirmreceive      @"v1/mine/affirmreceive"        //确认收货
#define k_mine_chosedefaulted     @"v1/mine/chosedefaulted"       //选择地址为默认地址
#endif
