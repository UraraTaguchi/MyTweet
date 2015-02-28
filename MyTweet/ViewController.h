//
//  ViewController.h
//  MyTweet
//
//  Created by 田口うらら on 2015/02/27.
//  Copyright (c) 2015年 田口うらら. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/social.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *array;
    IBOutlet UITableView *timelineTableView;
}
-(void)twitterTimeline;

-(IBAction)tweetButton;
-(IBAction)refreshButton;

@end

