//
//  TwitterClient.h
//  TwitterApp
//
//  Created by Kent Tam on 10/28/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

-(void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
-(void)openURL:(NSURL *)url;

-(void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

-(void)tweet:(NSDictionary *)params completion:(void (^)(Tweet *tweet, NSError *error))completion;

-(void)favoriteUpdateWithParams:(NSDictionary *)params completion:(void (^)(Tweet *, NSError *))completion;
-(void)retweetUpdateWithParams:(NSDictionary *)params completion:(void (^)(Tweet *, NSError *))completion;
-(void)getBanner:(NSDictionary *)params completion:(void (^)(NSString *, NSError *))completion;
-(void)getTimeline:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion;
-(void)mentionsTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
@end
