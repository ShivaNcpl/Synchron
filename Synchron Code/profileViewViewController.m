//
//  profileViewViewController.m
//  Synchron
//
//  Created by NCPL Inc on 21/04/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "profileViewViewController.h"
#import "EditProfileViewController.h"

@interface profileViewViewController ()

@end

@implementation profileViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.menu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self displaydata];
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
-(void)displaydata{
    self.fullname.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userFullName"]];
    self.designation.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserPosition"]];
    self.cityCountry.text =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserAddress"]];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"] !=NULL) {
        self.profilePic.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"]];
    }else{
        self.profilePic.image = [UIImage imageNamed:@"profile.png"];
    }
   // self.profilePic.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"]];
    
    
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2;
    self.profilePic.clipsToBounds = YES;
    
    self.emailId.text= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserEmail"]];
    self.landPhone.text =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"]];
    self.mobilePhone.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"office"]];
    
    
}


- (IBAction)editProfile:(id)sender {
    //[self performSegueWithIdentifier:@"edit" sender:self];
    EditProfileViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"EditView"];
    [self.navigationController pushViewController:edit animated:YES];
}
@end
