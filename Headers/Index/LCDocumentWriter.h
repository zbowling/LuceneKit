#ifndef __LUCENE_INDEX_DOCUMENT_WRITER__
#define __LUCENE_INDEX_DOCUMENT_WRITER__

#import  <Foundation/Foundation.h>
#import  "LCDirectory.h"
#import  "LCAnalyzer.h"
#import  "LCSimilarity.h"
#import  "LCDocument.h"
#import  "LCIndexWriter.h"

@class LCFieldInfos;

@interface LCDocumentWriter: NSObject
{
	LCAnalyzer *analyzer;
	id <LCDirectory> directory;
	LCSimilarity *similarity;
	int maxFieldLength;
	int termIndexInterval;
	
	/*** Private ***/
	// Keys are Terms, values are Postings.
	// Used to buffer a document before it is written to the index.
	LCFieldInfos *fieldInfos;
	NSMutableDictionary *postingTable;
	float *fieldBoosts;
	long long *fieldLengths;
	long long *fieldPositions;
	long long *fieldOffsets;
}

- (id) initWithDirectory: (id <LCDirectory>) directory
				analyzer: (LCAnalyzer *) analyzer
			  similarity: (LCSimilarity *) similarity
		  maxFieldLength: (int) maxFieldLength;
- (id) initWithDirectory: (id <LCDirectory>) directory
				analyzer: (LCAnalyzer *) analyzer
			 indexWriter: (LCIndexWriter *) indexWriter;
- (void) addDocument: (NSString *) segment
			document: (LCDocument *) doc;

@end

#endif /* __LUCENE_INDEX_DOCUMENT_WRITER__ */
