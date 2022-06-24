//
//  User.m
//  twitter
//
//  Created by Alice Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.userId = dictionary[@"id"];
        
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        
        self.backdropPicture = dictionary[@"profile_banner_url"];
        self.tagline = dictionary[@"description"];
        
        NSNumber *followingCountNum = dictionary[@"friends_count"];
        self.followingCount =  [followingCountNum intValue];
        
        NSNumber *followersCountNum = dictionary[@"followers_count"];
        self.followersCount =  [followersCountNum intValue];
        
        NSNumber *tweetCountNum = dictionary[@"statuses_count"];
        self.tweetCount = [tweetCountNum intValue];
    }
    
    return self;
}

@end
