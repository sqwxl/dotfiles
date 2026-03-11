# Coding Principles

- Always apply grugbrain principles (i.e. keep it simple, stupid)
- Don't write tests for log output.
- When a function starts taking too many parameters (>4), consider passing an object instead.
- Prefer functional, stateless functions for most things
- Prefer declarative interfaces and imperative implementation

# Git

- Write short commit messages in conventional commit syntax.
- Keep commit messages to one line, unless a verbose explanation is warranted.

# TypeScript/JavaScript

- Prefer `type` over `inteface` unless you really need `extends` or `implements`
- Avoid using `null` or `undefined` to describe explicit unavailability
- Prefer `undefined` for empty returns (i.e., avoid `return null`, unless it's expected by an API)
- Use truthy check for objects being `null` or `undefined` (i.e. `if (error)`)
- Use `== null`/`!== null` to check for `null`/`undefined` on primitives
- Avoid using `as` type casts, these usually indicate a type system gap
- Never use `as unknown` unless absolutely necessary
- Avoid `export default`, use simple exports
- Annotate arrays as `foos: Foo[]` instead of `foo: Array<Foo>`
- Name files using kebab-case
- Generally avoid the `if (cond) result;` shorthand; always use brackets: `if (cond) { result; }`

# Web search

- Use Firecrawl MCP for most web searches, especially when consulting technical docs
