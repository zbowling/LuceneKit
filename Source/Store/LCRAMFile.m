#import  "LCRAMFile.h"


@implementation LCRAMFile

- (id) init
{
	self = [super init];
	buffers = [[NSMutableData alloc] init];
	lastModified = [[NSDate date] timeIntervalSinceReferenceDate];
	return self;
}


- (NSData *) buffers
{
	return buffers;
}

- (void) addData: (NSData *) data
{
	[buffers appendData: data];
}

- (unsigned long long) length
{
	return [buffers length];
}

- (void) setLength: (unsigned long long) length
{
	[buffers setLength: length];
}

- (NSTimeInterval) lastModified
{
	return lastModified;
}

- (void) setLastModified: (NSTimeInterval) t
{
	lastModified = t;
}

@end
