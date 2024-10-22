#!/usr/bin/env python3
""" MongoDB Operations with Python using pymongo """


def list_all(mongo_collection):
    """
    List all documents in a MongoDB collection.

    Args:
        mongo_collection(pymongo.collection.Collection): The MongoDB collection
        object.

    Returns:
        list: list of all documents in the collection.If no documents found,
        returns an empty list.
    """
    documents = mongo_collection.find()
    return list(documents) if documents.count() > 0 else []
