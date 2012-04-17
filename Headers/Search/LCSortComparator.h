#ifndef __LUCENE_SEARCH_SORT_COMPARATOR__
#define __LUCENE_SEARCH_SORT_COMPARATOR__

#import  "LCSortComparatorSource.h"

@interface LCSortComparator: NSObject <LCSortComparatorSource>
{
	NSDictionary *cachedValue;
}
- (id) comparable: (NSString *) termtext;
@end

#endif /* __LUCENE_SEARCH_SORT_COMPARATOR__ */
