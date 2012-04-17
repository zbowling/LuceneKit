#import  "LCQueryParser.h"
#import  "LCBooleanQuery.h"
#import  "LCPrefixQuery.h"
#import  "LCTermQuery.h"
#import  "LCMetadataAttribute.h"

#import  "CodeParser.h"
#import  "QueryHandler.h"

@implementation LCQueryParser

+ (LCQuery *) parse: (NSString *) query
{
  return [LCQueryParser parse: query defaultField: LCTextContentAttribute];
}

+ (LCQuery *) parse: (NSString *) query defaultField: (NSString *) field
{
  QueryHandler *handler = [[QueryHandler alloc] init];
  [handler setDefaultField: field];
  CodeParser *parser = [[CodeParser alloc] initWithCodeHandler: handler withString: query];
  [parser parse];
//  NSLog(@"%@", [handler query]);
  return [handler query];
}

@end

