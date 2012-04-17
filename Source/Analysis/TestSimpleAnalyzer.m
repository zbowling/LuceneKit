#import  "LCSimpleAnalyzer.h"
#import  "LCLowerCaseTokenizer.h"
#import  "TestAnalyzer.h"


@interface TestSimpleAnalyzer: NSObject <UKTest>
@end

@implementation TestSimpleAnalyzer

- (void) testSimpleAnalyzer
{
	NSString *s = @"This is a beautiful day!";
	NSArray *a = [NSArray arrayWithObjects: @"this", @"is", @"a", @"beautiful", @"day", nil];
	LCSimpleAnalyzer *analyzer = [[LCSimpleAnalyzer alloc] init];
	[analyzer compare: s and: a with: analyzer];
}

@end
