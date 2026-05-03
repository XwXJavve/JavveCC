# JavveCC

XwXJavve's Claude Code marketplace — personal config, plugins, MCP servers, skills, hooks, and commands.

## Installation

Plugins can be installed directly from this marketplace via Claude Code's plugin system.

First, add the marketplace:

```
/plugin marketplace add XwXJavve/JavveCC
```

Then install a plugin:

```
/plugin install {plugin-name}@JavveCC
```

or browse for the plugin in `/plugin > Discover`

## Plugins

| Plugin | Version | Description |
|--------|---------|-------------|
| [dev-kit](plugins/dev-kit) | 0.1.1 | Dev toolkit: Tavily MCP, deep-research, explain-code, better-search hooks |
| [pm-harness](plugins/pm-harness) | 0.2.0 | Project memory harness — cross-session knowledge base, troubleshooting & decision tracking |

## Config Usage

The `.claude-config/` directory contains shared configuration you can mix into your own setup:

```
.claude-config/
├── settings.example.json      # Starter config: plugins + safe read-only permissions
└── rules/                     # Reusable project-agnostic rules
    ├── better-search.md        # Forces Tavily MCP for search, curl for fetch
    ├── karpathy-guidelines.md  # Anti-overengineering, surgical changes, verifiable goals
    ├── python-dev.md           # Python toolchain and conventions
    └── typescript-dev.md       # TypeScript toolchain and conventions
```

**Quick setup — paste this into Claude Code:**

```
I want to set up Claude Code config from https://github.com/XwXJavve/JavveCC. Read the .claude-config/ directory and:
1. Copy the rules/ files to my ~/.claude/rules/ (skip any that already exist)
2. Set ~/.claude/settings.json to the content of .claude-config/settings.example.json
```
(Claude will auto-install the enabledPlugins and apply the safe permissions)

## Author

[XwXJavve](https://github.com/XwXJavve)
