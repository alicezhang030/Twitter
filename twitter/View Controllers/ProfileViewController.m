//
//  ProfileViewController.m
//  twitter
//
//  Created by Alice Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrayOfUserTweets;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UILabel *userRealName;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLine;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl; //pull down and refresh the page
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up TableView
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Get timeline
    [self fetchTimeline];
    
    // Update fields
    self.userRealName.text = self.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.user.screenName];
    
    //TODO: fix cut off with tag line
    self.tagLine.text = self.user.tagline;
    
    self.followingCount.text = [NSString stringWithFormat: @"%d Following", self.user.followingCount];
    self.followersCount.text = [NSString stringWithFormat: @"%d Followers", self.user.followersCount];
    self.tweetCount.text = [NSString stringWithFormat: @"%d Tweets", self.user.tweetCount];
            
    NSString *URLString = self.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    if (url != nil) {
        [self.profileImage setImageWithURL:url];
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height /2;
        self.profileImage.layer.masksToBounds = YES;
        self.profileImage.layer.borderWidth = 0;
    }
    
    NSString *URLStringBackdrop = self.user.backdropPicture;
    NSURL *urlBackdrop = [NSURL URLWithString:URLStringBackdrop];
    if(url != nil) {
        [self.backdropImage setImageWithURL:urlBackdrop];
    }
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //self.blurView.alpha = 1;
    [UIView animateWithDuration:0.5 animations:^{
        self.blurView.alpha = 1;
        self.backdropImage.transform = CGAffineTransformMakeScale(1.4, 1.4);
        self.blurView.transform = CGAffineTransformMakeScale(1.4, 1.4);
    }];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [UIView animateWithDuration:0.5 animations:^{
        self.blurView.alpha = 0;
        self.backdropImage.transform = CGAffineTransformIdentity;
        self.blurView.transform = CGAffineTransformIdentity;
    }];
}

- (void) fetchTimeline {
    [[APIManager shared] getUserTimelineWithCompletion:self.user.userId completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"%@", self.user.userId);
            NSLog(@"😎😎😎 Successfully loaded user timeline");
            self.arrayOfUserTweets = (NSMutableArray *)tweets;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            self.blurView.alpha = 0;
        } else {
            NSLog(@"😫😫😫 Error getting user timeline: %@", error.localizedDescription);
            [self.refreshControl endRefreshing];
            self.blurView.alpha = 0;
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TweetCell"];
    cell.tweet = self.arrayOfUserTweets[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfUserTweets.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
