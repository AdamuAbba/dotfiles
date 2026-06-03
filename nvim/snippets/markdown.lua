local snippets = {}

-- Code block snippets
local languages = {
  "txt",
  "lua",
  "sql",
  "go",
  "regex",
  "bash",
  "markdown",
  "markdown_inline",
  "yaml",
  "json",
  "jsonc",
  "cpp",
  "csv",
  "java",
  "javascript",
  "python",
  "dockerfile",
  "html",
  "css",
  "templ",
  "php",
}

for _, lang in ipairs(languages) do
  table.insert(snippets, {
    prefix = ";" .. lang,
    desc = lang .. " codeblock",
    body = "```" .. lang .. "\n$1\n```",
  })
end

-- Callout snippets
local callouts = { "note", "bug", "tip", "important", "warning", "caution", "todo" }

for _, callout in ipairs(callouts) do
  table.insert(snippets, {
    prefix = ";" .. callout,
    desc = callout .. " callout",
    body = "> [!" .. callout:upper() .. "]\n> - ${1:first item}",
  })
end

-- Dream template
table.insert(snippets, {
  prefix = ";dreamtemplate",
  desc = "Dream template with frontmatter",
  body = table.concat({
    "---",
    "title: ${1:${TM_FILENAME_BASE/[-]/ /g}}",
    "date: ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}T${CURRENT_HOUR}:${CURRENT_MINUTE}:${CURRENT_SECOND}",
    "tags:",
    "  - dream",
    "location: Abuja, Nigeria",
    "---",
    "",
    "## Narration",
    "",
  }, "\n"),
})

-- Blog post template
table.insert(snippets, {
  prefix = ";blogposttemplate",
  desc = "Blog post template with frontmatter",
  body = table.concat({
    "---",
    "title: ${1:${TM_FILENAME_BASE/[-]/ /g}}",
    "description: $2",
    "draft: false",
    "image:",
    "  path: ../path/to/image.png",
    "date: ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}T${CURRENT_HOUR}:${CURRENT_MINUTE}:${CURRENT_SECOND}",
    "author: ",
    "category:[]",
    "tags:[]",
    "---",
    "## Contents",
    "",
    "### Table of contents",
    "",
    "<!--toc:start-->",
    "",
    "<!--toc:end-->",
    "",
    "## Pre-requisites",
    "",
    "- List any here",
    "",
  }, "\n"),
})

return snippets
