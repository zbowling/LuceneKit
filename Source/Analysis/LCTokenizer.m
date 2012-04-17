#import  "LCTokenizer.h"
#import  "LCReader.h"


@implementation LCTokenizer

/** A Tokenizer is a TokenStream whose input is a Reader.
<p>
This is an abstract class.
*/

/** Construct a token stream processing the given input. */
- (id) initWithReader: (id <LCReader>) i
{
	self = [super init];
	input = i;
	return self;
}

- (void) close
{
	[input close];
}

@end
