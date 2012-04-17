#import  "LCPrefixQuery.h"
#import  "LCBooleanQuery.h"
#import  "LCTermQuery.h"
#import  "LCTermEnum.h"
#import  "LCSmallFloat.h"
#import  "NSString+Additions.h"


@implementation LCPrefixQuery

- (id) initWithTerm: (LCTerm *) p
{
	self = [self init];
	prefix = p;
	return self;
}

- (LCQuery *) rewrite: (LCIndexReader *) reader
{
	LCBooleanQuery *query = [[LCBooleanQuery alloc] initWithCoordination: YES];
	@autoreleasepool {
		LCTermEnumerator *enumerator = [reader termEnumeratorWithTerm: prefix];
		NSString *prefixText = [prefix text];
		NSString *prefixField = [prefix field];
		do {
			LCTerm *term = [enumerator term];
			if (term != nil &&
				[[term text] hasPrefix: prefixText] &&
				[[term field] isEqualToString: prefixField])
			{
				LCTermQuery *tq = [[LCTermQuery alloc] initWithTerm: term]; // found a match
				[tq setBoost: [self boost]]; // set the boost
				[query addQuery: tq occur: LCOccur_SHOULD]; // add to quer
				tq=nil;;
			} else {
				break;
			}
		} while ([enumerator hasNextTerm]);
		[enumerator close];
	}
	return query;
}

- (void) dealloc
{
	prefix=nil;;
}

- (LCTerm *) prefix
{
	return prefix;
}

- (NSString *) descriptionWithField: (NSString *) field
{
	NSMutableString *buffer = [[NSMutableString alloc] init];
	if (![[prefix field] isEqualToString: field])
	{
		[buffer appendFormat: @"%@:", [prefix field]];
    }
	[buffer appendFormat: @"%@*", [prefix text]];
	[buffer appendString: LCStringFromBoost([self boost])];
	return buffer;
}

- (BOOL) isEqual: (id) o
{
	if ([o isKindOfClass: [self class]] == NO)
	{
		return NO;
	}
	LCPrefixQuery *other = (LCPrefixQuery *) o;
	return (([self boost] == [other boost]) && ([[self prefix] isEqual: [other prefix]]));
}

- (NSUInteger) hash
{
	return FloatToIntBits([self boost]) ^ [prefix hash] ^ 0x6634D93C;
}

@end
