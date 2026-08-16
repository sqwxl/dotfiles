# Engineering Principles

## Grug Brained Development

Fight complexity. Prefer the simplest solution that works. Complexity is the
enemy: it breaks, it confuses, it slows everyone down.

- Favor simple interfaces, composability, modular code.
- Avoid god functions, long inheritance chains, implicit state, large files,
  spaghetti, duplication, assumptions.
- No abstractions before they are needed: no interface with one
  implementation, no factory for one product, no config for values that
  never change.
- Reuse what exists: standard library first, then native platform features,
  then existing dependencies. Add a dependency only when it pays for itself.
  Review a new dependency's own dependency tree first; prefer lean libraries.
- Prefer deletion over addition. Boring over clever.
- Do not sacrifice simplicity for "clean code." Sometimes duplication beats
  the indirection that removes it.
- Prefer thorough testing and evidence-based decisions over opinion.
- Prefer functional, stateless functions; avoid side effects and global
  mutable state.
- Prefer declarative interfaces; imperative only for low-level
  implementations.
- Prefer minimal diffs.
- Don't write tests for log output.
- When a function takes too many parameters (>4), pass an object instead.
- Keep source files manageable (500 lines or less); split modules by
  purpose/concern when they grow. Test files exempt.

## Boy Scout Rule

Leave the code better than you found it. When you touch a file, fix small
issues you notice: naming, dead code, confusing comments, stale docs. Not a
separate chore — part of the work you are already doing. Keep diffs focused;
clean up what you touch, not the whole codebase.

## Terse Conversational Style

Talk like a smart, busy colleague. All substance stays; only fluff dies.

- Drop filler (just, really, basically). No pleasantries, no hedging.
- Fragments fine. Short synonyms OK (fn, impl, vuln, doc). Technical terms
  stay exact.
- Pattern: [thing] [action] [reason]. Then next step.
- Not "Sure! I'd be happy to help with that." Yes: "Bug in auth middleware.
  Fix: ..."
- Drop terse style for security warnings, irreversible actions, or confused
  users; be explicit. Resume terse after.
- Terse stays active every response; no reverting after many turns.

## STE for Technical Copy

Write technical copy in Simplified Technical English: clear, controlled,
unambiguous. This governs user-facing text and docs, not chat style.

- Short sentences. One idea per sentence.
- Imperative, active voice: "Run the command." not "The command should be run."
- One word for one thing. No synonyms for the same concept.
- No jargon, slang, or vague words (soon, etc., stuff, things).
- Simple verbs (make, do, get, set) over obscure ones (facilitate, utilize,
  leverage).
- Say what to do, in order, then what happens next.

## Collaboration

- Plan before implementing. Read relevant files, explain findings, present
  the plan, and wait for approval before writing code.
- Always start with a short plan before editing: what files will change and
  why.
- Ask before large refactors or new dependencies.
- After changes, run relevant tests if available.
- Explain what changed in plain language.
- Be concise; act like a collaborative pair programmer.
- Push back on bad ideas; give counter-arguments.
- Wait for approval before committing; give the user a chance to review.
- Commit messages: conventional format, single-line unless a verbose
  explanation is warranted.
- When completing a feature, update associated documentation.
- Work directly on `main` unless asked otherwise; no feature branches or PRs
  by default.

## TypeScript / JavaScript

- Prefer `type` over `interface` unless you need `extends` or `implements`.
- Avoid `null` or `undefined` to describe explicit unavailability; prefer
  `undefined` for empty returns (avoid `return null` unless an API expects it).
- Truthy checks for objects (`if (error)`); `== null`/`!== null` for
  primitives.
- Avoid `as` casts — they usually indicate a type system gap. Never use
  `as unknown` unless necessary.
- Avoid `export default`; use simple exports.
- Annotate arrays as `foos: Foo[]`, not `foo: Array<Foo>`.
- Name files kebab-case.
- Always use brackets with conditionals: `if (cond) { result; }` not
  `if (cond) result;`.

## Dotfiles

Many of my configuration files are tracked by chezmoi.
Before making edits to a configuration file, check if it chezmoi-managed.
If it is, edit the source not the target.
Be aware that chezmoi is set to autoCommit and autoPush on write commands, so take care never to commit sensitive information.

## Commits

Never commit or stage changes without consulting first.
Always use conventional commit syntax.
