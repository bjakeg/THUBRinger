//
//  NetworkHandler.h
//  Phone
//
//  Created by Jake Graham on 4/24/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PhoneState){
    PhoneStateCalling,
    PhoneStateConnecting,
    PhoneStateConnected,
    PhoneStateAccepted,
    PhoneStateNeedModule
};

@interface NetworkHandler : NSObject

- (void)initNetworkCommunication;
- (void)dial:(NSString *)extension;

@end
