//
//  EventFeedback.m
//  Synchron
//
//  Created by NCPL Inc on 29/03/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "EventFeedback.h"
#import "SWRevealViewController.h"
@interface EventFeedback ()

@end

@implementation EventFeedback
@synthesize sidebarButton,EventDetails,userID,eventId;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 800);
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        [self.sidebarButton setTarget: self.revealViewController];
//        [self.sidebarButton setAction: @selector( revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    // Do any additional setup after loading the view.
    
    [self performSelectorInBackground:@selector(fetchdata) withObject:nil];
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


-(void)fetchdata{
    NSString *eventTitle = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventName"]];
    NSString* address = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventAddress"]];
    userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    eventId = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventId"]];
    
    NSString *img = [NSString stringWithFormat:@"%@",[EventDetails[0] valueForKey:@"EventLogo"]];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:img]];
    self.eventTitle.text = eventTitle;
    self.eventAddress.text =address;
    self.eventImage.image = [UIImage imageWithData:imageData];
}

- (IBAction)speaker:(id)sender {
    [self performSegueWithIdentifier:@"SpeakerFeedback" sender:self];
}

- (IBAction)content:(id)sender {
    [self performSegueWithIdentifier:@"ContentFeedback" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier ] isEqualToString:@"SpeakerFeedback"]) {
        SpeakersFeedback *sf = [segue destinationViewController];
        //sf.EventDetails= self.eventDetails;
        [sf setEventDetails:EventDetails];
    }
    if ([[segue identifier ] isEqualToString:@"ContentFeedback"]) {
        ContentFeedback *sf = [segue destinationViewController];
        //sf.EventDetails= self.eventDetails;
        [sf setEventDetails:EventDetails];
    }
}

- (IBAction)submitFeedback:(id)sender {
    if (![self.comment.text isEqualToString:@""]) {
        
        NSLog(@"%@",self.comment.text);
    
        NSString *urlstring =[NSString stringWithFormat:@"http://www.synchron.6elements.net/webservices/Event_Feedback.php?EventId=%@&UserId=%@&Event=%d&Venu=%d&Catering=%d&SpeakerOverall=%d&ContentOverall=%d&comment=%@",eventId,userID,(int)self.eventS.value,(int)self.venuS.value,(int)self.cateringS.value,(int)self.speakerS.value,(int)self.contentS.value,self.comment.text];
        urlstring = [urlstring stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"%@",urlstring);
    NSURL *url = [NSURL URLWithString:urlstring];
        
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:kNilOptions error:nil];
    
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([[json[0]valueForKey:@"message"] isEqualToString:@"Updated Successfully"] ||[[json[0]valueForKey:@"message"] isEqualToString:@"Uploded Successfully"]) {
        
        NSLog(@"submit Feeback %@",json);
        UIAlertController *ac= [UIAlertController alertControllerWithTitle:@"Synchron" message:@"Thank you your valuable feeback" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [ac addAction:ok];
        [self presentViewController:ac animated:YES completion:nil];
        
    }else if([[json[0]valueForKey:@"message"] isEqualToString:@"Not Inserted"] ){
        NSLog(@"Error : Data is Null : %@",json);
        
    }
    }else{
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Synchron" message:@"Please comment" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [al show];
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)eventSm:(id)sender {
    self.EventL.text=[NSString stringWithFormat:@"%d",(int)self.eventS.value];
}
-(IBAction)venuSm:(id)sender{
     self.VenuL.text=[NSString stringWithFormat:@"%d",(int)self.venuS.value];
}

-(IBAction)cateringSm:(id)sender{
    self.CateringL.text=[NSString stringWithFormat:@"%d",(int)self.cateringS.value];
}
-(IBAction)speakerSm:(id)sender{
    self.SpeakerL.text=[NSString stringWithFormat:@"%d",(int)self.speakerS.value];
}
-(IBAction)contentSm:(id)sender{
    self.ContentL.text=[NSString stringWithFormat:@"%d",(int)self.contentS.value];
}

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
    [self.scrollView setContentOffset:CGPointMake(0,textField.center.y-150) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.scrollView setContentOffset:CGPointMake(0,300) animated:YES];
    //tes=YES;
    [self viewDidLayoutSubviews];
}
-(void)alertViewMessage:(NSString*)message{
    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Synchron" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alrt show];
}
@end
