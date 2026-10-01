// graphify OpenCode plugin
// Adds a lightweight reminder when a repository already has graphify output.
import { existsSync } from "node:fs"
import { join } from "node:path"

const reminder =
  "[graphify] This project has a knowledge graph at graphify-out/. " +
  'For focused architecture/file-relationship questions, prefer `graphify query "<question>"` ' +
  "for a scoped subgraph instead of grepping raw files. Read GRAPH_REPORT.md only for broad architecture context."

export default {
  id: "local.graphify-reminder",
  setup(ctx) {
    ctx.session.hook("context", (event) => {
      if (!existsSync(join(ctx.location.directory, "graphify-out", "graph.json"))) return
      event.system.push({ type: "text", text: reminder })
    })
  },
}
