//
//  User.h
//  twitter
//
//  Created by Alice Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;

@property (nonatomic, strong) NSString *backdropPicture;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, assign) int followingCount;
@property (nonatomic, assign) int followersCount;
@property (nonatomic, assign) int tweetCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
