#!/usr/bin/env python3
""" MongoDB Operations with Python using pymongo """


def top_students(mongo_collection):
    """
    Returns all students sorted by average score.

    Parameters:
        mongo_collection : The pymongo collection object.

    Returns:
        list: A list of students sorted by average score.
    """
    top_st = mongo_collection.aggregate([
        {
            "$project": {
                "name": "$name",
                "averageScore": {"$avg": "$topics.score"}
            }
        },
        {"$sort": {"averageScore": -1}}
    ])

    return list(top_st)
