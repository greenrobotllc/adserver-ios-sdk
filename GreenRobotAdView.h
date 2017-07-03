//  GreenRobotAdView.h

//  Created by Andy Triboletti on 6/17/17.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "MoPub.h"
#import "GreenRobotAdView.h"
#import "GreenRobotAds.h"

@interface GreenRobotAdView : UIView <GADBannerViewDelegate, UIWebViewDelegate, MPAdViewDelegate> {
}


@property (nonatomic, retain) GADBannerView *bannerView;
@property (nonatomic, retain) MPAdView *adView;
@property (nonatomic, retain) UIWebView *libertyAdView;

@property (nonatomic, retain) UIViewController* rootViewController;
@property (nonatomic, retain) NSString* libertyWidgetID;
@property (nonatomic, retain) GreenRobotAds* gra;
- (id)initWithRootViewController :(UIViewController*) myRootViewController withWidgetID:(NSString*) widgetID;
@end
