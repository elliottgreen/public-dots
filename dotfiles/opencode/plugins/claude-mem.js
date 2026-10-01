// Minimal OpenCode V2 claude-mem plugin.
// Preserves the search tool from the old bundled plugin. Session observation
// hooks from the old plugin need an upstream V2 migration before re-enabling.

function defaultBaseURL() {
  const uid = typeof process.getuid === "function" ? process.getuid() : 77
  const port = process.env.CLAUDE_MEM_SERVER_PORT ?? String(37877 + (uid % 100))
  return process.env.CLAUDE_MEM_SERVER_URL ?? `http://127.0.0.1:${port}`
}

function formatSearchResponse(text, query) {
  let parsed
  try {
    parsed = JSON.parse(text)
  } catch (error) {
    console.warn("[claude-mem] Failed to parse search results:", error instanceof Error ? error.message : String(error))
    return "Failed to parse claude-mem search results."
  }

  const content = parsed?.content
  if (!Array.isArray(content) || content.length === 0) return `No results found for "${query}".`

  const rendered = content
    .filter((item) => item?.type === "text" && typeof item.text === "string")
    .map((item) => item.text)
    .join("\n")
    .trim()

  return rendered || `No results found for "${query}".`
}

export default {
  id: "local.claude-mem",
  async setup(ctx) {
    await ctx.tool.transform((editor) => {
      editor.add({
        name: "claude_mem_search",
        description: "Search the claude-mem memory database for past observations, sessions, and context.",
        input: {
          type: "object",
          properties: {
            query: {
              type: "string",
              description: "Search query for memory observations.",
            },
          },
          required: ["query"],
          additionalProperties: false,
        },
        execute: async ({ query }, context) => {
          const search = String(query ?? "").trim()
          if (!search) return { content: "Please provide a search query." }

          const url = new URL("/api/search/observations", defaultBaseURL())
          url.searchParams.set("query", search)
          url.searchParams.set("limit", "10")

          let response
          try {
            response = await fetch(url, {
              signal: context.signal,
              headers: process.env.CLAUDE_MEM_SERVER_BETA_API_KEY
                ? { Authorization: `Bearer ${process.env.CLAUDE_MEM_SERVER_BETA_API_KEY}` }
                : undefined,
            })
          } catch {
            return { content: "claude-mem worker is not running. Start it with: npx claude-mem start" }
          }

          if (!response.ok) {
            return { content: `claude-mem search failed: HTTP ${response.status} ${response.statusText}` }
          }

          return { content: formatSearchResponse(await response.text(), search) }
        },
      })
    })
  },
}
