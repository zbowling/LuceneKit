#import  "LCWhitespaceAnalyzer.h"
#import  "LCWhitespaceTokenizer.h"


@implementation LCWhitespaceAnalyzer

- (LCTokenStream *) tokenStreamWithField: (NSString *) name
								  reader: (id <LCReader>) reader
{
	return [[LCWhitespaceTokenizer alloc] initWithReader: reader];
}

@end
