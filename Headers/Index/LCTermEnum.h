#ifndef __LUCENE_INDEX_TERM_ENUM__
#define __LUCENE_INDEX_TERM_ENUM__

#import  <Foundation/Foundation.h>
#import  "LCTerm.h"

@interface LCTermEnumerator: NSObject
{
}

- (BOOL) hasNextTerm;
- (LCTerm *) term;
- (long) documentFrequency;
- (void) close;
- (BOOL) skipTo: (LCTerm *) target;

@end

#endif /* __LUCENE_INDEX_TERM_ENUM__ */
