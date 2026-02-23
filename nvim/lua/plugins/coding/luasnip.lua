return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local f = ls.function_node
      local i = ls.insert_node
      -- Custom snippets
      -- the "all" after ls.add_snippets("all" is the filetype, you can know a
      -- file filetype with :set ft
      -- Custom snippets

      -- #####################################################################
      --                            Markdown
      -- #####################################################################

      -- Helper function to create code block snippets
      local function create_code_block_snippet(lang)
        return s({
          trig = ";" .. lang,
          name = "Codeblock",
          desc = lang .. " codeblock",
        }, {
          t({ "```" .. lang, "" }),
          i(1),
          t({ "", "```" }),
        })
      end

      -- Define languages for code blocks
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

      -- Generate snippets for all languages
      local snippets = {}

      for _, lang in ipairs(languages) do
        table.insert(snippets, create_code_block_snippet(lang))
      end

      local callouts = {
        "note",
        "tip",
        "important",
        "warning",
        "caution",
        "todo",
      }
      local function create_callout_snippet(callout)
        return s({
          trig = ";" .. callout,
          name = "callout block",
          dscr = "Insert a " .. callout .. " callout",
        }, {
          t({
            "> [!" .. callout:upper() .. "]",
            "> - ",
          }),
          i(1, "first item"),
        })
      end
      for _, callout in ipairs(callouts) do
        table.insert(snippets, create_callout_snippet(callout))
      end

      -- dream template snippet
      table.insert(
        snippets,
        s({
          trig = ";dreamtemplate",
          name = "Insert dream template",
          desc = "Insert dream template with frontmatter and sections",
        }, {
          t({
            "---",
            "title:'' ",
          }),
          f(function()
            return vim.fn.expand("%:t:r"):gsub("%-", " ")
          end, {}),
          t({
            "",
            "date: ",
          }),
          f(function()
            return os.date("%Y-%m-%dT%H:%M:%S")
          end, {}),
          t({
            "",
            "tags:",
            "  - dream",
            "location: Abuja, Nigeria",
            "---",
            "",
            "## Narration",
            "",
          }),
        })
      )
      -- Blog post template snippet
      table.insert(
        snippets,
        s({
          trig = ";blogposttemplate",
          name = "Insert blog post template",
          desc = "Insert blog post template with frontmatter and sections",
        }, {
          t({
            "---",
            "title: ",
          }),
          f(function()
            return vim.fn.expand("%:t:r"):gsub("%-", " ")
          end, {}),
          t({
            "",
            "description: ",
          }),
          t({
            "",
            "draft: false",
          }),
          i(2, ""),
          t({
            "",
            "image:",
            "  path: ../path/to/image.png",
          }),
          t({
            "",
            "date: ",
          }),
          f(function()
            return os.date("%Y-%m-%dT%H:%M:%S")
          end, {}),
          t({
            "",
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
          }),
        })
      )

      ls.add_snippets("markdown", snippets)

      return opts
    end,
  },
}
