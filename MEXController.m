//
//  MEXController.m
//  LowBattery
//
//  Created by Eduardo Almeida on 10/08/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MEXController.h"


@implementation MEXController

- (void)awakeFromNib {
	[window makeKeyAndVisible]; // Fix that shouldn't be needed but somehow... is.
}

- (IBAction)createBatteryWarning:(id)sender {
	NSDate *alarmDate = [NSDate dateWithTimeIntervalSinceNow:[[secondsField text] intValue]];
	[self scheduleBatteryNotificationForDate:alarmDate];
}

- (void)scheduleBatteryNotificationForDate:(NSDate *)alarmDate {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *oldNotifications = [app scheduledLocalNotifications];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
    // Clear out the old notification before scheduling a new one.
    if ([oldNotifications count] > 0)
        [app cancelAllLocalNotifications];
	
    // Create a new notification
    UILocalNotification *alarm = [[[UILocalNotification alloc] init] autorelease];
    if (alarm) {
        alarm.fireDate = alarmDate;
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
        alarm.alertBody = [NSString stringWithFormat:@"%@%%%% of battery remaining", [percentageField text]];
		
        [app scheduleLocalNotification:alarm];
    }
	
	NSLog(@"Done.");
	
	if (![[defaults objectForKey:@"Helped the User"] isEqualToString:@"Yes"]) {
		UIAlertView *alert = [UIAlertView new];
		[alert initWithTitle:@"Alright!" message:@"Your job is done.\n\n Dismiss this alert and close the app now, and wait for the low battery alert to appear!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[defaults setObject:@"Yes" forKey:@"Helped the User"];
		[defaults synchronize];
	}

}

@end
