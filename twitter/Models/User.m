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
        NSNumber *user_id = dictionary[@"id"];
        int user_id_int =  [user_id intValue];
        self.user_id = [NSString stringWithFormat:@"%d", user_id_int];
        
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        
        self.backdropPicture = dictionary[@"profile_banner_url"];
        self.tagline = dictionary[@"description"];
        
        NSNumber *followingCountNum = dictionary[@"friends_count"];
        int followingCountInt =  [followingCountNum intValue];
        self.followingCount = [NSString stringWithFormat:@"%d", followingCountInt];
        
        NSNumber *followersCountNum = dictionary[@"followers_count"];
        int followersCountInt =  [followersCountNum intValue];
        self.followersCount = [NSString stringWithFormat:@"%d", followersCountInt];
        
        NSNumber *tweetCountNum = dictionary[@"statuses_count"];
        int tweetCountInt = [tweetCountNum intValue];
        self.tweetCount = [NSString stringWithFormat:@"%d", tweetCountInt];
        
    }
    
    return self;
}

@end
