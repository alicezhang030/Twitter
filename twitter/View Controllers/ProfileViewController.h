//
//  ProfileViewController.h
//  twitter
//
//  Created by Alice Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *arrayOfUserTweets;

@end

NS_ASSUME_NONNULL_END
