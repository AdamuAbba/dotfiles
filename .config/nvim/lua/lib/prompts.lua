local prompts = {
  {
    name = "docs",
    description = "Generate documentation",
    details = "Please add documentation comments to the selected code.",
    prompt = [[
Add clear and concise documentation comments to the selected code.

- Describe the purpose and behavior of each function, class, or module.  
- Include parameter and return value details where applicable.  
- Follow consistent formatting and style conventions.
]],
  },
  {
    name = "explain",
    description = "Explain code logic",
    details = "Explain the purpose, logic flow, and algorithms used within the code",
    prompt = [[
Provide a detailed explanation of this code.

- Describe its overall purpose and functionality.  
- Break down the logic flow step by step.  
- Explain any algorithms, patterns, or key decisions used in the implementation.
]],
  },
  {
    name = "fix",
    description = "Fix code issues",
    details = "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.",
    prompt = [[
Analyze the following code for bugs, errors, or bad practices.

- Identify all issues and explain their causes.  
- Rewrite the code with the necessary fixes and improvements.  
- Clearly describe what was wrong and how your changes resolve each problem.
]],
  },
  {
    name = "commit",
    description = "Generate commit message",
    details = "Write commit message for the change with commitizen convention",
    prompt = [[
Generate a commit message following the Commitizen convention.

- Keep the title under 50 characters.
- Wrap the body at 72 characters.
- Format the result as a `gitcommit` code block.
- Do **not** commit any code — only provide the message.
- Review the entire staged diff across the repository (not just this file) to ensure accuracy.
- Include a list of all staged files before the message.
]],
  },
  {
    name = "optimize",
    description = "Optimize code",
    details = "Improve performance, readability, and maintainability of the code",
    prompt = "Optimize this code for better performance, readability, and maintainability.",
  },
  {
    name = "review",
    description = "Review code",
    details = "Evaluate the code for best practices, potential issues, and suggest improvements",
    prompt = [[
Review the following code thoroughly.

- Evaluate adherence to best practices and coding standards.  
- Identify potential bugs, security risks, or performance issues.  
- Suggest clear, actionable improvements to enhance quality and maintainability.
]],
  },
  {
    name = "tests",
    description = "Generate unit tests",
    details = "Write comprehensive unit tests covering all edge cases and error scenarios",
    prompt = [[
Write comprehensive unit tests for this code.

- Cover all functions, branches, and edge cases.  
- Include tests for invalid inputs and error scenarios.  
- Ensure the tests are clear, maintainable, and demonstrate expected behavior.
]],
  },
}

---Returns a function that inserts the named prompt at cursor position
---@param prompt_name string Name of the prompt to insert
---@return function Function to execute in a keybinding
prompts.add_prompt = function(prompt_name)
  local prompt_text = prompts[prompt_name]
  return function()
    vim.cmd("put ='" .. prompt_text:gsub("'", "''") .. "'")
  end
end

return prompts
