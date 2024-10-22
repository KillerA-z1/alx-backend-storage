#!/usr/bin/env python3
"""

This module contains a function to perform MongoDB operations using pymongo.

Functions:
    insert_school(mongo_collection, **kwargs): Inserts a new document in a
    collection based on kwargs.
"""


def insert_school(mongo_collection, **kwargs):
    """ Inserts a new document in a collection based on kwargs """
    document_id = mongo_collection.insert(kwargs)
    return document_id
