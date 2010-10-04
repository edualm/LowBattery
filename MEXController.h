//
//  MEXController.h
//  LowBattery
//
//  Created by Eduardo Almeida on 10/08/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MEXController : NSObject {
	IBOutlet UITextField *percentageField;
	IBOutlet UITextField *secondsField;
	IBOutlet UIWindow *window;
}

- (void)scheduleBatteryNotificationForDate:(NSDate *)alarmDate;
- (IBAction)createBatteryWarning:(id)sender;

@end
