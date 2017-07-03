//  GreenRobotAds.h
//
//  Created by Andy Triboletti on 6/24/17.
//
//

#import <Foundation/Foundation.h>

@interface GreenRobotAds : NSObject
- (id)initialize:(NSString*) urlString;
@property (nonatomic, retain) NSString* admobiPhoneUnitId;
@property (nonatomic, retain) NSString* admobiPadUnitId;
@property (nonatomic, retain) NSString* mopubiPhoneUnitId;
@property (nonatomic, retain) NSString* mopubiPadUnitId;

@end
