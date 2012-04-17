#ifndef __LUCENE_INDEX_FILTER_INDEX_READER__
#define __LUCENE_INDEX_FILTER_INDEX_READER__

#import  "LCIndexReader.h"
#import  "LCTermDocs.h"
#import  "LCTermPositions.h"
#import  "LCTermEnum.h"

@interface LCFilterTermDocuments: NSObject <LCTermDocuments>
{
	id <LCTermDocuments> input;
}

- (id) initWithTermDocuments: (id <LCTermDocuments>) docs;

@end

@interface LCFilterTermPositions: LCFilterTermDocuments <LCTermPositions>
- (id) initWithTermPositions: (id <LCTermPositions>) po;
@end

@interface LCFilterTermEnumerator: LCTermEnumerator
{
	LCTermEnumerator* input;
}

- (id) initWithTermEnumerator: (LCTermEnumerator *) termEnum;
@end

@interface LCFilterIndexReader: LCIndexReader
{
	LCIndexReader *input;
}

- (id) initWithIndexReader: (LCIndexReader *) reader;

@end

#endif /* __LUCENE_INDEX_FILTER_INDEX_READER__ */
