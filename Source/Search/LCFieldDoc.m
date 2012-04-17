#import  "LCFieldDoc.h"


@implementation LCFieldDoc

- (id) initWithDocument: (int) d
				  score: (float) s fields: (NSArray *) f
{
	self = [self initWithDocument: d score: s];
	[self setFields: f];
	return self;
}

- (void) dealloc
{
	fields=nil;;
}

- (NSArray *) fields
{
	return fields;
}

- (void) setFields: (NSArray *) f
{
	fields =[ f copy];
}

@end
