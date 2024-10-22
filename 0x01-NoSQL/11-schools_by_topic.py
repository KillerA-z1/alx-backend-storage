#!/usr/bin/env python3
""" MongoDB Operations with Python using pymongo """


def schools_by_topic(mongo_collection, topic):
    """
    Returns the list of schools having a specific topic.

    Parameters:
        mongo_collection : The pymongo collection object.
        topic (str): The topic to search for.

    Returns:
        list: A list of schools having the specific topic.
    """
    documents = mongo_collection.find({"topics": topic})
    return list(documents)
