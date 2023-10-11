# WeKan Node.js 20, Bun and Deno

- SE = Single Executeable at https://github.com/wekan/wekan-node20/releases
- Runs = Does run, but no Single Executeable

Features | Node.js 20 | Bun | Deno | Details
------------ | ------------- | ------------- | ------------- | -------------
Single Executeable | [TODO](https://nodejs.org/dist/latest-v20.x/docs/api/single-executable-applications.html) | [Yes](https://bun.sh/docs/bundler/executables) | [Yes](https://docs.deno.com/runtime/manual/tools/compiler). Deno can crosscompile some binaries. |
Production use | Yes, has [traceability](https://changelog.com/jsparty/294) and [many CPU/OS](https://nodejs.org/dist/) | No | No | 
Linux amd64 | Runs | SE 92.1 MB | SE 365 MB. "Node.js compatibility layer" includes Node.js, so binaries are bigger. |
Linux arm64 | Runs | SE 84.4 MB | SE 1.35 GB [Too big size is bug](https://github.com/denoland/deno/issues/1846) | https://github.com/wekan/wekan/wiki/Raspberry-Pi
Linux s390x | Runs | [No](https://github.com/oven-sh/bun/issues/2632). So trying: Compile LLVM, to compile Zig, to compile Bun | [No](https://github.com/denoland/deno/issues/20212) | https://github.com/wekan/wekan/wiki/s390x
Windows amd64 | Runs | No | SE 324 MB | https://github.com/wekan/wekan/wiki/Offline
Mac amd64 | Runs | No. "Your shell is running in Rosetta 2. Downloading bun for darwin-aarch64 instead" | SE 348 MB | https://github.com/wekan/wekan/wiki/Mac
Mac arm64 | Runs | SE 49.9 MB | SE 345 MB | https://github.com/wekan/wekan/wiki/Mac

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
