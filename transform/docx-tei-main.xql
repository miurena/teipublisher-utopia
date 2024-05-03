import module namespace m='http://www.tei-c.org/pm/models/docx/tei' at '/db/apps/demo-multilingual-utopia-january-2024/transform/docx-tei.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/docx.css"],
    "collection": "/db/apps/demo-multilingual-utopia-january-2024/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)