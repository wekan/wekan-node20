# WeKan Node.js 20, Bun and Deno

- SE = Single Executeable
- CX = CrossCompile
- Runs = Does run, but no Single Executeable
- main.js with all dependencies to Single Executeable to https://github.com/wekan/wekan-node20/releases
- Deno "Node.js compatibility layer" includes Node.js, so binaries are bigger. Source: https://changelog.com/jsparty/294

Features | Node.js 20 | Bun | Deno
------------ | ------------- | ------------- | -------------
Single Executeable | [TODO](https://nodejs.org/dist/latest-v20.x/docs/api/single-executable-applications.html) | [Yes](https://bun.sh/docs/bundler/executables) | [Yes](https://docs.deno.com/runtime/manual/tools/compiler)
Linux amd64 | Runs | SE 93.3 MB | SE 365 MB 
Linux arm64 | Runs | SE 85.1 MB | SE 1.35 GB
Linux s390x | Runs | No | [No](https://github.com/denoland/deno/issues/20212)
Windows amd64 | Runs | No | SE 324 MB
Mac amd64 | Runs | No | SE 348 MB
Mac arm64 | Runs | No | SE 345 MB

# Database drivers at main.js

- MongoDB 3.x, to be compatible with WeKan Snap Stable migrations, and https://sandstorm.io MongoDB 3.0
- MongoDB 6.x, to be compatible with newest Meteor
- FerretDB
  - FerretDB is MongoDB 6.x wire protocol compatible proxy to PostgreSQL or SQLite. Replaces MongoDB.
  - Improve compatibility with real specific apps and libraries https://github.com/FerretDB/FerretDB/issues/5
  - FerretDB WeKan issue https://github.com/FerretDB/FerretDB/issues/1752
  - At this repo docker-compose.yml:
    - FerretDB PostgreSQL
    - FerretDB SQLite
- PostgreSQL
- SQLite

# Database drivers, maybe later

- MySQL
- MSSQL
- Oracle

# Database abstraction layers

- Generating database queries from same syntax to many different database syntax
- If using ot is improvement, not too much size or slowness added
- Those that also support CloudFlare D1 SQLite database
  - Kysely, at bottom of page https://github.com/wekan/wekan/wiki/WeKan-Multiverse-Roadmap
  - Or others at https://developers.cloudflare.com/d1/platform/community-projects/
