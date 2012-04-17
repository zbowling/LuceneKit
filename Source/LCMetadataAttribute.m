#import  "LCMetadataAttribute.h"


/* These attributes will be stored in index data. */
/* Importer usually doesn't set LCMetadataChangeDateAttribute. LCIndexManager will do. */
NSString * const LCMetadataChangeDateAttribute = @"LCMetadataChangeDateAttribute";
NSString * const LCContentCreationDateAttribute = @"LCContentCreationDateAttribute";
NSString * const LCContentModificationDateAttribute = @"LCContentModificationDateAttribute";
NSString * const LCContentTypeAttribute = @"LCContentTypeAttribute";
NSString * const LCCreatorAttribute = @"LCCreatorAttribute";
NSString * const LCEmailAddressAttribute = @"LCEmailAddressAttribute";
NSString * const LCIdentifierAttribute = @"LCIdentifierAttribute";
NSString * const LCPathAttribute = @"LCPathAttribute";

/* These attributes will NOT be stored in index data */
NSString * const LCTextContentAttribute = @"LCTextContentAttribute";
