generate = require './lib/generate'

firstCommit = process.argv[2] || 'HEAD'
secondCommit = process.argv[3] || ''

projectName = ""
