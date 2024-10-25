#!/usr/bin/env python3
"""
Web caching and tracking with Redis
"""

import requests
import redis
from typing import Callable
from functools import wraps

# Initialize Redis client
redis_client = redis.Redis()

def cache_page(method: Callable) -> Callable:
    """
    Decorator to cache the result of a function and track access count

    Args:
        method: The method to be decorated

    Returns:
        Callable: The wrapped method
    """
    @wraps(method)
    def wrapper(url: str) -> str:
        """Wrapper function to cache the result and track access count"""
        cache_key = f"count:{url}"
        cached_content = redis_client.get(url)

        if cached_content:
            return cached_content.decode('utf-8')

        # Track access count
        redis_client.incr(cache_key)

        # Get the HTML content and cache it
        response = method(url)
        redis_client.setex(url, 10, response)

        return response

    return wrapper

@cache_page
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

# Example usage
if __name__ == "__main__":
    url = "http://slowwly.robertomurray.co.uk/delay/5000/url/http://www.example.com"
    print(get_page(url))
    print(get_page(url))
    print(get_page(url))

    # Check the access count
    count = redis_client.get(f"count:{url}")
    print(f"URL accessed {count.decode('utf-8')} times.")
