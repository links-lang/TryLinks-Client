/* Simple Adaptation to highlight links
 */

CodeMirror.defineSimpleMode("links", {
    // The start state contains the rules that are intially used
    start: [
        // The regex matches the token, the token property contains the type
        {regex: /"(?:[^\\]|\\.)*?(?:"|$)/, token: "string"},
        // Rules are matched in the order in which they appear, so there is
        // no ambiguity between this one and the one above
        {regex: /(?:var|fun|if|else|switch|for|else|do|this)\b/,
            token: "keyword"},
        {regex: /l:/,
            token: "keyword"},
        {regex: /true|false|[]|Int|Bool|Char|Float|Xml|String|<#>|<\/#>|page/, token: "atom"},
        {regex: /0x[a-f\d]+|[-+]?(?:\.\d+|\d+\.?\d*)(?:e[-+]?\d+)?/i,
            token: "number"},
        {regex: /#.*/, token: "comment"},
        // A next property will cause the mode to move to a different state
        {regex: /[\+\-\^\*\&\%\/=<>!\.:\|\~]|mod|not/, token: "operator"},
        {regex: /[A-Za-z$][\w$]*/, token: "variable"}
    ],
    // The meta property contains global information about the mode. It
    // can contain properties like lineComment, which are supported by
    // all modes, and also directives like dontIndentStates, which are
    // specific to simple modes.
    meta: {
        dontIndentStates: ["comment"],
        lineComment: "#"
    }
});
