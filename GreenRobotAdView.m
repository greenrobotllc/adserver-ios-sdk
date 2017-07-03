//
//  GreenRobotAdView.m
//
//  Created by Andy Triboletti on 6/17/17.
//
//

#import "GreenRobotAdView.h"
#import "MoPub.h"
#include <stdlib.h>
#include "GreenRobotAds.h"
#import "AppDelegate.h"

@implementation GreenRobotAdView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    
    }
    return self;
}
- (UIViewController *)viewControllerForPresentingModalView {
    return self.rootViewController;
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    [self initAdmob];
}

- (id)initWithRootViewController :(UIViewController*) myRootViewController withWidgetID:(NSString*) widgetID
{

    self.libertyWidgetID=widgetID;
    self.rootViewController=myRootViewController;
    CGRect frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frame = CGRectMake(0, 0, 768, 1024);
    }
    else {
        frame = CGRectMake(0, 0, 320, 480);
        
    }
    
    self = [self initWithFrame:frame];
    self.center = CGPointMake( [UIScreen mainScreen].bounds.size.width  / 2, self.center.y);

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

+ (CGRect)screenBoundsFixedToPortraitOrientation {
    UIScreen *screen = [UIScreen mainScreen];
    
    if ([screen respondsToSelector:@selector(fixedCoordinateSpace)]) {
        return [screen.coordinateSpace convertRect:screen.bounds toCoordinateSpace:screen.fixedCoordinateSpace];
    }
    return screen.bounds;
}

-(void) initAdmob {
    if(self.libertyAdView) {
        [self.libertyAdView removeFromSuperview];
        
    }
    
    if(self.bannerView) {
        [self.bannerView removeFromSuperview];
        
    }
    if(self.adView){
        [self.adView removeFromSuperview];
    }
    
    NSString *admobUnitId;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard];
        //admobUnitId =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"admob_ipad_unit_id"];
        admobUnitId = self.gra.admobiPadUnitId;
    
    }
    else {
        self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        admobUnitId = self.gra.admobiPhoneUnitId;

    }
    //self.bannerView.frame = frame;
    self.bannerView.delegate=self;
    //screenBoundsFixedToPortraitOrientation
    self.bannerView.rootViewController=self.rootViewController;
    self.bannerView.adUnitID = admobUnitId;
    self.bannerView.center = CGPointMake(self.frame.size.width/2 , self.bannerView.center.y);
    

    GADRequest *request = [GADRequest request];
    // Enable test ads on simulators.
    request.testDevices = @[  kGADSimulatorID ];
    
    [self.bannerView setBackgroundColor:[UIColor blackColor]];
    //[cell.contentView setBackgroundColor:[UIColor blackColor]];
    
    
    [self.bannerView loadRequest:request];
    

    [self addSubview:self.bannerView];
    
    

}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [self liberty];
}
-(void) liberty {
    if(self.bannerView) {
        [self.bannerView removeFromSuperview];
        
    }
    if(self.adView){
        [self.adView removeFromSuperview];
    }
    if(self.libertyAdView) {
        [self.libertyAdView removeFromSuperview];

    }
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        self.libertyAdView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 728,90)];
        
    }
    else {
        self.libertyAdView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,50)];
        
    }
    self.libertyAdView.delegate=self;
    NSString *url=[NSString stringWithFormat:@"comingsoon?wid=%@", self.libertyWidgetID];
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.libertyAdView loadRequest:nsrequest];
    [self addSubview:self.libertyAdView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    [[UIApplication sharedApplication] openURL:[request URL]];
//    return NO;
//
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }

    return YES;
}

-(void) initMoPub {
    if(self.libertyAdView) {
        [self.libertyAdView removeFromSuperview];
        self.libertyAdView =nil;
        
    }
    if(self.bannerView) {
        [self.bannerView removeFromSuperview];
        self.bannerView =nil;
    
    }
    if(self.adView){
        [self.adView removeFromSuperview];
        self.adView =nil;
  }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

        
        self.adView = [[MPAdView alloc] initWithAdUnitId:self.gra.mopubiPadUnitId size:CGSizeMake(1024, 90)];
        self.adView.delegate = self;
        //        self.adView.center = CGPointMake( [UIScreen mainScreen].bounds.size.width  / 2, self.adView.center.y);
        self.adView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 , self.adView.center.y);

        
        [self.adView loadAd];
        //cell.backgroundColor=[UIColor blackColor];

        [self addSubview:self.adView];
        
    }
    else {
        //kMopubiPhone kMopub
        self.adView = [[MPAdView alloc] initWithAdUnitId:self.gra.mopubiPhoneUnitId size:MOPUB_BANNER_SIZE];
        self.adView.delegate = self;
//        self.adView.center = CGPointMake( [UIScreen mainScreen].bounds.size.width  / 2, self.adView.center.y);
        self.adView.center = CGPointMake(self.frame.size.width/2 , self.adView.center.y);

        
        [self.adView loadAd];
        //cell.backgroundColor=[UIColor blackColor];

        [self addSubview:self.adView];
        [self bringSubviewToFront:self.adView];
        
    }
    
}

- (void)commonInit;
{
    AppDelegate *appController = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    self.gra = appController.gra;
    NSMutableDictionary *weightMap = [NSMutableDictionary dictionary];
    
    NSArray *myJSON = [[NSUserDefaults standardUserDefaults] arrayForKey:@"gr_ads"];
    float mopubWeight = 0;
    float admobWeight = 0;
    
    for(int i=0; i < [myJSON count]; i++) {
        NSDictionary *myObject = [myJSON objectAtIndex:i];
        NSString *type = [myObject valueForKey:@"type"];
        NSString *weight = [myObject valueForKey:@"weight"];
        if([type isEqualToString:@"mopub"]) {
            NSLog(@"MOPUB!");
        }
        else if([type isEqualToString:@"admob"]) {
            NSLog(@"ADMOB");
        }
        [weightMap setValue:weight forKey:type];
        
    }
    
    //https://stackoverflow.com/a/9708772/211457
//    NSArray *myArray;
//    
//    myArray = [weightMap keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
//        
//        if ([obj1 integerValue] > [obj2 integerValue]) {
//            
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        if ([obj1 integerValue] < [obj2 integerValue]) {
//            
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        
//        return (NSComparisonResult)NSOrderedSame;
//    }];
//    
//    
    #define ARC4RANDOM_MAX      0x100000000
//    ...
    double random = ((double)arc4random() / ARC4RANDOM_MAX);
    float previousWeights=0;
//    NSString *mopub = [weightMap objectForKey:@"mopub"];
//    NSString *adsense = [weightMap objectForKey:@"adnsense"];
//
    for(id key in weightMap) {
        NSString *value = [weightMap objectForKey:key];
        float valueFloat = [value floatValue];
        NSLog(@"key=%@ value=%@", key, value);
        NSLog(@"random=%f", random);
        if(random <  valueFloat + previousWeights) {
            if([key isEqualToString:@"mopub"]) {
                [self initMoPub];
                break;
            }
            else if([key isEqualToString:@"admob"]) {
                [self initAdmob];
                break;
            }
           // NSLog(@"good to go");
        }
        previousWeights += valueFloat;
    }

}

@end
