import { MongoClient, Db } from "mongodb";

let mongoDb: Db;

export async function connectToDatabase() {
  try {
    const url = process.env.DB_URI!; // Use the DB_URI from environment variables
    const client = new MongoClient(url);
    await client.connect();
    mongoDb = client.db(); // If your DB name is in the URI, this will use it
    console.log("✅ MongoDB database connected successfully");
  } catch (error) {
    console.error("❌ MongoDB connection failed:", error);
    process.exit(1); // Stop the server if DB connection fails
  }
}

export function getDataBase(): Db {
  if (!mongoDb) {
    throw new Error("Database not connected. Call connectToDatabase() first.");
  }
  return mongoDb;
}
