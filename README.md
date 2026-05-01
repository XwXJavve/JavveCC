# JavveCC

XwXJavve's Claude Code marketplace — personal config, plugins, MCP servers, skills, hooks, and commands.

## Installation

### Via slash commands (recommended)

From GitHub:

```
/plugin marketplace add XwXJavve/JavveCC
/plugin install dev-kit@JavveCC
```

### Via settings.json

Add the marketplace and enable the plugin in `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "JavveCC": {
      "source": {
        "source": "github",
        "repo": "XwXJavve/JavveCC"
      }
    }
  },
  "enabledPlugins": {
    "dev-kit@JavveCC": true
  }
}
```

### Local load

```bash
cc --plugin-dir /path/to/JavveCC/plugins/dev-kit
```

## Plugins

| Plugin | Version | Description |
|--------|---------|-------------|
| [dev-kit](plugins/dev-kit) | 0.1.1 | Dev toolkit: Tavily MCP, deep-research, explain-code, better-search hooks |

## Author

[XwXJavve](https://github.com/XwXJavve)
