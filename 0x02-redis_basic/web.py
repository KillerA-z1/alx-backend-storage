#!/usr/bin/env python3
"""
Web cache and tracker with Redis
"""

import requests
import redis
from functools import wraps

# Initialize Redis client
redis_client = redis.Redis()


def cache_and_track(method):
    """Decorator to cache the result of a function and track access count.

    This decorator caches the HTML content fetched by the decorated method
    and tracks the number of times the URL has been accessed. The cached
    content is stored with an expiration time of 10 seconds.

        method (Callable): The method to be decorated.

        Callable: The wrapped method that caches the result and
        tracks access count.
    """
    @wraps(method)
    def wrapper(url: str) -> str:
        """Wrapper function to cache the result and track access count"""
        count_key = f"count:{url}"
        cached_html = redis_client.get(url)

        if cached_html:
            return cached_html.decode('utf-8')

        # Track access count
        redis_client.incr(count_key)

        # Get the HTML content and cache it
        html_content = method(url)
        redis_client.setex(url, 10, html_content)

        return html_content

    return wrapper


@cache_and_track
def get_page(url: str) -> str:
    """
    Get the HTML content of a URL

    Args:
        url: The URL to get the HTML content from

    Returns:
        str: The HTML content of the URL
    """
    response = requests.get(url)
    return response.text
