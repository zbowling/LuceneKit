#import  "LCTopFieldDocs.h"


@implementation LCTopFieldDocs
- (id) initWithTotalHits: (int) th
		  scoreDocuments: (NSArray *) sd
			  sortFields: (NSArray *) f
			maxScore: (float) max
{
	self = [self initWithTotalHits: th scoreDocuments: sd maxScore: max];
	fields = f;
	return self;
}

- (void) dealloc
{
	fields=nil;;
}
@end
