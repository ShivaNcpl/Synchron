//
//  BusinessPartnersCollection.m
//  Synchron
//
//  Created by NCPL Inc on 27/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "BusinessPartnersCollection.h"

@interface BusinessPartnersCollection ()
@property UIActivityIndicatorView *spinner;
@end

@implementation BusinessPartnersCollection
@synthesize collectionMain,BPartners,spinner;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [self performSelectorInBackground:@selector(loaddata) withObject:nil];
    [spinner startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loaddata{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/allpartners.php"]];
    NSURLRequest *prequest = [NSURLRequest requestWithURL:url];
    NSData *pdata = [[NSData alloc]init];
    BPartners= [[NSMutableArray alloc]init];
    pdata = [NSURLConnection sendSynchronousRequest:prequest returningResponse:nil error:nil];
    BPartners = [NSJSONSerialization JSONObjectWithData:pdata options:kNilOptions error:nil];
    NSLog(@" Partnerts Are : %lu",(unsigned long)BPartners.count);
    
    //    NSURL *turl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/alladvisors.php"]];
    //    NSURLRequest *trequest = [NSURLRequest requestWithURL:turl];
    //    NSData *tdata = [[NSData alloc]init];
    //    TeamData = [[NSMutableArray alloc]init];
    //    tdata = [NSURLConnection sendSynchronousRequest:trequest returningResponse:nil error:nil];
    //    TeamData = [NSJSONSerialization JSONObjectWithData:tdata options:kNilOptions error:nil];
    //    NSLog(@"Synchron Team :%lu",(unsigned long)TeamData.count);
    
    [self.collectionMain reloadData];
    [spinner stopAnimating];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return BPartners.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID= @"Cell";
    
    AdCusCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if ([BPartners [indexPath.item] valueForKey:@" Advisor Image"] != NULL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            NSString *image = [NSString stringWithFormat:@"%@",[BPartners[indexPath.item] valueForKey:@" Advisor Image"]];
            NSData *imagdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
            
            
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                //UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
                cell.Aimage.image = [UIImage imageWithData:imagdata];
            });
        });
    }else{
        cell.Aimage.image = [UIImage imageNamed:@"profile.png"];
    }
    
    cell.AName.text = [NSString stringWithFormat:@"%@",[BPartners[indexPath.item] valueForKey:@"Name"]];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Advisors * ad =[self.storyboard instantiateViewControllerWithIdentifier:@"AdvisorDetails"];
    
    [ad setData:BPartners[indexPath.item]];
    
    [self.navigationController presentViewController:ad animated:YES completion:nil];
}

@end
