//
//  MainViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,CLLocationManagerDelegate>
{
    NSArray *Title;
    NSArray *Description;
    NSArray *Image;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property(strong,nonatomic)IBOutlet UIButton*   main;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property NSMutableArray * datajsonArray;
@property NSString *EventId;
@property NSData *jsonData;
@end
