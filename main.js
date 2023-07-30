const { MongoClient: MongoClientLegacy } = require("mongodb-legacy");
const { MongoClient } = require("mongodb");
// Replace the placeholder with your Atlas connection string
// FerretDB: const uri = "mongodb://127.0.0.1:27010/wekan";

// MongoDB 3.2.22:
const legacydbname = "wekan";
const legacycollectionname = "users";
//const uri = "mongodb://127.0.0.1:27017/wekan";
const legacyuri = "mongodb://127.0.0.1:27019";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const legacyclient = new MongoClientLegacy(legacyuri);

// MongoDB 6.x:
const dbname = "meteor";
const collectionname = "users";
const uri = "mongodb://127.0.0.1:4001";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(uri);

// FerretDB PostgreSQL:
const ferretdbname = "wekan";
const ferretcollectionname = "users";
const ferreturi = "mongodb://127.0.0.1:27010";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const ferretclient = new MongoClient(ferreturi);

// FerretDB SQLite:
const sqlitedbname = "wekan";
const sqlitecollectionname = "users";
const sqliteuri = "mongodb://127.0.0.1:27017";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const sqliteclient = new MongoClient(sqliteuri);

async function run() {
  try {
    // MongoDB 3.2.22:
    // Connect the client to the server (optional starting in v4.7)
    await legacyclient.connect();
    // Send a ping to confirm a successful connection
    await legacyclient.db(legacydbname).command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB 3.x!");
    const legacydatabase = legacyclient.db(legacydbname);
    const legacyquery = {};
    const legacyoptions = {};
    const legacyusers = legacydatabase.collection(legacycollectionname);
    const legacyuser = await legacyusers.findOne(legacyquery, legacyoptions);
    console.log(legacyuser);

    // MongoDB 6.x:
    // Connect the client to the server (optional starting in v4.7)
    await client.connect();
    // Send a ping to confirm a successful connection
    await client.db(dbname).command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB 6.x!");
    const database = client.db(dbname);
    const query = {};
    const options = {};
    const users = database.collection(collectionname);
    const user = await users.findOne(query, options);
    console.log(user);

    // FerretDB PostgreSQL:
    // Connect the client to the server (optional starting in v4.7)
    await ferretclient.connect();
    // Send a ping to confirm a successful connection
    await ferretclient.db(ferretdbname).command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to FerretDB PostgreSQL!");
    const ferretdatabase = ferretclient.db(ferretdbname);
    const ferretquery = {};
    const ferretoptions = {};
    const ferretusers = ferretdatabase.collection(ferretcollectionname);
    const ferretuser = await ferretusers.findOne(ferretquery, ferretoptions);
    console.log(ferretuser);

    // FerretDB SQLite:
    // Connect the client to the server (optional starting in v4.7)
    await sqliteclient.connect();
    // Send a ping to confirm a successful connection
    await sqliteclient.db(sqlitedbname).command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to FerretDB SQLiteDB!");
    const sqlitedatabase = sqliteclient.db(sqlitedbname);
    const sqlitequery = {};
    const sqliteoptions = {};
    const sqliteusers = sqlitedatabase.collection(sqlitecollectionname);
    const sqliteuser = await sqliteusers.findOne(sqlitequery, sqliteoptions);
    console.log(sqliteuser);

  } finally {
    // Ensures that the client will close when you finish/error
    await legacyclient.close();
    await client.close();
    await ferretclient.close();
    await sqliteclient.close();
  }
}
run().catch(console.dir);
