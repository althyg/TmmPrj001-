//
//  ATUtility.h
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

typedef void (^FailViewBtnClickBlock) (void);

#define CMUtilityNetwork        [CMUtility sharedNet]

@interface ATUtility : NSObject

//网络状态
@property (nonatomic,assign)NSInteger  status;

//网络请求失败点击重新加载按钮调用的Block
@property (nonatomic,copy) FailViewBtnClickBlock failViewBtnClickBlock;

//网络单例方法
+(instancetype)sharedNet;

//计算字符串的字数，
+ (int)calculateTextLength:(NSString *)text;

//计算两点经纬度之间的距离
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

//数字转弧度
+(CGFloat)convertNumToArc:(double)num;

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

//校验登录密码
+ (BOOL)validatePsd:(NSString *)password;

//校验支付密码
+ (BOOL)validatePayPsd:(NSString *)paypsd;

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum;

// 判断有效密码
+ (BOOL)validatePassword:(NSString *)pwd;

// 手机号部分隐藏
+ (NSString *)securePhoneNumber:(NSString *)pNum;

// 判断字符是否全为空格
+ (BOOL)isAllSpaceWithString:(NSString *)string;

// 反转数组
+ (void)reverseArray:(NSMutableArray *)targetArray;

// toast 提示框
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view;

// alert提示框
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate;

//风火轮加载
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;
+ (void)showMBProgress:(UIView *)_targetView;

//提示框 设置偏移量
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view yOffset:(CGFloat)y;

//隐藏风火轮
+ (void)hideMBProgress:(UIView*)_targetView;

//提示框,Tim添加
+ (void)showTips:(NSString *)tips;

//图片的颜色和尺寸
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

//颜色画图,可通用,Tim添加
+ (UIImage *)imageWithColor:(UIColor *)color;

//获取当前版本号
+ (NSString *)getLocalAppVersion;

//图像保存路径
+ (NSString *)savedPath;

//获得屏幕图像
+(UIImage *)imageFromView:(UIView *)theView;

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;

//伸展UIImage,Tim添加
+ (UIImage *)resizeImage:(NSString *)imageName;

/**
 *  将时间戳转换为时间
 */
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat;

//将时间转换为时间戳
+ (NSString *)getTimeStampWithDate:(NSString *)strDate;

//日期显示规则   本日显示时间，昨日显示“昨日”，之前日期显示具体日期
+ (NSString *)showDateWithStringDate:(NSString *)strDate;

//千分位的格式
+ (NSString *)conversionThousandth:(NSString *)string;

//判断网络
+ (BOOL)isConnectionAvailable;

//生成指定大小的图片 图片中心为指定显示的图片
+(UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName;

//限制输入框只能输入数字
+ (BOOL)printInNumber:(NSString*)number;

//限制输入框只能输入字母和数字组合
+ (BOOL)printInLettersOrNumber:(NSString*)str;

//限制输入框只能输入字母
+ (BOOL)printInLetters:(NSString*)str;

//单个文件的大小,Tim添加
+ (long long)fileSizeAtPath:(NSString*)filePath;

//遍历文件夹获得文件夹大小，返回多少M，Tim添加
+ (float)folderSizeAtPath:(NSString*) folderPath;

//md5，Tim添加
+ (NSString *) md5: (NSString *) inPutText;

// Duplicate UIView
+ (UIView*)duplicate:(UIView*)view;

/**
 *  打分特殊字体
 *
 *  @param leftFount  左边字体大小
 *  @param rightFount 右边字体大小
 *  @param text       内容
 *
 *  @return 富文本
 */
+ (NSAttributedString *)ScoreLeftFount:(UIFont *)leftFount
                            rightFount:(UIFont *)rightFount
                                  text:(NSString *)text;

/**
 *  动态算出文本大小
 *
 *  @param size   限制宽高
 *  @param font   字体的大小
 *  @param spacing 行间距
 *  @param string 内容
 *
 *  @return cgsize
 */
+(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font string:(NSString*)string withSpacing:(CGFloat)spacing;


/**
 *  设置文字行间距
 *
 *  @param string   字符串
 *  @param font     字体大小
 *  @param spacing  间距大小
 *
 *  @return NSAttributedString
 */

+(NSAttributedString *)setLineSpacingWithString:(NSString *)string withFont:(CGFloat)font spacing:(CGFloat)spacing;

/**
 *  判断时间是否在一周内
 *
 *  @param dateString   时间戳
 *  @param format       时间格式
 *
 *  @return NSString    时间|星期
 */
+ (NSString*)weekDayStr:(NSString *)dateString withFormat:(NSString *)format;


/**
 *  判断时间的时间段 几分钟/几小时/几天前
 *
 *  @param dateString   时间戳
 *  @param format       时间格式
 *
 *  @return NSString    时间|星期
 */
+ (NSString *)intervalSinceNow: (NSString *)dateString;

/**
 *  时间戳转换为  xx分:xx秒 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateMMssFromString:(NSString *)dateString;


/**
 *  时间戳转换为  xx时:xx分 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateHHmmFromString:(NSString *)dateString;

/**
 *  时间戳转换为  xx年xx月xx日 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateYYMMDDFromString:(NSString *)dateString;

/**
 *  将来的某个时间距离现在所剩的时间
 *
 *  @param date
 *
 *  @return NSString    格式化好的时间
 */
+ (NSString *)dateOfSinceNowFromDate:(double)date netNow:(double)netNow;

/**
 *  字数控制
 *
 *  @param dateString   时间戳
 *  @param label        显示字数的
 *  @param MaxNum       最大限制字数
 *  @param text         现输入字符
 *
 *  @return NSString    格式化好的日期
 */
+(BOOL)changeCharsWithText:(UITextView *)textView withTextBytes:(UILabel *)label withMax:(NSInteger)MaxNum withText:(NSString *)text;

/**
 * 出现短暂的提示语
 */

+(void)showTipMessage:(NSString *)tips;

+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

/**
 *  计算文字尺寸大小
 */
+ (CGSize) sizeOfString:(NSString *) text withMaxSize:(CGSize ) maxSize andFont:(UIFont *) font;
/**
 *  对密码进行加密
 */
+(NSString *) securePassWord:(NSString *)oldPwd;

+(NSString *)ret32bitString;
@end
