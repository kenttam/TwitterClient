//
//  User.h
//  TwitterApp
//
//  Created by Kent Tam on 10/29/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const UserDidLoginNotification ;
extern NSString * const UserDidLogoutNotification;
@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *bannerImageUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSNumber *numTweets;
@property (nonatomic, strong) NSNumber *numFollowing;
@property (nonatomic, strong) NSNumber *numFollowers;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSArray *tweets;



- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;
+(void) setCurrentUser:(User *)currentUser;
+(void) logout;
@end
