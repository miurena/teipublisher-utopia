module namespace pml='http://www.tei-c.org/pm/models/Utopia/epub/module';

import module namespace m='http://www.tei-c.org/pm/models/Utopia/epub' at '/db/apps/demo-multilingual-utopia-january-2024/transform/Utopia-epub.xql';

(: Generated library module to be directly imported into code which
 : needs to transform TEI nodes using the ODD this module is based on.
 :)
declare function pml:transform($xml as node()*, $parameters as map(*)?) {

   let $options := map {
       "styles": ["transform/Utopia.css"],
       "collection": "/db/apps/demo-multilingual-utopia-january-2024/transform",
       "parameters": if (exists($parameters)) then $parameters else map {}
   }
   return m:transform($options, $xml)
};