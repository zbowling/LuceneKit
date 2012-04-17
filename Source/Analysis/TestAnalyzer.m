#import  "LCAnalyzer.h"

#import  <UnitKit/UnitKit.h>
#import  "LCStringReader.h"

@implementation LCAnalyzer (UKTest_Additions)

- (void) compare: (NSString *) s and: (NSArray *) a 
            with: (LCAnalyzer *) analyzer
{
	LCStringReader *reader = [[LCStringReader alloc] initWithString: s];
	LCTokenStream *stream = [analyzer tokenStreamWithField: @"contents"
													reader: reader];
	int i = 0;
	LCToken *token;
	while((token = [stream nextToken]))
    {
		UKStringsEqual([a objectAtIndex: i++], [token termText]);
    }
	
	[reader release];
}
@end
