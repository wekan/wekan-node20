# WeKan Node.js 20, Bun and Deno

- SE = Single Executeable
- CX = CrossCompile
- Runs = Does run, but no Single Executeable
- main.js with all dependencies to Single Executeable to https://github.com/wekan/wekan-node20/releases

Features | Node.js 20 | Bun | Deno
------------ | ------------- | ------------- | -------------
Single Executeable | [TODO](https://nodejs.org/dist/latest-v20.x/docs/api/single-executable-applications.html) | [90MB](https://bun.sh/docs/bundler/executables) | [350MB](https://docs.deno.com/runtime/manual/tools/compiler)
Linux amd64 | Runs | SE 93.3 MB | SE 365 MB 
Linux arm64 | Runs | SE 85.1 MB | SE 1.35 GB
Linux s390x | Runs | No | [No](https://github.com/denoland/deno/issues/20212)
Windows amd64 | Runs | No | SE 324 MB
Mac amd64 | Runs | No | SE 348 MB
Mac arm64 | Runs | No | SE 345 MB

# Databases

- MongoDB 3.x
- MongoDB 6.x
- FerretDB PostgreSQL
- FerretDB SQLite
- PostgreSQL
- SQLite

# Databases, maybe later

- MySQL
- MSSQL
- Oracle
