#!/usr/bin/env python3
"""
Web cache and access tracker
"""

import requests
import redis
from functools import wraps
from typing import Callable


def track_url_access(func: Callable) -> Callable:
    """Decorator to track URL access count and cache the page content"""

    @wraps(func)
    def wrapper(url: str) -> str:
        """
        Wrapper that:
        1. Checks if URL is cached
        2. Increments access counter
        3. Caches new content with expiration
        """
        redis_client = redis.Redis()
        cache_key = f"cached:{url}"
        count_key = f"count:{url}"

        # Increment the access counter for this URL
        redis_client.incr(count_key)

        # Try to get cached content
        cached_content = redis_client.get(cache_key)
        if cached_content:
            return cached_content.decode("utf-8")

        # If not cached, fetch the page
        content = func(url)  # Use func instead of method

        # Cache the new content with 10-second expiration
        redis_client.setex(cache_key, 10, content)

        return content

    return wrapper


@track_url_access
def get_page(url: str) -> str:
    """
    Get the HTML content of a URL

    Args:
        url: The URL to fetch

    Returns:
        str: The HTML content of the page

    Note:
        - Result is cached for 10 seconds
        - Number of access attempts is tracked
    """
    response = requests.get(url)
    return response.text
