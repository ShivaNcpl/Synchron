//
//  AdvisorCollection.m
//  Synchron
//
//  Created by NCPL Inc on 23/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "AdvisorCollection.h"


@interface AdvisorCollection ()
@property UIActivityIndicatorView *spinner;
@end

NSMutableArray *partnersData;
NSMutableArray *TeamData;
static NSString * CellId;

BOOL partners;
@implementation AdvisorCollection
@synthesize spinner;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CellId = @"Cell";
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    partners =YES;
    [self performSelectorInBackground:@selector(loaddata) withObject:nil];
   
    //[self loaddata];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    
    [spinner startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
        return partnersData.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AdCusCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    
        if ([partnersData [indexPath.item] valueForKey:@" Advisor Image"] != NULL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
           NSString *image = [NSString stringWithFormat:@"%@",[partnersData[indexPath.item] valueForKey:@" Advisor Image"]];
            NSData *imagdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
        
            
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                //UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
                cell.Aimage.image = [UIImage imageWithData:imagdata];
            });
        });
        }else{
            cell.Aimage.image = [UIImage imageNamed:@"profile.png"];
        }
        
        cell.AName.text = [NSString stringWithFormat:@"%@",[partnersData[indexPath.item] valueForKey:@"Name"]];
        
        return cell;
   
}


-(void)setdata:(NSInteger*)index{
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Advisors * ad =[self.storyboard instantiateViewControllerWithIdentifier:@"AdvisorDetails"];
    
        [ad setData:partnersData[indexPath.item]];
    
    [self.navigationController presentViewController:ad animated:YES completion:nil];
}

-(void)loaddata{
   
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/allpartners.php"]];
    NSURLRequest *prequest = [NSURLRequest requestWithURL:url];
    NSData *pdata = [[NSData alloc]init];
    partnersData = [[NSMutableArray alloc]init];
    pdata = [NSURLConnection sendSynchronousRequest:prequest returningResponse:nil error:nil];
    partnersData = [NSJSONSerialization JSONObjectWithData:pdata options:kNilOptions error:nil];
    NSLog(@" Partnerts Are : %lu",(unsigned long)partnersData.count);
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
