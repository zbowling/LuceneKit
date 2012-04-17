#ifndef __LUCENE_SEARCH_FILTER__
#define __LUCENE_SEARCH_FILTER__

#import  <Foundation/Foundation.h>
#import  "LCBitVector.h"
#import  "LCIndexReader.h"

@interface LCFilter: NSObject
/* LuceneKit: use LCBitVector for BitSet in Java */
- (LCBitVector *) bits: (LCIndexReader *) reader;
@end

#endif /* __LUCENE_SEARCH_FILTER__ */
