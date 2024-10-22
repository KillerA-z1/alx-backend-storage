#!/usr/bin/env python3
""" MongoDB Operations with Python using pymongo """


def update_topics(mongo_collection, name, topics):
    """
    Changes all topics of a school document based on the name.

    Parameters:
        mongo_collection : The MongoDB collection instance.
        name (str): The name of the school document to update.
        topics (list of str):The list of topics to set for the school document.

    Returns:
        None
    """
    query = {"name": name}
    new_values = {"$set": {"topics": topics}}

    mongo_collection.update_many(query, new_values)
