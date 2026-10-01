export default {
  id: "local.custom-compaction",
  setup(ctx) {
    ctx.session.hook("compaction", (event) => {
      event.system.push({
        type: "text",
        text: `You are generating a continuation prompt for a multi-agent swarm session.

When summarizing, include:
1. The current task and its status
2. Which files are being modified and by whom
3. Any blockers or dependencies between agents
4. The next steps to complete the work

Format the result as a structured prompt that a new agent can use to resume work.`,
      })
    })
  },
}
