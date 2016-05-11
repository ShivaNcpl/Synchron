
/*
 Created by Surgeworks, Inc. http://surgeworksmobile.com/
 
 How to use :
 
 [[ReviewsAlert instance] showReviewsAlert];
 
 Just add this line of code to your code implementation,
 for example in applicationDidFinishLaunching: method and 
 #import "ReviewsAlert.h" in same file.
 
 Set kDaysToWait to define time interval.
 Set AppUrl to yours app AppSore url.
 
*/


#import "ReviewsAlert.h"
#import <UIKit/UIKit.h>
#define kDaysToWait 5

//https://itunes.apple.com/us/app/scan-plus-multipage-document/id730873477?ls=1&mt=8//
static NSString *AppUrl = @"https://itunes.apple.com/us/app/my-scan-multipage-document/id859150313?ls=1&mt=8";

static NSString *AlertTitle = @"Rate Whirld";
static NSString *AlertMessage = @"Thanks for using \"Whirld\". Would you mind taking a few seconds to leave a review in The App Store?";
static NSString *AlertCancelButtonTitle = @"Not now";
static NSString *AlertGoToStoreButtonTitle = @"YES";
static NSString *AlertDontAskAgainButtonTitle = @"NO";

static ReviewsAlert *instance   = nil;
static NSString *StartDateKey   = @"reviewsAlertStartDate";
static NSString *AlertBannedKey = @"reviewsAlertBanned";
static NSString *UserDidRateKey = @"userDidRate";

@interface ReviewsAlert (Private)
- (int) daysPassed;
- (int) daysToWait;
@end

@implementation ReviewsAlert

- (void) showReviewsAlert 
{
	if (isAlertActive == NO)
	{
		/* Set start date. */
		if ([[NSUserDefaults standardUserDefaults] objectForKey:StartDateKey] == NULL) 
			[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:StartDateKey];
		
		/* Check if reviews alert was not banned ("Don't ask again"). */
		if ([[NSUserDefaults standardUserDefaults] boolForKey:AlertBannedKey] == YES)
			return;
		
		/* Check if user already reviewed the app. */
		if ([[NSUserDefaults standardUserDefaults] boolForKey:UserDidRateKey] == YES)
			return;
		
		/* Check if enough time has passed. */
       // NSLog(@"[self daysPassed]:%d",[self daysPassed]);
       // NSLog(@"[self daysToWait]:%d",[self daysToWait]);
		if ( [self daysPassed] < [self daysToWait])
        {
          //  NSLog(@"[self daysPassed]:%d",[self daysPassed]);
          //  NSLog(@"[self daysToWait]:%d",[self daysToWait]);

          //  NSLog(@"in sufficient time");
			return;
        }
		
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: AlertTitle
															message: AlertMessage 
														   delegate: self 
												  cancelButtonTitle:AlertDontAskAgainButtonTitle
												  otherButtonTitles: AlertGoToStoreButtonTitle,AlertCancelButtonTitle, nil];
		[alertView show];
		
		isAlertActive = YES;
	}
}


- (void) alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) 
	{ 
		/* Don't ask again. */
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:AlertBannedKey];

	}
	else if (buttonIndex == 1) 
	{ 
		/* Go to the AppStore. */
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:UserDidRateKey];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppUrl]];
	}
	else if (buttonIndex == 2) 
	{ 
		
        /* Cancel. Reset date. */
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:StartDateKey];

	}
	
	[theAlertView release];
	isAlertActive = NO;
}


- (int) daysPassed
{
	return 	[[NSDate date] timeIntervalSinceDate:[[NSUserDefaults standardUserDefaults] objectForKey:StartDateKey]];
}


- (int) daysToWait
{
	//ANL return (3600 * 24) * kDaysToWait;
    return 1;
}


+ (ReviewsAlert*) instance
{
    @synchronized(self) 
    {
        if (instance == nil) 
        {
            [[self alloc] init];
        }
    }
    return instance;
}

+ (id)allocWithZone:(NSZone*) zone
{
    @synchronized(self) 
    {
        if (instance == nil) 
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil; 
}

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (unsigned) retainCount
{
    return UINT_MAX;
}

-(void) release
{
	
}

- (id) autorelease
{
    return self;
}

@end

/*

DISCLAIMER OF WARRANTY.

SURGEWORKS expressly disclaims any warranty for the SOFTWARE COMPONENT PRODUCT(S). THE SOFTWARE COMPONENT PRODUCT(S) AND ANY RELATED DOCUMENTATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NONINFRINGEMENT. SURGEWORKS DOES NOT WARRANT, GUARANTEE, OR MAKE ANY REPRESENTATIONS REGARDING THE USE, OR THE RESULTS OF THE USE, OF THE SOFTWARE COMPONENT PRODUCT(S) IN TERMS OF CORRECTNESS, ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE SOFTWARE COMPONENT PRODUCT(S) REMAINS WITH YOU. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. No oral or written information or advice given by SURGEWORKS or its employees shall create a warranty or in any way increase the scope of this warranty.

LIMITATIONS ON LIABILITY.

To the maximum extent permitted by applicable law, in no event shall SURGEWORKS be liable for any special, incidental, indirect, or consequential damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or any other pecuniary loss) arising out of the use of or inability to use the SOFTWARE COMPONENT PRODUCT(S) or the provision of or failure to provide Support Services, even if SURGEWORKS has been advised of the possibility of such damages.

Developer End User understands that the SOFTWARE COMPONENT PRODUCT(S) may produce inaccurate results because of a failure or fault within the SOFTWARE COMPONENT PRODUCT(S) or failure by Developer End User to properly use and or deploy the SOFTWARE COMPONENT PRODUCT(S). Developer End User assumes full and sole responsibility for any use of the SOFTWARE COMPONENT PRODUCT(S), and bears the entire risk for failures or faults within the SOFTWARE COMPONENT PRODUCT(S). You agree that regardless of the cause of failure or fault or the form of any claim, YOUR SOLE REMEDY AND SURGEWORKS'S SOLE OBLIGATION SHALL BE GOVERNED BY THIS AGREEMENT AND IN NO EVENT SHALL SURGEWORKS'S LIABILITY EXCEED THE PRICE PAID TO SURGEWORKS FOR THE SOFTWARE COMPONENT PRODUCT(S). This Limited Warranty is void if failure of the SOFTWARE COMPONENT PRODUCT(S) has resulted from accident, abuse, alteration, unauthorized use or misapplication of the SOFTWARE COMPONENT PRODUCT(S).

*/