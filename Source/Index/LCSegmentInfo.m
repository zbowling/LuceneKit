#import  "LCSegmentInfo.h"


@implementation LCSegmentInfo

- (id) initWithName: (NSString *) n
  numberOfDocuments: (int) count
		  directory: (id <LCDirectory>) d
{
	self = [super init];
	name = n;
	docCount = count;
	dir = d;
	return self;
}

- (void) dealloc
{
	name=nil;;
	dir=nil;;
}

- (NSString *) name
{
	return name;
}

- (int) numberOfDocuments
{
	return docCount;
}

- (id <LCDirectory>) directory
{
	return dir;
}

- (NSString *) description
{
	return [NSString stringWithFormat: @"LCSegmentInfo: name %@, docCount %d", name, docCount];
}

@end
