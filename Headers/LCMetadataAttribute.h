#ifndef __LuceneKit_LCMetadata_Attribute__
#define __LuceneKit_LCMetadata_Attribute__

#import  <Foundation/NSString.h>

/* These attributes will be stored in index data. */
  /* Importer usually doesn't set LCMetadataChangeDateAttribute. LCIndexManager will do. */
extern NSString * const LCMetadataChangeDateAttribute;
extern NSString * const LCContentCreationDateAttribute;
extern NSString * const LCContentModificationDateAttribute;
extern NSString * const LCContentTypeAttribute;
extern NSString * const LCCreatorAttribute;
extern NSString * const LCEmailAddressAttribute;
extern NSString * const LCIdentifierAttribute;
extern NSString * const LCPathAttribute;

/* These attributes will NOT be stored in index data */
extern NSString * const LCTextContentAttribute;

#endif /*  __LuceneKit_LCMetadata_Attribute__ */
