import { tool } from '@opencode-ai/plugin'
import spawnHelp from './spawn.txt'
import readHelp from './read.txt'
import writeHelp from './write.txt'
import listHelp from './list.txt'
import killHelp from './kill.txt'

const OVERVIEW = `opencode-pty provides interactive background terminal sessions.

Use pty_spawn to start a session, pty_read to inspect output, pty_write to send input,
pty_list to find sessions, and pty_kill to stop or clean them up.

Call pty_help with a specific topic before using unfamiliar PTY features.`

const TOPICS = {
  overview: OVERVIEW,
  spawn: spawnHelp,
  read: readHelp,
  write: writeHelp,
  list: listHelp,
  kill: killHelp,
  notifications: `${spawnHelp}\n\n${readHelp}`,
  timeouts: `${spawnHelp}\n\n${readHelp}`,
}

type HelpTopic = keyof typeof TOPICS

export const ptyHelp = tool({
  description: 'Load detailed usage guidance for opencode-pty tools.',
  args: {
    topic: tool.schema
      .enum(['overview', 'spawn', 'read', 'write', 'list', 'kill', 'notifications', 'timeouts'])
      .optional()
      .describe('Which PTY help topic to load'),
  },
  async execute(args) {
    const topic: HelpTopic = args.topic ?? 'overview'
    return [`<pty_help topic="${topic}">`, TOPICS[topic], `</pty_help>`].join('\n')
  },
})
