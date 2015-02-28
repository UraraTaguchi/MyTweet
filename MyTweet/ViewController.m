//
//  ViewController.m
//  MyTweet
//
//  Created by 田口うらら on 2015/02/27.
//  Copyright (c) 2015年 田口うらら. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)tweetButton
{
    SLComposeViewController *twitterPostViewController = [SLComposeViewController
                                                          composeViewControllerForServiceType:SLServiceTypeTwitter];
    [self presentViewController:twitterPostViewController animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self twitterTimeline];
}

-(IBAction)refreshButton{
    [self twitterTimeline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)twitterTimeline{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES){
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             if ([arrayOfAccounts count] > 0) {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 NSURL *requestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                 NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"100" forKey:@"count"];
                 [parameters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                       requestMethod:SLRequestMethodGET
                                                                 URL:requestAPI
                                                          parameters:parameters
                                     ];
                 
                 posts.account = twitterAccount;
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                 
                 [posts performRequestWithHandler:
                  ^(NSData *response, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      array = [NSJSONSerialization JSONObjectWithData:response
                                                              options:NSJSONReadingMutableLeaves
                                                                error:&error];
                      if (array.count != 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [timelineTableView reloadData];
                          });
                      }
                  }];
                 
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 
             }
         }else {
             NSLog(@"%@", [error localizedDescription]);
         }
     }];

    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [arrat count];
    }
    
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowIndexPath:(NSIndexPath
*)indexPath{
    
    tweetTextView.text = [NSString stringWithFormat:@"%@",tweet[@"text"]];
    userlabel.text = [NSString stringWithFormat:@"%@",userinfo[@"text"]];
    userIDLabel.text = [NSString stringWithFormat:@"%@",userInfo[@"text"]];
    
    NSString *userImagePath = userInfo[@"profile_image_url"];
    NSURL *userImagepathUrl = [[NSURL alloc] initWithSting:userImagePath];
    NSData *userImagePathData - [[NSData alloc] initWithContentsOfURL:userImagePathUrl];
    userimageView.image = [[UIImage alloc] initWihData:userImagePathData];
    return cell;
}
    
    (NSSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReuseableCellWithIndetifier:@"TweetCell"];
        
        UITextView *tweetTextView = (UITextView *)[cell viewWithTag:3];
        UILabel *userLabel = (UILabel *)[cell viewWithTag:1];
        UILabel *userIDLabel = (UILabel)[cell viewWithTag:2];
        UIImageView *userImageView = (UIImageView *)[cell viewWithTag:4];
        
        NSDictionary *tweet = array[indexpath.row];
        NSDictionary *userInfo = tweet[@"user"];
    }
    

@end
