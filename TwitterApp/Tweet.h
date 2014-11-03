//
//  Tweet.h
//  TwitterApp
//
//  Created by Kent Tam on 10/29/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject
extern NSString * const UpdateTweetNotification;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString * tweetID;
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *) tweetsWithArray: (NSArray *)array;
@end
