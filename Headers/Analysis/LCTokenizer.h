#ifndef __LUCENE_ANALYSIS_TOKENIZER__
#define __LUCENE_ANALYSIS_TOKENIZER__

#import  <Foundation/Foundation.h>
#import  "LCTokenStream.h"
#import  "LCReader.h"

/* A token stream specified for LCReader */
@interface LCTokenizer: LCTokenStream
{
	/** The text source for this Tokenizer. */
	id <LCReader> input;
}

- (id) initWithReader: (id <LCReader>) input;

@end

#endif /* __LUCENE_ANALYSIS_TOKENIZER__ */
