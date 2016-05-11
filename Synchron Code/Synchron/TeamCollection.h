//
//  TeamCollection.h
//  Synchron
//
//  Created by NCPL Inc on 27/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Advisors.h"
#import "AdCusCellCollectionViewCell.h"
#import "SWRevealViewController.h"

@interface TeamCollection : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionMain;


@property (weak, nonatomic) IBOutlet UIButton *menu;

@property (strong, nonatomic) NSMutableArray * BPartners;
@end
