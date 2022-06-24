//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "AppDelegate.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl; //pull down and refresh the page

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up TableView
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Get timeline
    [self fetchTimeline];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void) fetchTimeline {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            //self.arrayOfTweets = tweets;
            
            for (Tweet *tw in tweets) {
                NSString *text = tw.text;
                NSLog(@"%@", text);
                self.arrayOfTweets = (NSMutableArray *) tweets;
            }
            
            [self.tableView reloadData];
            //stop the pull down refresher
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapLogout:(id)sender {
    NSLog(@"Logout Button Pressed!");
    
    //reset view to the log in screen
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TweetCell"];
    cell.tweet = self.arrayOfTweets[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (void)didTweet:(Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user {
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString: @"TweetTapSegue"]) {
         NSIndexPath *myIndexPath = [self.tableView indexPathForCell: (TweetCell*) sender];
         Tweet *dataToPass = self.arrayOfTweets[myIndexPath.row];
         DetailsViewController *detailVC = [segue destinationViewController];
         detailVC.detailTweet = dataToPass;
     }
     
     if([segue.identifier isEqualToString: @"ComposeSegue"]) {
         UINavigationController *navigationController = [segue destinationViewController];
         ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
         composeController.delegate = self;
     }
     
     if([segue.identifier isEqualToString:@"profileSegue"]) {
         ProfileViewController *profileVC = [segue destinationViewController];
         profileVC.user = sender;
     }
 }
@end
