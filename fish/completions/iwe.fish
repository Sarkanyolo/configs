# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_iwe_global_optspecs
    string join \n v/verbose= h/help V/version
end

function __fish_iwe_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_iwe_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_iwe_using_subcommand
    set -l cmd (__fish_iwe_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c iwe -n "__fish_iwe_needs_command" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_needs_command" -s h -l help -d 'Print help'
complete -c iwe -n "__fish_iwe_needs_command" -s V -l version -d 'Print version'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "init" -d 'Initialize the current directory as an IWE project'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "new" -d 'Create a new document from a template'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "retrieve" -d 'Retrieve document content with expansion and context'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "find" -d 'Search and discover documents'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "count" -d 'Count documents matching a filter '
complete -c iwe -n "__fish_iwe_needs_command" -f -a "normalize" -d 'Normalize all markdown files in the project'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "tree" -d 'Display document hierarchy as a tree'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "squash" -d 'Consolidate linked documents into a single file'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "export" -d 'Export the graph structure in various formats'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "schema" -d 'Infer and display frontmatter schema'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "stats" -d 'Display graph statistics'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "rename" -d 'Rename a document and update all references to it'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "delete" -d 'Delete a document and clean up all references to it'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "extract" -d 'Extract a section to a new document with an inclusion link'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "inline" -d 'Replace an inclusion link with the referenced document content'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "update" -d 'Update document content or frontmatter'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "attach" -d 'Attach a document as a block reference via configured attach actions'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "completions" -d 'Generate shell completion script'
complete -c iwe -n "__fish_iwe_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c iwe -n "__fish_iwe_using_subcommand init" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand new" -s t -l template -d 'Template name from config' -r
complete -c iwe -n "__fish_iwe_using_subcommand new" -s c -l content -d 'Content for the new document' -r
complete -c iwe -n "__fish_iwe_using_subcommand new" -s i -l if-exists -d 'Behavior when file already exists: suffix (append -1, -2, etc.), override (overwrite), skip (do nothing)' -r -f -a "suffix\t''
override\t''
skip\t''"
complete -c iwe -n "__fish_iwe_using_subcommand new" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand new" -s e -l edit -d 'Open created file in $EDITOR'
complete -c iwe -n "__fish_iwe_using_subcommand new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s d -l depth -d 'Follow block refs down N levels' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s c -l context -d 'Include N levels of parent context' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s e -l exclude -d 'Exclude document key(s) from results (can be specified multiple times)' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s f -l format -r -f -a "markdown\t''
keys\t''
json\t''
yaml\t''"
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l filter -d 'Filter expression. Inline YAML; wrapped in `{}` and parsed as a filter document. Example: --filter \'status: pending\'.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s k -l key -d 'Match by document key. Repeatable: 1 key uses $eq, 2+ uses $in.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l includes -d '$includes anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l included-by -d '$includedBy anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l references -d '$references anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l referenced-by -d '$referencedBy anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l in -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l in-any -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l not-in -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l refs-to -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l refs-from -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l max-depth -d 'Default maxDepth applied to inclusion anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l max-distance -d 'Default maxDistance applied to reference anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s l -l links -d 'Include inline references'
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s b -l backlinks -d 'Include incoming references'
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l dry-run -d 'Show document count and total lines without content'
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l no-content -d 'Exclude document content from results (metadata only)'
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l children -d 'Populate the `includes` array with child document edges'
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -l roots -d 'Only match root documents (those with no incoming inclusion edges).'
complete -c iwe -n "__fish_iwe_using_subcommand retrieve" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand find" -s l -l limit -d 'Maximum results (0 = unlimited)' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l project -d 'Projection: comma-list (name, name=path, name=$selector, $selector) or inline YAML mapping. Replaces the default.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l add-fields -d 'Additive projection: same grammar as --project, extends defaults rather than replacing.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l sort -d 'Sort by frontmatter field. Format: field:1 (asc) or field:-1 (desc).' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -s f -l format -r -f -a "markdown\t''
keys\t''
json\t''
yaml\t''"
complete -c iwe -n "__fish_iwe_using_subcommand find" -l filter -d 'Filter expression. Inline YAML; wrapped in `{}` and parsed as a filter document. Example: --filter \'status: pending\'.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -s k -l key -d 'Match by document key. Repeatable: 1 key uses $eq, 2+ uses $in.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l includes -d '$includes anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l included-by -d '$includedBy anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l references -d '$references anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l referenced-by -d '$referencedBy anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l in -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l in-any -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l not-in -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l refs-to -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l refs-from -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l max-depth -d 'Default maxDepth applied to inclusion anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l max-distance -d 'Default maxDistance applied to reference anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand find" -l roots -d 'Only match root documents (those with no incoming inclusion edges).'
complete -c iwe -n "__fish_iwe_using_subcommand find" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand count" -s l -l limit -d 'Cap the number of matches counted (0 = unlimited)' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l filter -d 'Filter expression. Inline YAML; wrapped in `{}` and parsed as a filter document. Example: --filter \'status: pending\'.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -s k -l key -d 'Match by document key. Repeatable: 1 key uses $eq, 2+ uses $in.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l includes -d '$includes anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l included-by -d '$includedBy anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l references -d '$references anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l referenced-by -d '$referencedBy anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l in -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l in-any -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l not-in -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l refs-to -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l refs-from -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l max-depth -d 'Default maxDepth applied to inclusion anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l max-distance -d 'Default maxDistance applied to reference anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand count" -l roots -d 'Only match root documents (those with no incoming inclusion edges).'
complete -c iwe -n "__fish_iwe_using_subcommand count" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand normalize" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand normalize" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand tree" -s f -l format -d 'Output format: markdown (nested list with links), keys, json, yaml' -r -f -a "markdown\t''
keys\t''
json\t''
yaml\t''"
complete -c iwe -n "__fish_iwe_using_subcommand tree" -s d -l depth -d 'Maximum depth to traverse' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l project -d 'Projection: comma-list (name, name=path, name=$selector, $selector) or inline YAML mapping. Replaces user-frontmatter additions.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l add-fields -d 'Additive projection: extends each tree node\'s default fields. Same grammar as --project.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l filter -d 'Filter expression. Inline YAML; wrapped in `{}` and parsed as a filter document. Example: --filter \'status: pending\'.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -s k -l key -d 'Match by document key. Repeatable: 1 key uses $eq, 2+ uses $in.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l includes -d '$includes anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l included-by -d '$includedBy anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l references -d '$references anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l referenced-by -d '$referencedBy anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l in -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l in-any -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l not-in -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l refs-to -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l refs-from -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l max-depth -d 'Default maxDepth applied to inclusion anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l max-distance -d 'Default maxDistance applied to reference anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand tree" -l roots -d 'Only match root documents (those with no incoming inclusion edges).'
complete -c iwe -n "__fish_iwe_using_subcommand tree" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand squash" -s d -l depth -r
complete -c iwe -n "__fish_iwe_using_subcommand squash" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand squash" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand export" -s f -l format -d 'Output format' -r -f -a "dot\t''"
complete -c iwe -n "__fish_iwe_using_subcommand export" -s d -l depth -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l filter -d 'Filter expression. Inline YAML; wrapped in `{}` and parsed as a filter document. Example: --filter \'status: pending\'.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -s k -l key -d 'Match by document key. Repeatable: 1 key uses $eq, 2+ uses $in.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l includes -d '$includes anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l included-by -d '$includedBy anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l references -d '$references anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l referenced-by -d '$referencedBy anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l in -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l in-any -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l not-in -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l refs-to -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l refs-from -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l max-depth -d 'Default maxDepth applied to inclusion anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l max-distance -d 'Default maxDistance applied to reference anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand export" -l include-headers -d 'Include section headers and create subgraphs for detailed visualization. When enabled, shows document structure with sections grouped in colored subgraphs'
complete -c iwe -n "__fish_iwe_using_subcommand export" -l roots -d 'Only match root documents (those with no incoming inclusion edges).'
complete -c iwe -n "__fish_iwe_using_subcommand export" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand schema" -s f -l format -d 'Output format for schema' -r -f -a "markdown\t''
json\t''
yaml\t''"
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l field -d 'Restrict output to a specific field (and its children)' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l filter -d 'Filter expression. Inline YAML; wrapped in `{}` and parsed as a filter document. Example: --filter \'status: pending\'.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -s k -l key -d 'Match by document key. Repeatable: 1 key uses $eq, 2+ uses $in.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l includes -d '$includes anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l included-by -d '$includedBy anchor. KEY or KEY:DEPTH (DEPTH defaults to --max-depth). Lowers to scalar shorthand when DEPTH=1, full form { match: { $key: KEY }, maxDepth: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l references -d '$references anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l referenced-by -d '$referencedBy anchor. KEY or KEY:DIST (DIST defaults to --max-distance). Lowers to scalar shorthand when DIST=1, full form { match: { $key: KEY }, maxDistance: N } otherwise. Repeatable; anchors are ANDed.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l in -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l in-any -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l not-in -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l refs-to -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l refs-from -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l max-depth -d 'Default maxDepth applied to inclusion anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l max-distance -d 'Default maxDistance applied to reference anchor flags without a colon-suffix. Default 1.' -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand schema" -l roots -d 'Only match root documents (those with no incoming inclusion edges).'
complete -c iwe -n "__fish_iwe_using_subcommand schema" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand stats" -s f -l format -d 'Output format for statistics' -r -f -a "markdown\t''
csv\t''
json\t''
yaml\t''"
complete -c iwe -n "__fish_iwe_using_subcommand stats" -s k -l key -d 'Document key for per-document stats. Omit for aggregate graph statistics.' -r
complete -c iwe -n "__fish_iwe_using_subcommand stats" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand stats" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand rename" -s f -l format -d 'Output format. `keys` prints affected document keys (one per line) and suppresses progress.' -r -f -a "markdown\t''
keys\t''"
complete -c iwe -n "__fish_iwe_using_subcommand rename" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand rename" -l dry-run -d 'Preview changes without writing to disk'
complete -c iwe -n "__fish_iwe_using_subcommand rename" -l quiet -d 'Suppress progress output'
complete -c iwe -n "__fish_iwe_using_subcommand rename" -l keys
complete -c iwe -n "__fish_iwe_using_subcommand rename" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand delete" -l filter -d 'Filter expression (inline YAML). Required if positional KEY omitted.' -r
complete -c iwe -n "__fish_iwe_using_subcommand delete" -s f -l format -d 'Output format. `keys` prints affected document keys (one per line) and suppresses progress.' -r -f -a "markdown\t''
keys\t''"
complete -c iwe -n "__fish_iwe_using_subcommand delete" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand delete" -l dry-run -d 'Preview changes without writing to disk'
complete -c iwe -n "__fish_iwe_using_subcommand delete" -l quiet -d 'Suppress progress output'
complete -c iwe -n "__fish_iwe_using_subcommand delete" -l keys
complete -c iwe -n "__fish_iwe_using_subcommand delete" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand extract" -l section -d 'Section title to extract (case-insensitive)' -r
complete -c iwe -n "__fish_iwe_using_subcommand extract" -l block -d 'Block number to extract (1-indexed)' -r
complete -c iwe -n "__fish_iwe_using_subcommand extract" -l action -d 'Action name from config to use for extraction' -r
complete -c iwe -n "__fish_iwe_using_subcommand extract" -s f -l format -d 'Output format. `keys` prints affected document keys (one per line) and suppresses progress.' -r -f -a "markdown\t''
keys\t''"
complete -c iwe -n "__fish_iwe_using_subcommand extract" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand extract" -l list -d 'List all sections with block numbers'
complete -c iwe -n "__fish_iwe_using_subcommand extract" -l dry-run -d 'Preview changes without writing to disk'
complete -c iwe -n "__fish_iwe_using_subcommand extract" -l quiet -d 'Suppress progress output'
complete -c iwe -n "__fish_iwe_using_subcommand extract" -l keys
complete -c iwe -n "__fish_iwe_using_subcommand extract" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l reference -d 'Reference key or title to inline' -r
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l block -d 'Block number to inline (1-indexed)' -r
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l action -d 'Action name from config to use for inlining' -r
complete -c iwe -n "__fish_iwe_using_subcommand inline" -s f -l format -d 'Output format. `keys` prints affected document keys (one per line) and suppresses progress.' -r -f -a "markdown\t''
keys\t''"
complete -c iwe -n "__fish_iwe_using_subcommand inline" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l list -d 'List all block references with numbers'
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l as-quote -d 'Inline as blockquote instead of section'
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l keep-target -d 'Keep the target document after inlining'
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l dry-run -d 'Preview changes without writing to disk'
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l quiet -d 'Suppress progress output'
complete -c iwe -n "__fish_iwe_using_subcommand inline" -l keys
complete -c iwe -n "__fish_iwe_using_subcommand inline" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand update" -s k -l key -d 'Document key. Required for body-overwrite mode; optional in frontmatter mutation mode.' -r
complete -c iwe -n "__fish_iwe_using_subcommand update" -s c -l content -d 'New full markdown content (body-overwrite mode). Use \'-\' to read from stdin.' -r
complete -c iwe -n "__fish_iwe_using_subcommand update" -l filter -d 'Filter expression for frontmatter mutation mode (inline YAML). Combined with -k via AND.' -r
complete -c iwe -n "__fish_iwe_using_subcommand update" -l set -d 'Frontmatter $set assignment FIELD=VALUE. VALUE is parsed as a YAML scalar.' -r
complete -c iwe -n "__fish_iwe_using_subcommand update" -l unset -d 'Frontmatter $unset field name.' -r
complete -c iwe -n "__fish_iwe_using_subcommand update" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand update" -l dry-run -d 'Preview without writing'
complete -c iwe -n "__fish_iwe_using_subcommand update" -l quiet -d 'Suppress progress output'
complete -c iwe -n "__fish_iwe_using_subcommand update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand attach" -l to -d 'Configured attach action(s) to attach to. Repeatable for multiple targets.' -r
complete -c iwe -n "__fish_iwe_using_subcommand attach" -s k -l key -d 'Source document key to attach' -r
complete -c iwe -n "__fish_iwe_using_subcommand attach" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand attach" -l list -d 'List configured attach actions'
complete -c iwe -n "__fish_iwe_using_subcommand attach" -l dry-run -d 'Preview without writing'
complete -c iwe -n "__fish_iwe_using_subcommand attach" -l quiet -d 'Suppress progress output'
complete -c iwe -n "__fish_iwe_using_subcommand attach" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand completions" -s v -l verbose -r
complete -c iwe -n "__fish_iwe_using_subcommand completions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "init" -d 'Initialize the current directory as an IWE project'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "new" -d 'Create a new document from a template'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "retrieve" -d 'Retrieve document content with expansion and context'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "find" -d 'Search and discover documents'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "count" -d 'Count documents matching a filter '
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "normalize" -d 'Normalize all markdown files in the project'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "tree" -d 'Display document hierarchy as a tree'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "squash" -d 'Consolidate linked documents into a single file'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "export" -d 'Export the graph structure in various formats'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "schema" -d 'Infer and display frontmatter schema'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "stats" -d 'Display graph statistics'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "rename" -d 'Rename a document and update all references to it'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "delete" -d 'Delete a document and clean up all references to it'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "extract" -d 'Extract a section to a new document with an inclusion link'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "inline" -d 'Replace an inclusion link with the referenced document content'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "update" -d 'Update document content or frontmatter'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "attach" -d 'Attach a document as a block reference via configured attach actions'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "completions" -d 'Generate shell completion script'
complete -c iwe -n "__fish_iwe_using_subcommand help; and not __fish_seen_subcommand_from init new retrieve find count normalize tree squash export schema stats rename delete extract inline update attach completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
