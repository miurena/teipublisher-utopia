(:~

    Transformation module generated from TEI ODD extensions for processing models.
    ODD: /db/apps/demo-multilingual-utopia-january-2024/resources/odd/Utopia.odd
 :)
xquery version "3.1";

module namespace model="http://www.tei-c.org/pm/models/Utopia/web";

declare default element namespace "http://www.tei-c.org/ns/1.0";

declare namespace xhtml='http://www.w3.org/1999/xhtml';

declare namespace ns='https://miurena.github.io/';

declare namespace pb='http://teipublisher.com/1.0';

import module namespace css="http://www.tei-c.org/tei-simple/xquery/css";

import module namespace html="http://www.tei-c.org/tei-simple/xquery/functions";

(:~

    Main entry point for the transformation.
    
 :)
declare function model:transform($options as map(*), $input as node()*) {
        
    let $config :=
        map:merge(($options,
            map {
                "output": ["web"],
                "odd": "/db/apps/demo-multilingual-utopia-january-2024/resources/odd/Utopia.odd",
                "apply": model:apply#2,
                "apply-children": model:apply-children#3
            }
        ))
    
    return (
        html:prepare($config, $input),
    
        let $output := model:apply($config, $input)
        return
            html:finish($config, $output)
    )
};

declare function model:apply($config as map(*), $input as node()*) {
        let $parameters := 
        if (exists($config?parameters)) then $config?parameters else map {}
        let $mode := 
        if (exists($config?mode)) then $config?mode else ()
        let $trackIds := 
        $parameters?track-ids
        let $get := 
        model:source($parameters, ?)
    return
    $input !         (
            let $node := 
                .
            return
                            typeswitch(.)
                    case element(ab) return
                        html:paragraph($config, ., ("tei-ab", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(anchor) return
                        html:note($config, ., ("tei-anchor", css:map-rend-to-class(.)), let $n := @n return $get(.)/ancestor::TEI//div[@type='notes']//note[@n=$n]/node(), (), @n/string())                        => model:map($node, $trackIds)
                    case element(author) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-author1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-author2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(back) return
                        html:block($config, ., ("tei-back", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(bibl) return
                        if (parent::listBibl) then
                            html:listItem($config, ., ("tei-bibl1", css:map-rend-to-class(.)), ., ())                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-bibl2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(body) return
                        (
                            html:index($config, ., ("tei-body1", css:map-rend-to-class(.)), 'toc', .)                            => model:map($node, $trackIds),
                            html:block($config, ., ("tei-body2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        )

                    case element(cb) return
                        html:break($config, ., ("tei-cb", css:map-rend-to-class(.)), ., 'column', @n)                        => model:map($node, $trackIds)
                    case element(corr) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            (: simple inline, if in parent choice. :)
                            html:inline($config, ., ("tei-corr1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-corr2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(date) return
                        if (@when) then
                            html:alternate($config, ., ("tei-date1", css:map-rend-to-class(.)), ., ., @when, map {})                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-date2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(del) return
                        html:inline($config, ., ("tei-del", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(div) return
                        if (@type="title-page") then
                            html:block($config, ., ("tei-div", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(edition) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-edition", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(foreign) return
                        html:inline($config, ., ("tei-foreign", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(front) return
                        html:block($config, ., ("tei-front", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(group) return
                        html:block($config, ., ("tei-group", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(head) return
                        if ($parameters?header='short') then
                            html:inline($config, ., ("tei-head1", css:map-rend-to-class(.)), replace(string-join(.//text()[not(parent::ref)]), '^(.*?)[^\w]*$', '$1'))                            => model:map($node, $trackIds)
                        else
                            if (parent::figure) then
                                html:block($config, ., ("tei-head2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                if (parent::table) then
                                    html:block($config, ., ("tei-head3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                else
                                    if (parent::lg) then
                                        html:block($config, ., ("tei-head4", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                                    else
                                        if (parent::list) then
                                            html:block($config, ., ("tei-head5", css:map-rend-to-class(.)), .)                                            => model:map($node, $trackIds)
                                        else
                                            if (parent::div) then
                                                html:heading($config, ., ("tei-head6", css:map-rend-to-class(.)), ., count(ancestor::div))                                                => model:map($node, $trackIds)
                                            else
                                                html:block($config, ., ("tei-head7", css:map-rend-to-class(.)), .)                                                => model:map($node, $trackIds)
                    case element(hi) return
                        html:inline($config, ., css:get-rendition(., ("tei-hi", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(l) return
                        html:block($config, ., css:get-rendition(., ("tei-l", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(licence) return
                        if (@target) then
                            html:link($config, ., ("tei-licence1", "licence", css:map-rend-to-class(.)), 'Licence', @target, (), map {})                            => model:map($node, $trackIds)
                        else
                            html:omit($config, ., ("tei-licence2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(lb) return
                        html:break($config, ., css:get-rendition(., ("tei-lb", css:map-rend-to-class(.))), ., 'line', @n)                        => model:map($node, $trackIds)
                    case element(lg) return
                        html:block($config, ., ("tei-lg", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(list) return
                        html:list($config, ., css:get-rendition(., ("tei-list", css:map-rend-to-class(.))), item, ())                        => model:map($node, $trackIds)
                    case element(listBibl) return
                        if (bibl) then
                            html:list($config, ., ("tei-listBibl1", css:map-rend-to-class(.)), ., ())                            => model:map($node, $trackIds)
                        else
                            html:block($config, ., ("tei-listBibl2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(note) return
                        if ($parameters?view='notes') then
                            html:listItem($config, ., ("tei-note", css:map-rend-to-class(.)), ., @n)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(p) return
                        html:paragraph($config, ., css:get-rendition(., ("tei-p2", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(pb) return
                        html:break($config, ., css:get-rendition(., ("tei-pb", css:map-rend-to-class(.))), ., 'page', (concat(if(@n) then concat(@n,' ') else '',if(@facs) then                   concat('@',@facs) else '')))                        => model:map($node, $trackIds)
                    case element(publicationStmt) return
                        html:block($config, ., ("tei-publicationStmt1", css:map-rend-to-class(.)), availability/licence)                        => model:map($node, $trackIds)
                    case element(q) return
                        if (l) then
                            html:block($config, ., css:get-rendition(., ("tei-q1", css:map-rend-to-class(.))), .)                            => model:map($node, $trackIds)
                        else
                            if (ancestor::p or ancestor::cell) then
                                html:inline($config, ., css:get-rendition(., ("tei-q2", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                            else
                                html:block($config, ., css:get-rendition(., ("tei-q3", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                    case element(quote) return
                        if (ancestor::p) then
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            html:inline($config, ., css:get-rendition(., ("tei-quote1", css:map-rend-to-class(.))), .)                            => model:map($node, $trackIds)
                        else
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            html:block($config, ., css:get-rendition(., ("tei-quote2", css:map-rend-to-class(.))), .)                            => model:map($node, $trackIds)
                    case element(ref) return
                        if (@target) then
                            html:link($config, ., ("tei-ref1", css:map-rend-to-class(.)), ., @target, (), map {})                            => model:map($node, $trackIds)
                        else
                            if (not(node())) then
                                html:link($config, ., ("tei-ref2", css:map-rend-to-class(.)), @target, @target, (), map {})                                => model:map($node, $trackIds)
                            else
                                html:inline($config, ., ("tei-ref3", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(role) return
                        html:block($config, ., ("tei-role", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(roleDesc) return
                        html:block($config, ., ("tei-roleDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(seg) return
                        if (@n) then
                            html:webcomponent($config, ., ("tei-seg1", css:map-rend-to-class(.)), ., 'pb-highlight', map {"key": @n, "highlight-self": 'highlight-self'})                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., css:get-rendition(., ("tei-seg2", css:map-rend-to-class(.))), .)                            => model:map($node, $trackIds)
                    case element(sic) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            html:inline($config, ., ("tei-sic1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-sic2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(fileDesc) return
                        if ($parameters?header='short') then
                            (
                                html:block($config, ., ("tei-fileDesc1", "header-short", css:map-rend-to-class(.)), titleStmt)                                => model:map($node, $trackIds),
                                html:block($config, ., ("tei-fileDesc2", "header-short", css:map-rend-to-class(.)), editionStmt)                                => model:map($node, $trackIds),
                                html:block($config, ., ("tei-fileDesc3", "header-short", css:map-rend-to-class(.)), publicationStmt)                                => model:map($node, $trackIds)
                            )

                        else
                            html:title($config, ., ("tei-fileDesc4", css:map-rend-to-class(.)), titleStmt)                            => model:map($node, $trackIds)
                    case element(profileDesc) return
                        html:omit($config, ., ("tei-profileDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(revisionDesc) return
                        html:omit($config, ., ("tei-revisionDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(encodingDesc) return
                        html:omit($config, ., ("tei-encodingDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(teiHeader) return
                        if ($parameters?header='short') then
                            html:block($config, ., ("tei-teiHeader3", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:metadata($config, ., ("tei-teiHeader4", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(TEI) return
                        html:document($config, ., ("tei-TEI", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(text) return
                        html:body($config, ., ("tei-text", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(title) return
                        if ($parameters?header='short') then
                            html:heading($config, ., ("tei-title1", css:map-rend-to-class(.)), ., 5)                            => model:map($node, $trackIds)
                        else
                            if (parent::titleStmt/parent::fileDesc) then
                                (
                                    if (preceding-sibling::title) then
                                        html:text($config, ., ("tei-title2", css:map-rend-to-class(.)), ' — ')                                        => model:map($node, $trackIds)
                                    else
                                        (),
                                    html:inline($config, ., ("tei-title3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                )

                            else
                                if (not(@level) and parent::bibl) then
                                    html:inline($config, ., ("tei-title4", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                else
                                    if (@level='m' or not(@level)) then
                                        (
                                            html:inline($config, ., ("tei-title5", css:map-rend-to-class(.)), .)                                            => model:map($node, $trackIds),
                                            if (ancestor::biblFull) then
                                                html:text($config, ., ("tei-title6", css:map-rend-to-class(.)), ', ')                                                => model:map($node, $trackIds)
                                            else
                                                ()
                                        )

                                    else
                                        if (@level='s' or @level='j') then
                                            (
                                                html:inline($config, ., ("tei-title7", css:map-rend-to-class(.)), .)                                                => model:map($node, $trackIds),
                                                if (following-sibling::* and     (  ancestor::biblFull)) then
                                                    html:text($config, ., ("tei-title8", css:map-rend-to-class(.)), ', ')                                                    => model:map($node, $trackIds)
                                                else
                                                    ()
                                            )

                                        else
                                            if (@level='u' or @level='a') then
                                                (
                                                    html:inline($config, ., ("tei-title9", css:map-rend-to-class(.)), .)                                                    => model:map($node, $trackIds),
                                                    if (following-sibling::* and     (    ancestor::biblFull)) then
                                                        html:text($config, ., ("tei-title10", css:map-rend-to-class(.)), '. ')                                                        => model:map($node, $trackIds)
                                                    else
                                                        ()
                                                )

                                            else
                                                html:inline($config, ., ("tei-title11", css:map-rend-to-class(.)), .)                                                => model:map($node, $trackIds)
                    case element(titlePage) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePage", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(titlePart) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePart", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(titleStmt) return
                        if ($parameters?mode='title') then
                            html:heading($config, ., ("tei-titleStmt3", css:map-rend-to-class(.)), title[not(@type)], 5)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?header='short') then
                                (
                                    html:link($config, ., ("tei-titleStmt4", css:map-rend-to-class(.)), title[1], $parameters?doc, (), map {})                                    => model:map($node, $trackIds),
                                    html:block($config, ., ("tei-titleStmt5", css:map-rend-to-class(.)), subsequence(title, 2))                                    => model:map($node, $trackIds),
                                    html:block($config, ., ("tei-titleStmt6", css:map-rend-to-class(.)), author)                                    => model:map($node, $trackIds)
                                )

                            else
                                html:block($config, ., ("tei-titleStmt7", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(w) return
                        html:inline($config, ., ("tei-w", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(lem) return
                        html:alternate($config, ., ("tei-lem", css:map-rend-to-class(.)), ., ., concat("1790: ", string(following-sibling::rdg[@wit="1790"]), " 1805: ", string(following-sibling::rdg[@wit="1805"])), map {})                        => model:map($node, $trackIds)
                    case element(rdg) return
                        html:omit($config, ., ("tei-rdg", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(exist:match) return
                        html:match($config, ., .)
                    case element() return
                        if (namespace-uri(.) = 'http://www.tei-c.org/ns/1.0') then
                            $config?apply($config, ./node())
                        else
                            .
                    case text() | xs:anyAtomicType return
                        html:escapeChars(.)
                    default return 
                        $config?apply($config, ./node())

        )

};

declare function model:apply-children($config as map(*), $node as element(), $content as item()*) {
        
    if ($config?template) then
        $content
    else
        $content ! (
            typeswitch(.)
                case element() return
                    if (. is $node) then
                        $config?apply($config, ./node())
                    else
                        $config?apply($config, .)
                default return
                    html:escapeChars(.)
        )
};

declare function model:source($parameters as map(*), $elem as element()) {
        
    let $id := $elem/@exist:id
    return
        if ($id and $parameters?root) then
            util:node-by-id($parameters?root, $id)
        else
            $elem
};

declare function model:process-annotation($html, $context as node()) {
        
    let $classRegex := analyze-string($html/@class, '\s?annotation-([^\s]+)\s?')
    return
        if ($classRegex//fn:match) then (
            if ($html/@data-type) then
                ()
            else
                attribute data-type { ($classRegex//fn:group)[1]/string() },
            if ($html/@data-annotation) then
                ()
            else
                attribute data-annotation {
                    map:merge($context/@* ! map:entry(node-name(.), ./string()))
                    => serialize(map { "method": "json" })
                }
        ) else
            ()
                    
};

declare function model:map($html, $context as node(), $trackIds as item()?) {
        
    if ($trackIds) then
        for $node in $html
        return
            typeswitch ($node)
                case document-node() | comment() | processing-instruction() return 
                    $node
                case element() return
                    if ($node/@class = ("footnote")) then
                        if (local-name($node) = 'pb-popover') then
                            ()
                        else
                            element { node-name($node) }{
                                $node/@*,
                                $node/*[@class="fn-number"],
                                model:map($node/*[@class="fn-content"], $context, $trackIds)
                            }
                    else
                        element { node-name($node) }{
                            attribute data-tei { util:node-id($context) },
                            $node/@*,
                            model:process-annotation($node, $context),
                            $node/node()
                        }
                default return
                    <pb-anchor data-tei="{ util:node-id($context) }">{$node}</pb-anchor>
    else
        $html
                    
};

