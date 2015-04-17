//
//  RCUser.h
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCStatus;

@interface RCUser : NSObject
/**  字符串型的用户UID*/
@property(copy,nonatomic) NSString * idstr;
/**  用户昵称*/
@property(copy,nonatomic) NSString * name;
/**  用户所在地*/
@property(copy,nonatomic) NSString * location;
/**  用户个人描述*/
@property(copy,nonatomic) NSString * desc;
/**  	用户博客地址*/
@property(copy,nonatomic) NSString * url;
/**  用户头像地址（中图）*/
@property(copy,nonatomic) NSString * profile_image_url;
/**  	用户的个性化域名*/
@property(copy,nonatomic) NSString * domain;
/**  性别，m：男、f：女、n：未知*/
@property(copy,nonatomic) NSString * gender;

/** 用户创建（注册）时间*/
@property(copy,nonatomic) NSString * created_at;
/**  用户备注信息，只有在查询用户关系时才返回此字*/
@property(copy,nonatomic) NSString * remark;
/** 用户头像地址（大图），180×180像素）*/
@property(copy,nonatomic) NSString * avatar_large;
/**  粉丝数  */
@property (nonatomic, assign)int followers_count;
/**  关注数  */
@property (nonatomic, assign)int friends_count;
/**  	微博数  */
@property (nonatomic, assign)int statuses_count;
/**  收藏数  */
@property (nonatomic, assign)int favourites_count;

/**  用户的在线状态，0：不在线、1：在线  */
@property (nonatomic, assign)int online_status;
/**  用户的互粉数  */
@property (nonatomic, assign)int bi_followers_count;
/**  是否允许所有人对我的微博进行评论，true：是，false：否
  */
@property (nonatomic, assign)BOOL allow_all_comment;

/**  是否允许所有人给我发私信，true：是，false：否
 
  */
@property (nonatomic, assign)BOOL allow_all_act_msg;
/**  该用户是否关注当前登录用户，true：是，false：否  */
@property (nonatomic, assign)BOOL follow_me;
/**  	是否是微博认证用户，即加V用户，true：是，false：否
  */
@property (nonatomic, assign)BOOL verified;
@property (nonatomic, assign,getter=isVip)BOOL vip;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;
/** 会员类型 */
@property (nonatomic, assign) int mbtype;
@property(nonatomic,strong) RCStatus * status;

@end
