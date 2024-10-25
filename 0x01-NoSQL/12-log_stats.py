#!/usr/bin/env python3
""" Provides some stats about Nginx logs stored in MongoDB """

from pymongo import MongoClient

def log_stats(mongo_collection):
    """ Function that provides stats about Nginx logs stored in MongoDB """
    # Count total number of documents in the collection
    total_logs = mongo_collection.count_documents({})
    print(f"{total_logs} logs")
    
    # Count number of documents for each HTTP method
    print("Methods:")
    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    for method in methods:
        count = mongo_collection.count_documents({"method": method})
        print(f"\tmethod {method}: {count}")
    
    # Count number of documents with method=GET and path=/status
    status_check = mongo_collection.count_documents({"method": "GET", "path": "/status"})
    print(f"{status_check} status check")

if __name__ == "__main__":
    # Connect to MongoDB and get the collection
    client = MongoClient('mongodb://127.0.0.1:27017')
    nginx_collection = client.logs.nginx
    
    # Call the log_stats function to print the stats
    log_stats(nginx_collection)
