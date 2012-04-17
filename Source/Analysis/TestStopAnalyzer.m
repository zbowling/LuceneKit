#import  "LCStopAnalyzer.h"

#import  <UnitKit/UnitKit.h>
#import  "TestAnalyzer.h"

@interface TestStopAnalyzer: NSObject <UKTest>
@end

@implementation TestStopAnalyzer

- (void) testStopAnalyzer
{
	NSString *s = @"This is a beautiful day!";
	NSArray *a = [NSArray arrayWithObjects: @"beautiful", @"day", nil];
	LCStopAnalyzer *analyzer = [[LCStopAnalyzer alloc] init];
	[analyzer compare: s and: a with: analyzer];
}

@end

