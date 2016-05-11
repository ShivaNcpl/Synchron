//
//  LoginPage.m
//  Synchron
//
//  Created by NCPL Inc on 24/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "LoginPage.h"

@interface LoginPage ()
@property UIActivityIndicatorView *spinner;
@end

@implementation LoginPage
@synthesize userName,passWord,spinner;
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    if([userName.text isEqualToString:@"111"] &&[passWord.text isEqualToString:@"xxx"])
    {
        NSLog(@"LoginSucess");
        
       // if (self.login!=nil) {
            
           // [self.login onloginsuccess];
        }
    
    // Do any additional setup after loading the view. */
    
    self.scroll.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+200);
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.tintColor = [UIColor blueColor];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.scroll addSubview:spinner];
    
    
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

- (IBAction)signIn1:(id)sender {
    [spinner startAnimating];
    NSString *userStng= userName.text;
    NSString *pwdStng= passWord.text;
    
    if(![userName.text isEqualToString:@""] && ![passWord.text isEqualToString:@""])
    {
        NSString *urlString = [NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/login_check.php?username=%@&password=%@",userStng,pwdStng];
        NSURL * url = [NSURL URLWithString:urlString];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        NSError *err;
        NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
        if (data!=nil) {
            NSMutableArray * jsonResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Out put ; %@",jsonResponce);
            NSString *result = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"message"]];
            
            if ([result isEqualToString:@"Successfully Login"]) {
               
                NSString *userFname = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"Firstname"]];
                NSString *userLname = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"Lastname"]];
                NSString * userFullName = [NSString stringWithFormat:@"%@ %@",userFname,userLname];
                NSString *userPosition = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"User position"]];
                
                
                NSString *userEmail = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"Emailid"]];
                NSString *userImage = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"User image"]];
                NSData * imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:userImage]];
                
                NSString *userState = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"State"]];
                 NSString *userID = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"UserId"]];
                NSString *mobile = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"mobileno"]];
                NSString *land = [NSString stringWithFormat:@"%@",[jsonResponce[0] valueForKey:@"officeno"]];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:userStng forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults]setObject:userEmail forKey:@"UserEmail"];
                [[NSUserDefaults standardUserDefaults]setObject:imgdata forKey:@"UserImage"];
                [[NSUserDefaults standardUserDefaults]setObject:userFullName forKey:@"userFullName"];
                [[NSUserDefaults standardUserDefaults]setObject:userState forKey:@"UserAddress"];
                [[NSUserDefaults standardUserDefaults]setObject:userPosition forKey:@"UserPosition"];
                [[NSUserDefaults standardUserDefaults]setObject:userID forKey:@"UserId"];
                [[NSUserDefaults standardUserDefaults]setObject:mobile forKey:@"mobile"];
                [[NSUserDefaults standardUserDefaults]setObject:land forKey:@"office"];
                [self alert:[NSString stringWithFormat:@" Welcome, %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userFullName"]]];
                [spinner stopAnimating];
                [self dismissViewControllerAnimated:YES completion:^{
                    //[[NSUserDefaults standardUserDefaults]setObject:urlString forKey:@"userName"];
                    [[NSUserDefaults standardUserDefaults]setObject:pwdStng forKey:@"userPwd"];
                }];
            }else{
                [spinner stopAnimating];
                [self alert:@"Incorect UserID & password combination"];
            }
            
        }else{
            [spinner stopAnimating];
            [self alert:@"Please check your network connection"];
        }
    }else{
        [spinner stopAnimating];
        [self alert:@"Please enter login details"];
    }
}

- (IBAction)saveUser:(id)sender {
    if ([self.checkbox.currentImage isEqual:[UIImage imageNamed:@"002 Synchron_Signin_checkbox.png"]]) {
        [self.checkbox setImage:[UIImage imageNamed:@"002 Synchron_Signin_uncheckbox.png"] forState:UIControlStateNormal];
    }else{
        [self.checkbox setImage:[UIImage imageNamed:@"002 Synchron_Signin_checkbox.png"] forState:UIControlStateNormal];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}
-(void)alert:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Synchron" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
    [alert show];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    // self.scrlViewUI.contentOffset = CGPointMake(0, textField.frame.origin.y);
    [self.scroll setContentOffset:CGPointMake(0,textField.center.y-250) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.scroll setContentOffset:CGPointMake(0,100) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}

@end
