#import  "LCTokenFilter.h"


@implementation LCTokenFilter

/** A TokenFilter is a TokenStream whose input is another token stream.
<p>
This is an abstract class.
*/

/** Construct a token stream filtering the given input. */
- (id) initWithTokenStream: (LCTokenStream *) i
{
	self = [self init];
	input = i;
	return self;
}

- (void) dealloc
{
	input=nil;;
}

- (void) close
{
	[input close];
}

@end

