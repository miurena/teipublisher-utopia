import module namespace m='http://www.tei-c.org/pm/models/Utopia/epub' at '/db/apps/Utopia/transform/Utopia-epub.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/Utopia.css"],
    "collection": "/db/apps/Utopia/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)