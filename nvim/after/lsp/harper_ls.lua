return {
  filetypes = { "markdown" },
  settings = {
    ["harper-ls"] = {
      userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
      linters = {
        SentenceCapitalization = false,
        SpellCheck = true,
        SpelledNumbers = false,
        AnA = true,
        UnclosedQuotes = true,
        WrongQuotes = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        Matcher = true,
        CorrectNumberSuffix = true,
        ToDoHyphen = false,
        AvoidCurses = false,
      },
      codeActions = {
        ForceStable = false,
      },
      markdown = {
        IgnoreLinkTitle = true,
      },
      diagnosticSeverity = "hint",
      isolateEnglish = true,
    },
  },
}
