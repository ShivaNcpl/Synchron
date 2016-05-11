//
//  AdvisorCollection.h
//  Synchron
//
//  Created by NCPL Inc on 23/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "AdCusCellCollectionViewCell.h"
#import "Advisors.h"

@interface AdvisorCollection : UIViewController <SWRevealViewControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionMain;


@property (weak, nonatomic) IBOutlet UIButton *menu;


@end
