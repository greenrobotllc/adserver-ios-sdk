//  GreenRobotAds.m
//
//  Created by Andy Triboletti on 6/24/17.
//
//

#import "GreenRobotAds.h"

@implementation GreenRobotAds



- (id)initialize:(NSString*) urlString
{
    
    self.admobiPhoneUnitId =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"admob_iphone_unit_id"];
    self.admobiPadUnitId =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"admob_ipad_unit_id"];
    self.mopubiPhoneUnitId =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"mopub_iphone_unit_id"];
    self.mopubiPadUnitId =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"mopub_ipad_unit_id"];

    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    data = nil;
    if(data == nil) {
        NSMutableDictionary *mopub = [NSMutableDictionary dictionary];
        [mopub setValue:@"mopub" forKey:@"type"];
        [mopub setValue:@"0.5" forKey:@"weight"];
        NSMutableDictionary *admob = [NSMutableDictionary dictionary];
        [admob setValue:@"admob" forKey:@"type"];
        [admob setValue:@"0.5" forKey:@"weight"];
        NSArray *results = @[mopub, admob];
        [[NSUserDefaults standardUserDefaults] setObject:results forKey:@"gr_ads"];

        return self;
    }
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //NSLog(@"json: %@", json);
    
    [[NSUserDefaults standardUserDefaults] setObject:json forKey:@"gr_ads"];
    
    return self;
}

@end
