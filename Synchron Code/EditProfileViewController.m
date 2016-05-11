//
//  EditProfileViewController.m
//  Synchron
//
//  Created by NCPL Inc on 31/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "EditProfileViewController.h"
#import "SWRevealViewController.h"
#import "Events.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
//#import "JSON.h"
@interface EditProfileViewController (){
    
}
@property NSData *jsondata;
@property UIActivityIndicatorView *spinner;
@end


@implementation EditProfileViewController
@synthesize  scroll,main,spinner;
- (void)viewDidLoad {
    [super viewDidLoad];
    [main addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:scroll];
    [scroll addSubview:spinner];
    
    [spinner startAnimating];
    
    [scroll setScrollEnabled:YES];
    
    [scroll setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+200)];
   
 //[[NSUserDefaults standardUserDefaults]setObject:userID forKey:@"UserId"];
    // Do any additional setup after loading the view.
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/get_userdetails.php?user_id=%@",UserId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.imageView.layer.borderWidth= 2.0f;
    
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

- (IBAction)back:(id)sender {
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)saveback:(id)sender{
    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Synchron" message:@"your details uploaded" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //[alrt show];
    //[self.navigationController popViewControllerAnimated:YES];
  //  www.synchron.6elements.net/webservices/update_profile.php?UserId=22&firstName=swamy&proffesion=Business Partners&location=14-12-88.Maharani peta,Near Duvii travels,Ottageda,R.k Beach&phone=8923446555&mobile=8976543233&password=sari@123&newPassword=sari@123&reEnterPassword=sari@123&profilepic=Koala1.jpg
    
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    //NSString *newDateString = [NSDateFormatter stringFromDate:[NSDate date]];
    
    
    NSString *imageName=[NSString stringWithFormat:@"%@_.jpg",self.fullname.text];
    
    NSData * imgdata = UIImageJPEGRepresentation(self.imageView.image, 1.0);
    NSString *imgName = [self.imageView image].accessibilityIdentifier;
    
    NSLog(@"%@",imgName);
    
    NSString * imagestr = [[NSString alloc] initWithData:imgdata encoding:NSUTF8StringEncoding];
    [[self.imageView image] setAccessibilityIdentifier:@"fileName"];
    NSString * imagename = [self.imageView image].accessibilityIdentifier;
    NSLog(@" file name: %@",imgdata);
    
    NSString *urlstring =[NSString stringWithFormat:@"www.synchron.6elements.net/webservices/update_profile.php?UserId=%@&firstName=%@&proffesion=%@&location=%@&phone=%@&mobile=%@&password=sari@123&newPassword=sari@123&reEnterPassword=sari@123&profilepic=%@",userID,self.fullname.text,self.profession.text,self.location.text,self.landPhone.text,self.mobilePhone.text,imagestr];
    //urlstring = [urlstring stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"%@",urlstring);
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
    
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"Information Sent is :%@",json);
    
   // [self AsihttpReq];
}

//-(void)AsihttpReq{
//    
//     NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MMddyyyy"];
//    NSString *newDateString = [dateFormatter stringFromDate:[NSDate date]];
//    
//    NSString *imageName=[NSString stringWithFormat:@"%@_%@.jpg",self.fullname.text,newDateString];
//    NSString *urlString=[NSString stringWithFormat:@"www.synchron.6elements.net/webservices/update_profile.php?UserId=%@&firstName=%@&proffesion=%@&location=%@&phone=%@&mobile=%@&password=sari@123&newPassword=sari@123&reEnterPassword=sari@123&profilepic=%@",userID,self.fullname.text,self.profession.text,self.location.text,self.landPhone.text,self.mobilePhone.text,imageName];
//    NSData * imageData = UIImageJPEGRepresentation(self.imageView.image, 1);
//    
//    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
//    
//    [request setUseKeychainPersistence:YES];
//    
//    
//    //[request setPostValue:self.fullname.text forKey:@"fullname"];
//    
//   
//    
//    [request setData:imageData withFileName:imageName andContentType:@"image/jpg" forKey:@"profilepic"];
//    
//    
//    [request setRequestMethod:@"POST"];
//    [request setDelegate:self];
//    [request setDidFinishSelector:@selector(UploadRequestFinished:)];
//    [request setDidFailSelector:@selector(uploadRequestFailed:)];
//    [request startAsynchronous];
//    
//
//}
//-(void)UploadRequestFinished:(ASIHTTPRequest *)request
//{
//    NSString *receivedString = [request responseString];
//    
//    NSArray *arrSepr=[receivedString componentsSeparatedByString:@"+"];
//    
//    NSLog(@"arrSepr is %@",arrSepr);
//    
//    
//    
//    if ([receivedString isEqualToString:@"success"]) {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        
//       // [self alertviewtitle:@"Whirld" message:receivedString];
//    }
//}
//-(void)uploadRequestFailed:(ASIHTTPRequest *)request{
//    NSString *receivedString = [request responseString];
//    NSArray *arrSepr=[receivedString componentsSeparatedByString:@"+"];
//    NSLog(@"Error is %@",arrSepr);
//}

- (IBAction)replacePic:(id)sender {
    
    UIAlertController *Imagereplace = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *lib = [UIAlertAction actionWithTitle:@"Choose form Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self libraryImage];
    }];
    UIAlertAction *cam = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cameraImage];
    }];
    
    [Imagereplace addAction:cancel];
    [Imagereplace addAction:lib];
    [Imagereplace addAction:cam];
    [self presentViewController:Imagereplace animated:YES completion:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@" In Did receive Response");
    self.jsondata  = [[NSData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@" In Did receive Data");
    self.jsondata = [NSData dataWithData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:self.jsondata options:kNilOptions error:nil];
    NSLog(@"Json in Edit Profile:%@",jsonArray);
    
    NSString * img = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@" Profile Image"]];
    NSData *imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    NSString * firstName = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Firstname"]];
    NSString * lastName = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Lastname"]];
    NSString * position = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"User Position"]];
   // NSString * address= [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Address "]];
    NSString * emailId = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Email Id"]];
    NSString * phone = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Phone Number"]];
    NSString * mobile = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Mobile Number"]];
    NSString * password = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Password"]];
    NSString * city = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"City"]];
    NSString * country = [NSString stringWithFormat:@"%@",[jsonArray[0] valueForKey:@"Country"]];
    
    if (imgdata !=NULL) {
//        self.profilePic.image = [UIImage imageWithData:imgdata];
        self.imageView.image =[UIImage imageWithData:imgdata];
    }else{
//        self.profilePic.image = [UIImage imageNamed:@"profile.png"];
        self.imageView.image = [UIImage imageNamed:@"profile.png"];
    }
    
  
    self.fullname.text = [NSString stringWithFormat:@"%@,%@",firstName,lastName];
    self.profession.text = position;
    self.location.text = [NSString stringWithFormat:@"%@,%@",city,country];
    self.emailID.text = emailId;
    self.emailID.enabled =NO;
    self.mobilePhone.text = mobile;
    self.landPhone.text = phone;
    self.password.text = password;
    [spinner stopAnimating];
    
}

#pragma TextField methods.

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    //[self.userName resignFirstResponder];
    //[self.passWord resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    // self.scrlViewUI.contentOffset = CGPointMake(0, textField.frame.origin.y);
    [self.scroll setContentOffset:CGPointMake(0,textField.center.y-300) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.scroll setContentOffset:CGPointMake(0,300) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}

#pragma Image Picker



-(void)cameraImage{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    } else {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //picker
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
}
-(void)libraryImage{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
